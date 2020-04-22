//
//  GoogleService.swift
//  Google contacts
//
//  Created by maxim mironov on 27.03.2020.
//  Copyright © 2020 maxim mironov. All rights reserved.
//
import Foundation
import RxSwift
import RxCocoa

fileprivate let GoogleServiceBaseUrl:String = "https://www.google.com/m8/feeds/contacts/miromax21@gmail.com/"

enum GoogleServiceEnum{
    case Users
    case Contacts(token:String)
    var url : URL {
        var path = ""
        switch self {
            
        case .Users:
            path = "/full"
        case .Contacts(let accessToken):
            path = "full?access_token=\(accessToken)&max-results=\(999)&alt=json&v=3.0"
        }
        
        return URL(string: GoogleServiceBaseUrl + path)!
    }
}


class GoogleService: NetworkServiceProtocol {
    var inProces : Bool = false
    var currentRequest : URLRequest?
    var dataTask: URLSessionDataTask?
    lazy var requestObservable = RequestObservable(config: .default)
    init() {
        
    }
    
    func fetch(path:GoogleServiceEnum) -> Observable<Data?> {
         let request = NSMutableURLRequest(url: path.url)
         request.httpMethod = "GET"
         request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
         return RequestObservable.shared.callAPI(request: request as URLRequest)
    }
}

