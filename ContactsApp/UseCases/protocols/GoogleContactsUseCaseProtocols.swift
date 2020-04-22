//
//  GoogleContactsUseCaseProtocols.swift
//  ContactsApp
//
//  Created by maxim mironov on 22.04.2020.
//  Copyright © 2020 maxim mironov. All rights reserved.
//

import Foundation
import RxSwift

protocol GoogleUseCases {
     func fetchContacts() -> Observable<[Contact]?>
     init(service: NetworkServiceProtocol!)
}
