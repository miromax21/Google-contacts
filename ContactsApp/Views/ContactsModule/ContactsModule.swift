////
////  ContactsModule.swift
////  ContactsApp
////
////  Created by maxim mironov on 14.04.2020.
////  Copyright © 2020 maxim mironov. All rights reserved.
////
//
//import Foundation
//import UIKit
//class ContactsModuleBuilder {
//    
//    func showDetails(contact:Entry?, router: RouterProtocol) -> UIViewController {
//        let view = DetailsViewController()
//        let networkService = GoogleService()
//        let presentor = DetailViewModel(view: view, service: networkService, router: router, contact: contact)
//        view.presentor = presentor
//        return view
//    }
//    
//    func showContacts(router: RouterProtocol) -> UIViewController {
////        let view = ContactsViewController()
////        let networkService = GoogleService()
////        let useCases = GoogleContactsUseCase(service: networkService)
////        let presentor = ContactsViewModel(view: view, useCases: useCases, router: router)
////        view.presentor = presentor
//        
//        let presentep = ContactsViewModel(router: router)
//        
//        return presentep.Output
//    }
//}
