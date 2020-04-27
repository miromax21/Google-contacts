//
//  ContactDetailsProtocols.swift
//  ContactsApp
//
//  Created by maxim mironov on 17.04.2020.
//  Copyright © 2020 maxim mironov. All rights reserved.
//

import Foundation
protocol DetailViewProtocol : class{
   func setContact(contact: Contact?)
}

protocol DetailViewPresenterProtocol : class {
    init(view: DetailViewProtocol, service: NetworkServiceProtocol, router:RouterProtocol, contact:Contact?)
    func setContact()
}

