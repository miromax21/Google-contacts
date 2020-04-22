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

class ContactsPresentor:ContactsViewPresentorProtocol{
    weak var view: ContactsViewProtocol?
    var dataSource = BehaviorRelay(value: [Contact]())
    var isLoading = PublishSubject<Bool>()
    var error = PublishSubject<ContactsAlertMessegeEnum?>()
    
    var router: RouterProtocol?
    var contacts: [Contact] = []
    var useCases: GoogleUseCases!
    
    let disposeBag = DisposeBag()
    
    fileprivate var nextContacts: [Contact] {
        willSet {
            self.dataSource.accept(self.dataSource.value + newValue)
        }
    }
 
    required init(view: ContactsViewProtocol, useCases: GoogleUseCases, router: RouterProtocol) {
        self.view = view
        self.router = router
        self.useCases = useCases
        self.isLoading.onNext(true)
        self.nextContacts = [Contact]()
    }

    func tapOnTheContact(contactIndex: IndexPath){
        let contact =  self.dataSource.value[contactIndex.row]
        router?.onNext(nextView: .contactsDetails(contact: contact))
    }
    func goToAuthentication() {
        router?.present( onvc: self.view!, nextView: .login)
    }
    func getContacts() {
        self.isLoading.onNext(true)
        self.useCases.fetchContacts()
        .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
        .subscribeOn(MainScheduler.instance).subscribe(
            onNext: { [unowned self] contacts in
                guard let contacts = contacts else {
                    return
                }
                self.nextContacts = contacts
            },
            onError: { [unowned self] (error) in
                self.error.onNext(.authorizationError)
                self.isLoading.onNext(false)
            },
            onCompleted: { [unowned self] in
                self.isLoading.onNext(false)
            }
            
        ).disposed(by: disposeBag)
    }
}
