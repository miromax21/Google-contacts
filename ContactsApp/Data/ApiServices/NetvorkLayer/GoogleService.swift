//
//  GoogleService.swift
//  Google contacts
//
//  Created by maxim mironov on 27.03.2020.
//  Copyright © 2020 maxim mironov. All rights reserved.
//
import Foundation
import GoogleSignIn
import RxSwift
import RxCocoa
fileprivate let GoogleSerciceBaseUrl:String = "https://jsonplaceholder.typicode.com"

enum GoogleServiceEnum{
    case Users
    case Contacts(token:String)
    var url : URL {
        var path = ""
        switch self {
            
        case .Users:
            path = "/users"
        case .Contacts(let token):
            path = "?access_token=\(token)"
        }
        
        return URL(string: GoogleSerciceBaseUrl)!.appendingPathComponent(path)
    }
}


class GoogleService: NetworkServiceProtocol {
    var inProces : Bool = false
    var currentRequest : URLRequest?
    var dataTask: URLSessionDataTask?
    init() {
        
    }
    func fetch(path:GoogleServiceEnum) -> Observable<Data?> {
        return Observable<Data?>.create { observer in
            self.dataTask?.cancel()
            let defaultSession = URLSession(configuration: .default)
            self.dataTask = defaultSession.dataTask(with: path.url){ (data, _, error) in
                if let error = error{
                   observer.onError(error)
                }
                observer.onNext(data)
                observer.onCompleted()
                self.inProces = false
            }
            self.dataTask?.resume()
            return Disposables.create {
                self.inProces = true
            }
        }
    }
}

