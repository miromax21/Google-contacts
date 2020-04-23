//
//  Router.swift
//  Google contacts
//
//  Created by maxim mironov on 27.03.2020.
//  Copyright © 2020 maxim mironov. All rights reserved.
//

import UIKit
import  RxCocoa
import RxSwift
final class Router: RouterProtocol {
    var navigationController: UINavigationController!
    var moduleBuilder: AppModuleBuilderProtocol?
    var contactsModuleBuilder : ContactsModuleBuilder = ContactsModuleBuilder()
    var userDataProvider : UserDataProviderProtocol!

    var nextView: ControllersEnum?
    
    init(navigationController: UINavigationController!,moduleBuilder: AppModuleBuilder, userDataProvider:UserDataProviderProtocol, firstView: ControllersEnum = .contacts ) {
        self.navigationController = navigationController
        self.moduleBuilder = moduleBuilder
        self.userDataProvider = userDataProvider
        self.setAsRoot(viewControllerAsRoot: getVC(nextView: firstView))
    }
    
    func onNext(nextView: ControllersEnum){
        navigateTo(nextView: nextView)
    }
    func present(presentView: ControllersEnum) {
        if let presentView = getVC(nextView: presentView) as? PresentableViewController{
            presentView.complete = { view in
                view.dismiss(animated: true)
                return
            }
            self.navigationController.viewControllers.last?.present(presentView , animated: true)
        }
    }
    
    func goBackward() {
        if self.navigationController.viewControllers.count > 1 {
            self.navigationController.popToRootViewController(animated: true)
        }
    }
    
  // MARK: Private Methods
    private func navigateTo(nextView: ControllersEnum) {
        var vc:  UIViewController!
        guard nextView.needAccept, (self.userDataProvider.getData(for: .googleAccessTokken)) != nil else {
            present(presentView: .login)
            return
        }
        vc = getVC(nextView: nextView)
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    private func getVC(nextView: ControllersEnum) -> UIViewController{
        var vc:  UIViewController!
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
        self.navigationController.viewControllers = [viewController]
    }
    
}
