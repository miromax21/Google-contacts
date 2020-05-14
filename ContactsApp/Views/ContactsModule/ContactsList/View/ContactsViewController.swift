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
    var presentor: ContactsViewModel!
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupTableView()
        setupLoading()
        setupHendler()
        self.presentor.getContacts()

    }
    private func setupTableView() {
        self.contactsTableView.delegate = nil
        self.contactsTableView.dataSource = nil
        self.contactsTableView.delegate = nil
        self.contactsTableView.tableFooterView = UIView()
        setupTableViewBinding()
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
        let loader: LoaderViewProtocol = LoaderView(onview: self.view)
        presentor.isLoading.asObservable().subscribe(onNext: { (isLoading) in
            loader.isLoading.onNext(isLoading)
        }).disposed(by: self.disposeBag)
        
    }
}

// MARK: Extensions

extension ContactsViewController {
    func showAlert(message: RequestError , style : UIAlertController.Style? = .alert) {
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
        let actionGoAuth = UIAlertAction(title: "Авторизоваться", style: .default) { [unowned self] (action)  in
            self.presentor.goToAuthentication()
         //   let vc  = LoginCoordinator(router: self.presentor.coordinator.router).start()
          //  self.navigationController?.pushViewController(LoginCoordinator().start(), animated: true)
        }
        switch message{
            
        case .any, .noData:
            title = "asomething went wrong :)"
        case .noInternet:
            title = "internet cennection error"
        case .sessionError(error: let error):
            title = error.localizedDescription
            alert.addAction(actionRetry)
        case .serverError(error: let error):
            if (error.code == 401){
                fallthrough
            }
            title = "server error"
            alertMessege = error.localizedDescription
            alert.addAction(actionRetry)
        case .authentification:
            title = "authorization error"
            alert.addAction(actionGoAuth)

        }
        
        alert.title = title
        alert.addAction(actionOK)
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
        
    }
}

