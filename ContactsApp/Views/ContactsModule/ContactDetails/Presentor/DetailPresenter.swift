
//
//  DetailPresenter.swift
//  Google contacts
//
//  Created by maxim mironov on 27.03.2020.
//  Copyright © 2020 maxim mironov. All rights reserved.
//
import Foundation

class DetailPresentor: DetailViewPresenterProtocol {
    
    weak var view: DetailViewProtocol?
    var router: RouterProtocol?
    let service: NetworkServiceProtocol!
    var contact: Contact?

    
    required init(view: DetailViewProtocol, service: NetworkServiceProtocol, router:RouterProtocol, contact: Contact?) {
        self.view = view
        self.service = service
        self.contact = contact
        self.router = router
    }
    
    func setContact() {
        self.view?.setContact(contact: contact)
    }
}
