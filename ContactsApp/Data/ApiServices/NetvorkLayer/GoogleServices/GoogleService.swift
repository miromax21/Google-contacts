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
import Moya

class GoogleService: RequestObservable, NetworkServiceProtocol {
    
    var al = AlamofireRequest()
    
    func request(path:GoogleServiceEnum) -> Observable<UserData?> {
        var request = URLRequest(url: path.url)
        request.httpMethod = "GET"
        return self.al.callAPI(request: request)
    }
}
