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

class GoogleContactsUseCase : GoogleUseCases {
    var service: NetworkServiceProtocol!
    required init(service: NetworkServiceProtocol!) {
        self.service = service
    }
   func fetchContacts() -> Observable<[Entry]?>{
        guard
            let googleAccessTokken = UserDataWrapper.googleAccessTokken,
            let email = UserDataWrapper.email
            else { return Observable.error(RequestError.authentification)}
    
        return Observable.deferred {
            let sds: Observable<UserData?> =  self.service.fetch(path: .Contacts(token: googleAccessTokken, userEmail: email) )
    
            return sds.flatMap { (userData)  -> Observable<[Entry]?>  in
                return Observable.of(userData?.feed?.entry)
            }
        }
    }
}
