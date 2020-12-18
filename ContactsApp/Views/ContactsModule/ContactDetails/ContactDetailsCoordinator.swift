//
//  ContactDetailsCoordinator.swift
//  ContactsApp
//
//  Created by maxim mironov on 01.05.2020.
//  Copyright © 2020 maxim mironov. All rights reserved.
//

import Foundation
import UIKit
class ContactDetailsCoordinator: BaseCoordinator {
    var contact: Entry?
    init(contact: Entry?) {
        self.contact = contact
    }
    override func start() -> UIViewController {
        self.viewModel = DetailViewModel(contact: self.contact)
        return super.start()
    }
    
}
