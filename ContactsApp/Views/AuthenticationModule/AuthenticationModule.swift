//
//  AuthenticationModule.swift
//  ContactsApp
//
//  Created by maxim mironov on 14.04.2020.
//  Copyright © 2020 maxim mironov. All rights reserved.
//

import Foundation
import UIKit

class AuthenticationModuleBuilder: AuthenticationModuleBuilderProtocol {

    func showLogin(router: RouterProtocol) -> UIViewController? {
        let view = LoginViewController()
        let networkService = GoogleService()
        let presentor = LoginViewPresenter(view: view, service: networkService, router: router)
        view.presentor = presentor
        return view
    }
}


