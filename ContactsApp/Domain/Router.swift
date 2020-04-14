//
//  Router.swift
//  Google contacts
//
//  Created by maxim mironov on 27.03.2020.
//  Copyright © 2020 maxim mironov. All rights reserved.
//

import UIKit
protocol RouterMainProtocol {
    var navigationController: UINavigationController! {get set}
    var moduleBuilder: AppModuleBuilderProtocol? {get set}
}

protocol RouterProtocol:RouterMainProtocol {
    func goBackward()
    func onNext(nextView:ControllersEnum)
}
enum ControllersEnum{
    case login
    case contacts
    case contactsDetails(contact:Contact?)
}

final class Router: RouterProtocol {
    var navigationController: UINavigationController!
    var moduleBuilder: AppModuleBuilderProtocol?
    var contactsModuleBuilder : ContactsModuleBuilder = ContactsModuleBuilder()
    init(navigationController: UINavigationController!,moduleBuilder: AppModuleBuilder, userDataProvider:UserDataProviderProtocol) {
        self.navigationController = navigationController
        self.moduleBuilder = moduleBuilder
    }
    func onNext(nextView: ControllersEnum){
        var vc:  UIViewController?
        switch nextView {
            case .login:
                vc = moduleBuilder?.authenticationModuleBuilder.showLogin(router: self)
            case .contacts:
                vc = moduleBuilder?.contactsModuleBuilder.showContacts(router: self)
            case .contactsDetails(let contact):
                vc = moduleBuilder?.contactsModuleBuilder.showDetails(contact: contact, router: self)
        }
        goForward(next: vc)
    }
    
    func goBackward() {
        if self.navigationController.viewControllers.count > 1 {
            self.navigationController.popToRootViewController(animated: true)
        }
    }
    
    private func goForward(next:UIViewController?){
        guard let next = next else {return}
        self.navigationController.pushViewController(next, animated: true)

    }
    
    private func setAsRoot(viewControllerAsRoot:UIViewController?)  {
        guard let viewController = viewControllerAsRoot else {return}
        self.navigationController = UINavigationController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
