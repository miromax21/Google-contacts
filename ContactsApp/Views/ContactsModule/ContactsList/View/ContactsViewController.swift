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
    unowned var viewModel: ContactsViewModel!
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupTableView()
        setupLoading()
        setupApiHendler()
        setupUIHendlers()
        self.viewModel.getContacts()

    }
    private func setupTableView() {
        self.contactsTableView.delegate = nil
        self.contactsTableView.dataSource = nil
        self.contactsTableView.delegate = nil
        self.contactsTableView.tableFooterView = UIView()
        setupTableViewBinding()
    }

    private func setupTableViewBinding() {
        let nib = UINib(nibName: ContactsTableViewCell.identifier, bundle: nil)
        contactsTableView.register(nib, forCellReuseIdentifier: ContactsTableViewCell.identifier)
        viewModel
            .dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, Entry>>(
                configureCell: { (dataSource, tableView, indexPath, item) -> ContactsTableViewCell in
                    let cell = tableView.dequeueReusableCell(withIdentifier: ContactsTableViewCell.identifier, for: indexPath) as! ContactsTableViewCell
                    cell.contact = item
                    return cell
                }
        )
        
        viewModel
            .items
                .bind(to: contactsTableView.rx.items(dataSource:  viewModel.dataSource))
                .disposed(by: disposeBag)
        
        viewModel.isLoading.asObservable().subscribe(onNext: { (isLoading) in
            if isLoading{
                self.contactsTableView
                    .rx
                        .setDelegate(self)
                    .disposed(by: self.disposeBag)
            }
        }).disposed(by: self.disposeBag)
    }
    
    private func setupUIHendlers(){
        Observable
            .zip(contactsTableView.rx.itemSelected, contactsTableView.rx.modelSelected(Entry.self))
            .bind { [unowned self] indexPath, model in
                self.viewModel.tapOnTheContact(contact: model)
            }
            .disposed(by: disposeBag)
    }
    
    private func setupApiHendler(){
        self.viewModel.error.asObservable().subscribe(onNext: { [unowned self] (error) in
            self.showAlert(message: error)
        }).disposed(by: self.disposeBag)
    }
    
    private func setupLoading(){
        let loader: LoaderViewProtocol = LoaderView(onview: self.view)
        viewModel.isLoading.asObservable().subscribe(onNext: { (isLoading) in
            loader.isLoading.onNext(isLoading)
        }).disposed(by: self.disposeBag)
        
    }
}
extension ContactsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel(frame: CGRect(x: 10, y: 150, width: 230, height: 21))
        label.text = "\(self.viewModel.items.value[section].model)"
        let frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 42)
        let headerView = UIView(frame: frame)
        headerView.backgroundColor = UIColor.darkGray
        headerView.addSubview(label)
        label.center = headerView.center
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
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
                self.viewModel.getContacts()
            }
        }
        let actionOK = UIAlertAction(title: "OK", style: .default) { (action) in
            alert.dismiss(animated: true)
        }
        let actionGoAuth = UIAlertAction(title: "Авторизоваться", style: .default) { [unowned self] (action)  in
            self.viewModel.goToAuthentication()
        }
        switch message{
            
        case .any, .noData:
            title = "something went wrong :)"
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

