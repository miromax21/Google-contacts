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
    var useCaseMoya : GoogleContactsUseCaseMoya!
    
    init(){
        let service = GoogleService()
        self.useCase = GoogleContactsUseCase.init(service: service)
        
        let provider = MoyaProvider<GoogleMoyaService>()
        self.useCaseMoya = GoogleContactsUseCaseMoya(moyaProvider: provider)
    }
    func fetchContacts() -> Single<[Entry]?>{
        let s = 12
        if s % 2 == 0{
            return self.useCase.start().asSingle()
        }else{
            return self.useCaseMoya.start()
        }
    }
}
 

