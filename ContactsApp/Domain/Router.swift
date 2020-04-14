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
    var moduleBuilder: ModuleBuilderProtocol? {get set}
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
    var moduleBuilder: ModuleBuilderProtocol?
    
    init(navigationController: UINavigationController!,moduleBuilder:ModuleBuilder, userDataProvider:UserDataProviderProtocol) {
        self.navigationController = navigationController
        self.moduleBuilder = moduleBuilder
    }
    func onNext(nextView: ControllersEnum){
        var vc:  UIViewController?
        switch nextView {
            case .login:
                vc = moduleBuilder?.createLoginModule(router: self)
            case .contacts:
                vc = moduleBuilder?.createContactsModule(router: self)
            case .contactsDetails(let contact):
                vc = moduleBuilder?.createDetailsModule(contact: contact, router: self)
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
