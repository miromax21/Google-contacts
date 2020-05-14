//
//  DetailsViewController.swift
//  Google contacts
//
//  Created by maxim mironov on 27.03.2020.
//  Copyright © 2020 maxim mironov. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    var presentor: DetailViewModel!
    
    @IBOutlet weak var name: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presentor.setContact()
        
    }
    func setContact(contact: Entry?) {
         if let addres =  contact?.gmail?.address{
             self.name.text = addres
         }
     }

}

