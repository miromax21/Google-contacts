//
//  GoogleContactsUseCase.swift
//  ContactsApp
//
//  Created by maxim mironov on 07.04.2020.
//  Copyright © 2020 maxim mironov. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Moya

class GoogleContactsUseCase  {
    var service: NetworkServiceProtocol!
    
    init(service: NetworkServiceProtocol!) {
        self.service = service
    }
   func start() -> Observable<[Entry]?>{
        guard
            let googleAccessTokken = UserDataWrapper.googleAccessTokken,
            let email = UserDataWrapper.email,
            let tokkenExpired = UserDataWrapper.googleAccessTokkenExpired,
            tokkenExpired.timeIntervalSince1970 > NSDate().timeIntervalSince1970
            else {
                return Observable.error(RequestError.authentification)
            }
    
        return Observable.deferred {
            return self.service.request(path: .Contacts(token: googleAccessTokken, userEmail: email) )
                .flatMap { (userData)  -> Observable<[Entry]?>  in
                    return Observable.of(userData?.feed?.entry)
            }
        }
    }

    
}
