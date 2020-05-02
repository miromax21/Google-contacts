//
//  ContactsUsecaseProvider.swift
//  ContactsApp
//
//  Created by maxim mironov on 02.05.2020.
//  Copyright © 2020 maxim mironov. All rights reserved.
//

import Foundation
import RxSwift
class ContactsUsecaseProvider: GoogleUseCaseProvider {
    var useCase : GoogleContactsUseCase!
    
    init(){
        let service = GoogleService()
        self.useCase =  GoogleContactsUseCase.init(service: service)
    }
    func fetchContacts() -> Single<[Entry]?>{
        return self.useCase.fetchContacts().asSingle()
    }

}
