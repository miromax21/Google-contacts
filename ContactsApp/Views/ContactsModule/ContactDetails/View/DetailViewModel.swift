
//
//  DetailPresenter.swift
//  Google contacts
//
//  Created by maxim mironov on 27.03.2020.
//  Copyright © 2020 maxim mironov. All rights reserved.
//
import Foundation

class DetailViewModel {
    
    weak var view: DetailsViewController?
    var router: RouterProtocol?
    let service: NetworkServiceProtocol!
    var contact: Entry?

    
    required init(view: DetailsViewController, service: NetworkServiceProtocol, router:RouterProtocol, contact: Entry?) {
        self.view = view
        self.service = service
        self.contact = contact
        self.router = router
    }
    
    func setContact() {
        self.view?.setContact(contact: contact)
    }
}
