//
//  RouterProtocol.swift
//  ContactsApp
//
//  Created by maxim mironov on 22.04.2020.
//  Copyright © 2020 maxim mironov. All rights reserved.
//

import UIKit

protocol RouterProtocol {
    var navigationController: UINavigationController! {get}
    func goBackward()
    func onNext(nextView:UIViewController)
    func present(presentView: ControllersEnum, completion: ((_ vc: PresentableViewController) -> ())?)
}

protocol RouterMainProtocol: RouterProtocol {
    var authenticationError: Bool! {get set}
    var navigationController: UINavigationController! {get set}
}


enum ControllersEnum {
    case login
    case contacts
    case contactsDetails(contact:Entry?)
}
