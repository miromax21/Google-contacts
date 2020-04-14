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
protocol ContactsViewProtocol: class {
    func success()
    func failure(error: Error)
}

protocol ContactsViewPresentorProtocol {
    init(view: ContactsViewProtocol, useCases: GoogleUseCases, router: RouterProtocol)
    func getContacts()
    var contacts : [Contact] {get set}
    func tapOnTheContact(contact: Contact?)
    var userContacts: PublishSubject<[Contact]>{get set}
    var nextContacts: PublishSubject<[Contact]> {get set}
    var useCases: GoogleUseCases!  {get set}
}

class ContactsPresentor:ContactsViewPresentorProtocol{
    weak var view:ContactsViewProtocol?
    var router: RouterProtocol?
    var contacts: [Contact] = []
    var useCases: GoogleUseCases!
    var error = PublishSubject<Error?>()
    var userContacts =  PublishSubject<[Contact]>()
    var nextContacts =  PublishSubject<[Contact]>()
    let disposeBag = DisposeBag()
    required init(view: ContactsViewProtocol, useCases: GoogleUseCases, router: RouterProtocol) {
        self.view = view
        self.router = router
        self.useCases = useCases
        self.getContacts()
    }
    func tapOnTheContact(contact: Contact?){
        router?.onNext(nextView: .contactsDetails(contact: contact))
    }
    func getContacts() {
        self.useCases.fetchContacts()
        .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background)).subscribe(onNext: { [unowned self] contacts in
            guard let contacts = contacts else {return}
            self.contacts += contacts
            self.nextContacts.onNext(contacts)
            self.nextContacts.onCompleted()
        },onError: { [unowned self] (error) in
            self.error.onNext(error)
        }).disposed(by: disposeBag)
    }
}
