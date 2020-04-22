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

public struct RequestObservable {
    
  private var urlSession: URLSession
  static let shared = RequestObservable()
    
  public init(config:URLSessionConfiguration = URLSessionConfiguration.default) {
      urlSession = URLSession(configuration: config)
  }
    
  public func callAPI(request: URLRequest) -> Observable<Data?> {
      return Observable.create { observer in
        let task = self.urlSession.dataTask(with: request) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse{
                let statusCode = httpResponse.statusCode
                if (200...399).contains(statusCode) {
                    observer.onNext(data)
                }else if let error = error {
                    observer.onError(error)
                }else{
                    observer.onError(NSError(domain: request.url?.absoluteString ?? "", code: httpResponse.statusCode, userInfo:  nil))
                }
            }
             observer.onCompleted()
        }
            
        task.resume()
        return Disposables.create {
            task.cancel()
        }
       }
    }
}
