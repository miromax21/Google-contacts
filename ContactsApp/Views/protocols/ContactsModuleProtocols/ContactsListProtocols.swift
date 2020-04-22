//
//  ContactsListProtocols.swift
//  ContactsApp
//
//  Created by maxim mironov on 17.04.2020.
//  Copyright © 2020 maxim mironov. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
protocol ContactsViewProtocol: UIViewController {
    func showAlert(message: ContactsAlertMessegeEnum! , style : UIAlertController.Style?)
}
enum ContactsAlertMessegeEnum{
    case authorizationError
    case serverError(errorTitle:String, errorMessege: String?)
}
protocol ContactsViewPresentorProtocol {
    var dataSource: BehaviorRelay<[Contact]> {get}
    var error : PublishSubject<ContactsAlertMessegeEnum?>  {get}
    var isLoading: PublishSubject<Bool> {get}
    func getContacts()
    func goToAuthentication()
    func tapOnTheContact(contactIndex: IndexPath)
}
