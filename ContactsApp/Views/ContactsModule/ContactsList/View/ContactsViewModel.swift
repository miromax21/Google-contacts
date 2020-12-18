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
import RxDataSources

class ContactsViewModel: ViewModelProtocol{
    
    var view: ContactsViewController
    var dataSource: RxTableViewSectionedReloadDataSource<SectionModel<String, Entry>>!
    var items = BehaviorRelay(value: [SectionModel<String, Entry>(model: "", items: [])])
    var isLoading = PublishSubject<Bool>()
    var error = PublishSubject<RequestError>()
    
    var navigationController: UINavigationController!
    var contacts: [Entry] = []
    var useCases: GoogleUseCaseProvider!
    let disposeBag = DisposeBag()

    var coordinator: BaseCoordinator!
    fileprivate var nextEntries: [Entry] {
        willSet {
            let groupedEntries: [SectionModel<String, Entry>] = Dictionary(grouping: newValue){ $0.title?.first}.map {
                var label = "#: No name"
                if let key = $0.key{
                    label =  String(describing: key)
                }
                return SectionModel(model: label, items: $0.value)
            }
            self.items.accept(groupedEntries)
        }
    }
    var Output: UIViewController! {
        get{
            return self.view
        }
    }
    
    init(coordinator: BaseCoordinator!) {
        self.coordinator = coordinator
        self.view = ContactsViewController()
        self.useCases =  ContactsUsecaseProvider()
        self.isLoading.onNext(true)
        self.nextEntries = [Entry]()
        self.view.presentor = self
    }

    func tapOnTheContact(contact: Entry){
        self.coordinator.appCoordinator.next(coordinator: .details(contact: contact))
    }
    
    func goToAuthentication() {
        self.coordinator.appCoordinator.next(coordinator: .login(coordinator: .contcts))
    }
    
    func getContacts() {
        self.isLoading.onNext(true)
        self.useCases.fetchContacts()
        .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe(
                onSuccess: { [unowned self] entry in
                    guard let entry = entry else {
                        self.error.onNext(RequestError.noData)
                        self.isLoading.onNext(false)
                        return
                    }
                    self.nextEntries = entry
                    self.isLoading.onNext(false)
                },
                onError: { [unowned self] (error) in
                    self.error.onNext(error as? RequestError ?? RequestError.any)
                    self.isLoading.onNext(false)
                }
        ).disposed(by: disposeBag)
    }
}
