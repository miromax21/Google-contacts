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
class AlamofireRequest {
    public func callAPI<T:Decodable>(request: URLRequest) -> Observable<T?>  {
        return RxAlamofire
            .requestJSON(request)
            .debug()
            .catchError { error in
                print(error)
                return Observable.never()
            }
        .mapObject(type: T.self)
        .asObservable()



    }
}
extension ObservableType {

    public func mapObject<T: Decodable>(type: T.Type) -> Observable<T?> {
        return flatMap { data -> Observable<T?> in
           guard
               let responseTuple = data as? (HTTPURLResponse, AnyObject),
               let jsonData = try? JSONSerialization.data(withJSONObject: responseTuple.1, options: [JSONSerialization.WritingOptions.prettyPrinted])
           else {
               return Observable.of(nil)
           }
           let decoder = JSONDecoder()
           let object = try decoder.decode(T.self, from: jsonData)
           return Observable.just(object)
        }
    }
   
}
