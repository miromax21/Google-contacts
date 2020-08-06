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
        super.init()
    }
    override func start() -> UIViewController {
        let detailsViewController = DetailsViewController()
        let detailViewModel = DetailViewModel(contact: self.contact)
        detailsViewController.presentor =  detailViewModel
        return detailViewModel.Output            
    }
    
}
