//
//  ContactsTableViewCell.swift
//  ContactsApp
//
//  Created by maxim mironov on 17.04.2020.
//  Copyright © 2020 maxim mironov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class ContactsTableViewCell: UITableViewCell {

    @IBOutlet weak var contactLable: UILabel!
    @IBOutlet weak var emaillable: UILabel!
    var contact: Entry? {
        willSet(contact){
            guard let contact = contact else {
                self.setDefault()
                return
            }
            self.contactLable.text = contact.name?.fullName ?? contact.title
            self.emaillable.text = contact.gmail?.address
        }
    }
    
    func setDefault(){
        self.contactLable.text = ""
        self.emaillable.text = ""
    }
}
