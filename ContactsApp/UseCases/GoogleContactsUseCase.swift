//
//  GoogleContactsUseCase.swift
//  ContactsApp
//
//  Created by maxim mironov on 07.04.2020.
//  Copyright © 2020 maxim mironov. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
protocol GoogleUseCases {
     func fetchContacts() -> Observable<[Contact]?>
     init(service: NetworkServiceProtocol!, userDataprovider: UserDataProvider!)
}
class GoogleContactsUseCase : GoogleUseCases {
    var service: NetworkServiceProtocol!
    var userDataprovider: UserDataProvider!
    required init(service: NetworkServiceProtocol!, userDataprovider: UserDataProvider!) {
        self.service = service
        self.userDataprovider = userDataprovider
    }
    
   func fetchContacts() -> Observable<[Contact]?>{
    let googletoken = self.userDataprovider.getData(for: .googleIdToken)
        return Observable.deferred {
            return self.service.fetch(path: .Users).flatMap { (data) -> Observable<[Contact]?> in
                guard let data = data else { return Observable.of(nil)}
                return Observable.of(Utils.shared.JSONDecodeToData(data: data))
            }
        }
    }
}
