//
//  ApiServiceProtocol.swift
//  ContactsApp
//
//  Created by maxim mironov on 06.04.2020.
//  Copyright © 2020 maxim mironov. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol NetworkServiceProtocol {
    func request(path : GoogleServiceEnum) -> Observable<UserData?>
}
protocol Api{
    func callAPI(request: URLRequest) -> Observable<Data?>
}

enum RequestError: Error {
    case any
    case noInternet
    case authentification
    case sessionError(error: Error)
    case serverError(error: NSError)
    case noData
    
}

