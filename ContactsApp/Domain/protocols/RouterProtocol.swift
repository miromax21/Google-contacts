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
    func onNext(nextView:ControllersEnum)
    func present(onvc: UIViewController,nextView: ControllersEnum)
}

protocol RouterMainProtocol: RouterProtocol {
    var authenticationError: Bool! {get set}
    var navigationController: UINavigationController! {get set}
    var moduleBuilder: AppModuleBuilderProtocol? {get set}
}


enum ControllersEnum {
    case login
    case contacts
    case contactsDetails(contact:Contact?)
}
