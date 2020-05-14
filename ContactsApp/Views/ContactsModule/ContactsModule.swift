////
////  ContactsModule.swift
////  ContactsApp
////
////  Created by maxim mironov on 14.04.2020.
////  Copyright © 2020 maxim mironov. All rights reserved.
////
//
import Foundation
import UIKit
class ContactsCoordinator: BaseCoordinator {

    override func start() -> UIViewController {
        let contactVM =  ContactsViewModel(coordinator: self)
        return contactVM.Output
    }
}
