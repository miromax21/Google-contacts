
//
//  DetailPresenter.swift
//  Google contacts
//
//  Created by maxim mironov on 27.03.2020.
//  Copyright © 2020 maxim mironov. All rights reserved.
//

import Foundation
protocol DetailViewProtocol : class{
   func setContact(contact: Contact?)
}

protocol DetailViewPresenterProtocol : class {
    init(view: DetailViewProtocol, service: NetworkServiceProtocol, router:RouterProtocol, contact:Contact?,validator: Validator)
    func setContact()
    func tap()
    func validate(text: String, with rules: Rule) -> Bool
}

class DetailPresentor: DetailViewPresenterProtocol {
    weak var view: DetailViewProtocol?
    var router: RouterProtocol?
    let service: NetworkServiceProtocol!
    var contact: Contact?
    var validator: Validator!
    required init(view: DetailViewProtocol, service: NetworkServiceProtocol, router:RouterProtocol, contact: Contact?, validator: Validator) {
        self.view = view
        self.service = service
        self.contact = contact
        self.router = router
        self.validator = validator
    }
    
    func setContact() {
        self.view?.setContact(contact: contact)
    }
    
    func tap(){
        router?.goBackward()
    }
    func validate(text: String, with rules: Rule) -> Bool {
        return validator.validate(text: text, with: rules)
    }
}
