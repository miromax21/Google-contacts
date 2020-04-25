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

    fileprivate let cache = URLCache.shared
    fileprivate let cacheInterval:Double = 0.0

    public init(config:URLSessionConfiguration = URLSessionConfiguration.default) {
        urlSession = URLSession(configuration: config)
    }
    
    public func callAPI(request: URLRequest) -> Observable<Data?> {
        return Observable.create { observer in
            if Utils.shared.isInternetAvailable {
                observer.onNext(self.getDataFromCache(request: request))
                observer.onError(RequestError.noInternet)
                observer.onCompleted()
            }
            let task = self.urlSession.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    observer.onError(RequestError.sessionError(error: error))
                }
                if let httpResponse = response as? HTTPURLResponse{
                    let statusCode = httpResponse.statusCode
                    if (200...399).contains(statusCode) {
                        guard let data = data, let resp = response  else { return observer.onNext(nil)}
                        let cachedData = CachedURLResponse(response: resp, data: data)
                        self.setDataToCache(cachedData: cachedData, for: request)

                        observer.onNext(data)
                    }
                    else{
                        let taskError = NSError(domain: String(describing:type(of: self)), code: statusCode, userInfo:  nil)
                        observer.onError(RequestError.serverError(error: taskError))
                    }
                }
                 observer.onCompleted()
            }
            
            Timer.scheduledTimer(withTimeInterval: self.cacheInterval, repeats: false) { timer in
                observer.onNext(self.getDataFromCache(request: request))
                observer.onCompleted()
                task.cancel()
            }.fire()
            
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    fileprivate func getDataFromCache(request: URLRequest) -> Data?{
        return self.cache.cachedResponse(for: request)?.data
    }
    
    fileprivate func setDataToCache(cachedData:CachedURLResponse, for request: URLRequest){
        self.cache.storeCachedResponse(cachedData, for: request)
    }
}
