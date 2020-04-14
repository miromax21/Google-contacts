//
//  ModuleBuilder.swift
//  Google contacts
//
//  Created by maxim mironov on 27.03.2020.
//  Copyright © 2020 maxim mironov. All rights reserved.
//

import UIKit

protocol ModuleBuilderProtocol {
    func createContactsModule(router: RouterProtocol) -> UIViewController
    func createDetailsModule(contact:Contact?,router: RouterProtocol) -> UIViewController
    func createLoginModule(router: RouterProtocol) -> UIViewController
}

class ModuleBuilder: ModuleBuilderProtocol {
    func createDetailsModule(contact:Contact?, router: RouterProtocol) -> UIViewController {
        let view = DetailsViewController()
        let networkService = GoogleService()
        let validator = Validator()
        let presentor = DetailPresentor(view: view, service: networkService, router: router, contact: contact,validator: validator)
        view.presentor = presentor
        return view
    }
    
    func createContactsModule(router: RouterProtocol) -> UIViewController {
        
        let view = ContactsViewController()
        let networkService = GoogleService()
        let userDataProvider = UserDataProvider()
        let useCases = GoogleContactsUseCase(service: networkService, userDataprovider: userDataProvider)
        let presentor = ContactsPresentor(view: view, useCases: useCases, router: router)
        view.presentor = presentor
        return view
    }
    
    func createLoginModule(router: RouterProtocol) -> UIViewController {
        let view = LoginViewController()
        let networkService = GoogleService()
        let validator = Validator()
        let presentor = LoginViewPresenter(view: view, service: networkService, router: router, validator: validator)
        view.presentor = presentor
        return view
    }
}
