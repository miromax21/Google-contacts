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
    func fetch(path:GoogleServiceEnum) -> Observable<Data?>
    var inProcess : Bool {get set}
}

enum RequestError: Error {
    case any
    case noInternet
    case authentification
    case sessionError(error: Error)
    case serverError(error: NSError)
}

