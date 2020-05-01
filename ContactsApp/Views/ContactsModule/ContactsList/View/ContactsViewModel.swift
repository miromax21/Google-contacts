//
//  ContactsPresentor.swift
//  Google contacts
//
//  Created by maxim mironov on 27.03.2020.
//  Copyright © 2020 maxim mironov. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ContactsViewModel{
    var view: ContactsViewController
    var dataSource = BehaviorRelay(value: [Entry]())
    var isLoading = PublishSubject<Bool>()
    var error = PublishSubject<RequestError>()
    
    var router: RouterProtocol!
    var contacts: [Entry] = []
    var useCases: GoogleUseCases!
    let disposeBag = DisposeBag()
    fileprivate var nextEntries: [Entry] {
        willSet {
            self.dataSource.accept(self.dataSource.value + newValue)
        }
    }
    var Output: UIViewController {
        get{
            return self.view
        }
    }
    
    init(router: RouterProtocol) {
        self.router = router
        self.view = ContactsViewController()
        self.useCases = GoogleContactsUseCase(service: GoogleService())
        self.isLoading.onNext(true)
        self.nextEntries = [Entry]()
        self.view.presentor = self
    }

    func tapOnTheContact(contactIndex: IndexPath){
        let contact =  self.dataSource.value[contactIndex.row]
        router.onNext(nextView: DetailViewModel.init(router: self.router, contact: contact).Output)
    }
    func goToAuthentication() {
        router.present(presentView: .login, completion: { [unowned self] _ in
             self.getContacts()
        })
    }
    func getContacts() {
        self.isLoading.onNext(true)
        self.useCases.fetchContacts()
        .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
        .observeOn(MainScheduler.instance).subscribe(
            onNext: { [unowned self] entry in
                guard let entry = entry else {
                    return
                }
                self.nextEntries = entry
            },
            onError: { [unowned self] (error) in
                self.error.onNext(error as? RequestError ?? RequestError.any)
                self.isLoading.onNext(false)
            },
            onCompleted: { [unowned self] in
                self.isLoading.onNext(false)
            }
            
        ).disposed(by: disposeBag)
    }
}
