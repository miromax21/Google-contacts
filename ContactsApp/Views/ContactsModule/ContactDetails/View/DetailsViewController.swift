//
//  DetailsViewController.swift
//  Google contacts
//
//  Created by maxim mironov on 27.03.2020.
//  Copyright © 2020 maxim mironov. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var name: UILabel!
    var presentor: DetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presentor.setContact()
        // Do any additional setup after loading the view.
    }
    
}

extension DetailsViewController{
    func setContact(contact: Entry?) {
        name.text = contact?.name?.fullName
    }
}
