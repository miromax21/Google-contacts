//
//  RequestObservable.swift
//  ContactsApp
//
//  Created by maxim mironov on 20.04.2020.
//  Copyright © 2020 maxim mironov. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Network
public struct RequestObservable {

  static let shared = RequestObservable()
  private var urlSession: URLSession

  public init(config:URLSessionConfiguration = URLSessionConfiguration.default) {
      urlSession = URLSession(configuration: config)
  }
    
  public func callAPI(request: URLRequest) -> Observable<Data?> {
      return Observable.create { observer in
        if Utils.shared.isInternetAvailable {
            observer.onError(RequestError.noInternet)
            observer.onCompleted()
        }
        let task = self.urlSession.dataTask(with: request) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse{
                let statusCode = httpResponse.statusCode
                if let error = error {
                    observer.onError(RequestError.sessionError(error: error))
                }
                if (200...399).contains(statusCode) {
                    observer.onNext(data)
                }
                else{
                    let taskError = NSError(domain: String(describing:type(of: self)), code: httpResponse.statusCode, userInfo:  nil)
                    observer.onError(RequestError.serverError(error: taskError))
                }
            }
             observer.onCompleted()
        }
            
        task.resume()
        return Disposables.create {
            task.cancel()
        }
    }.retry(2)
    }
}
