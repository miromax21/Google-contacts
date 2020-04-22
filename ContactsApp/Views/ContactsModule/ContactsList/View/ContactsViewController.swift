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
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupTableViewBinding()
        setupLoading()
        setupHendler()
        self.presentor.getContacts()
    }
    
    private func setupTableView() {
        self.contactsTableView.delegate = nil
        self.contactsTableView.dataSource = nil
        self.contactsTableView.delegate = nil
        self.contactsTableView.tableFooterView = UIView()
    }

    private func setupTableViewBinding() {
        let cell = ContactsTableViewCell.self
        let nib = UINib(nibName: cell.identifier, bundle: nil)
        contactsTableView.register(nib, forCellReuseIdentifier: cell.identifier)
        presentor.dataSource.bind(to: contactsTableView.rx.items(cellIdentifier: cell.identifier, cellType: cell)) { index, model, cell in
            cell.contact = model
        }.disposed(by: self.disposeBag)
        
        contactsTableView.rx.itemSelected.subscribe(onNext: { (indexPath) in
            self.presentor.tapOnTheContact(contactIndex: indexPath)
        }).disposed(by: self.disposeBag)
    }
    private func setupHendler(){
        self.presentor.error.asObservable().subscribe(onNext: { [unowned self] (error) in
            self.showAlert(message: error)
        }).disposed(by: self.disposeBag)
    }
    
    private func setupLoading(){
       presentor.isLoading.asObservable().subscribe(onNext: { (isLoading) in
            if (isLoading){
                self.showSpinner(onView: self.view)
            }else{
                self.removeLoader()
            }
        }).disposed(by: self.disposeBag)
        
    }
}

// MARK: Extensions

extension ContactsViewController : ContactsViewProtocol {
    func showAlert(message: ContactsAlertMessegeEnum! , style : UIAlertController.Style? = .alert) {
        var title: String?
        var alertMessege: String?
        
        let alert =  UIAlertController(title: title, message: alertMessege, preferredStyle: style!)
        let actionRetry = UIAlertAction(title: "Retry", style: .default) { [unowned self] (action:UIAlertAction) in
            alert.dismiss(animated: true) {
                self.presentor.getContacts()
            }
        }
        let actionOK = UIAlertAction(title: "OK", style: .default) { (action) in
            alert.dismiss(animated: true)
        }
        let actionGoAuth = UIAlertAction(title: "Авторизоваться", style: .default) {[unowned self] (action)  in
            self.presentor.goToAuthentication()
        }
        
        switch message {
            case .authorizationError:
                title = "authorization error"
                alert.addAction(actionGoAuth)
            case .serverError(let errorTitle, let errorMessege):
                title = errorTitle
                alertMessege =  errorMessege
                alert.addAction(actionRetry)
            default:
                title = "error :)"
        }
        alert.title = title
        alert.addAction(actionOK)
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
        
    }
}

