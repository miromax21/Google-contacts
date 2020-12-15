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
    var useCase : GoogleUseCase!
    
    init(){
        self.useCase = true
            ? GoogleContactsUseCase.init(service:  GoogleService())
            : GoogleContactsUseCaseMoya(moyaProvider: MoyaProvider<GoogleMoyaService>())
    }
    func fetchContacts() -> Single<[Entry]?>{
        return self.useCase.start()
    }
}
 

