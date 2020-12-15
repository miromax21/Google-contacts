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

class GoogleContactsUseCase: GoogleUseCase  {
    var service: NetworkServiceProtocol!
    
    init(service: NetworkServiceProtocol!) {
        self.service = service
    }
   func start() -> PrimitiveSequence<SingleTrait, [Entry]?>{
        guard
            let googleAccessTokken = UserDataWrapper.googleAccessToken,
            let email = UserDataWrapper.email,
            let tokkenExpired = UserDataWrapper.googleAccessTokenExpired,
            tokkenExpired.timeIntervalSince1970 > NSDate().timeIntervalSince1970
        else {
           return Single.error(RequestError.authentification)
        }
    return self.service.request(path: .Contacts(accessToken: googleAccessTokken, userEmail: email) ).asSingle()
            .flatMap { (userData)  -> PrimitiveSequence<SingleTrait, [Entry]?>  in
                return Single.just(userData?.feed?.entry)
        }
    }
}
