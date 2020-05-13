//
//  AlamofireRequest.swift
//  ContactsApp
//
//  Created by maxim mironov on 29.04.2020.
//  Copyright © 2020 maxim mironov. All rights reserved.
//
import RxAlamofire
import Foundation
import RxSwift
class AlamofireRequest: Api {
    
    fileprivate let cache = URLCache.shared
    fileprivate let cacheInterval:Double = 7.0
    
    public func callAPI<T:Decodable>(request: URLRequest) -> Observable<T?>  {
        
        return RxAlamofire
            .requestJSON(request)
            .debug()
            .mapObject(type: T.self)
            .asObservable()
    }
    
    
    fileprivate func getDataFromCache(request: URLRequest) -> Data?{
        return self.cache.cachedResponse(for: request)?.data
    }
    
    fileprivate func setDataToCache(cachedData:CachedURLResponse, for request: URLRequest){
        self.cache.storeCachedResponse(cachedData, for: request)
    }
}
extension ObservableType {

    public func mapObject<T: Decodable>(type: T.Type) -> Observable<T?> {
        return flatMap { data -> Observable<T?> in
           guard
               let responseTuple = data as? (HTTPURLResponse, AnyObject),
               let jsonData = try? JSONSerialization.data(withJSONObject: responseTuple.1, options: [JSONSerialization.WritingOptions.prettyPrinted])
           else {
                return Observable.error(RequestError.noData)
           }
            
            let httpResponse = responseTuple.0
            let statusCode = httpResponse.statusCode
            if (200...399).contains(statusCode) {
                let decoder = JSONDecoder()
                let object = try decoder.decode(T.self, from: jsonData)
                return Observable.just(object)
            }
            else{
                let taskError = NSError(domain: "", code: statusCode, userInfo:  nil)
                return Observable.error(RequestError.serverError(error: taskError))
            }
        }
    }
   
}
