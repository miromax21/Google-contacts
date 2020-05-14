
//
//  DetailPresenter.swift
//  Google contacts
//
//  Created by maxim mironov on 27.03.2020.
//  Copyright © 2020 maxim mironov. All rights reserved.
//
import Foundation
import UIKit
class DetailViewModel {
    
    var view: DetailsViewController
  
   // let service: NetworkServiceProtocol!
    var contact: Entry?

    var Output: UIViewController {
         get{
             return self.view
         }
     }
    
    init(contact: Entry?) {
        self.view = DetailsViewController()
        self.contact = contact
        self.view.presentor = self    }
    
    func setContact() {
        self.view.setContact(contact: self.contact)
    }
}
