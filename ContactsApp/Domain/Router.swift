//
//  Router.swift
//  Google contacts
//
//  Created by maxim mironov on 27.03.2020.
//  Copyright © 2020 maxim mironov. All rights reserved.
//

import UIKit
final class Router: RouterProtocol {
    
    var navigationController: UINavigationController!
    var moduleBuilder: AppModuleBuilderProtocol?
    var contactsModuleBuilder : ContactsModuleBuilder = ContactsModuleBuilder()
    var userDataProvider : UserDataProviderProtocol!
    
    init(navigationController: UINavigationController!,moduleBuilder: AppModuleBuilder, userDataProvider:UserDataProviderProtocol) {
        self.navigationController = navigationController
        self.moduleBuilder = moduleBuilder
        self.userDataProvider = userDataProvider
    }
    
    func onNext(nextView: ControllersEnum){
        if let vc = getViewController(nextView: nextView){
            goForward(next: vc)
        }
    }
    
    func present(onvc: UIViewController, nextView: ControllersEnum){
        if let vc = getViewController(nextView: nextView){
            onvc.present(vc, animated: true)
        }
    }
    
    func goBackward() {
        if self.navigationController.viewControllers.count > 1 {
            self.navigationController.popToRootViewController(animated: true)
        }
    }
    
  // MARK: Private Methods
    private func getViewController(nextView: ControllersEnum) ->  UIViewController? {
        var vc:  UIViewController?
        switch nextView {
            case .login:
                vc = moduleBuilder?.authenticationModuleBuilder.showLogin(router: self)
            case .contacts:
                vc = moduleBuilder?.contactsModuleBuilder.showContacts(router: self)
            case .contactsDetails(let contact):
                vc = moduleBuilder?.contactsModuleBuilder.showDetails(contact: contact, router: self)
        }
        return vc
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
