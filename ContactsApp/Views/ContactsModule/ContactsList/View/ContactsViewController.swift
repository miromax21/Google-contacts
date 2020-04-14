//
//  ContactsViewController.swift
//  Google contacts
//
//  Created by maxim mironov on 27.03.2020.
//  Copyright © 2020 maxim mironov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class ContactsViewController: UIViewController {
    @IBOutlet weak var contactsTableView: UITableView!
    
    var presentor: ContactsViewPresentorProtocol!
    var places: BehaviorRelay<[Contact]> = BehaviorRelay(value: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contactsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        let disposeBag = DisposeBag()
        self.contactsTableView.delegate = nil

        self.presentor.nextContacts.asObservable()
            .do(onCompleted : {
                self.removeLoader()
            }, onSubscribe : {
                self.showSpinner(onView: self.view)
            })
            .bind(to: contactsTableView.rx.items(cellIdentifier: "Cell",  cellType: UITableViewCell.self)) { row, element, cell in
                cell.textLabel?.text = "\(element.name)"
            }
        
        contactsTableView.rx.itemSelected.subscribe(onNext: {   [weak self] indexPath in
            self?.presentor.tapOnTheContact(contact: self?.presentor.contacts[indexPath.row])
        })
    }
}

extension ContactsViewController : ContactsViewProtocol {
    func success() {
      
    }
    
    func failure(error:Error) {
        print(error)
    }
}

