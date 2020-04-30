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
    weak var view: ContactsViewController?
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
    
 
    required init(view: ContactsViewController, useCases: GoogleUseCases, router: RouterProtocol) {
        self.view = view
        self.router = router
        self.useCases = useCases
        self.isLoading.onNext(true)
        self.nextEntries = [Entry]()
    }

    func tapOnTheContact(contactIndex: IndexPath){
        let contact =  self.dataSource.value[contactIndex.row]
        router.onNext(nextView: .contactsDetails(contact: contact))
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
