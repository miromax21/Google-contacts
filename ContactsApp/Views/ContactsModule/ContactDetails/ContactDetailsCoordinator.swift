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
    override func start() {
        let detailsViewController = DetailsViewController()
        let detailViewModel = DetailViewModel(contact: self.contact)
        detailsViewController.presentor =  detailViewModel
        self.navigationController.navigationBar.isHidden = false
        self.navigationController.viewControllers = [detailsViewController]
//        self.navigationController.pushViewController(detailsViewController, animated: true)
        //.pushViewController(detailsViewController, animated: true)
            
    }
    
}
