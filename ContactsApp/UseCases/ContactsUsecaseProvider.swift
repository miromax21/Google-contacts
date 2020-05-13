//
//  ContactsUsecaseProvider.swift
//  ContactsApp
//
//  Created by maxim mironov on 02.05.2020.
//  Copyright © 2020 maxim mironov. All rights reserved.
//

import Foundation
import RxSwift
import Moya

class ContactsUsecaseProvider: GoogleUseCaseProvider {
    var useCase : GoogleContactsUseCase!
    
    init(){
        let service = GoogleService()
        let provider = MoyaProvider<GoogleMoyaService>()
        self.useCase =  GoogleContactsUseCase.init(service: service, moyaProvider: provider)
    }
    func fetchContacts() -> Single<[Entry]?>{
        return self.useCase.fetchContacts().asSingle()
    }
    
    func fetchContacts2() -> Single<[Entry]?>{
        return self.useCase.fetchContactsWithMoya()
     }
    
}
 

