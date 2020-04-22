//
//  AuthenticationProtocols.swift
//  ContactsApp
//
//  Created by maxim mironov on 22.04.2020.
//  Copyright © 2020 maxim mironov. All rights reserved.
//

import Foundation
import UIKit
import GoogleSignIn

// MARK: ViewProtocols
protocol LoginViewPresenterProtocol : class {
    init(view: UIViewController, service: NetworkServiceProtocol, router:RouterProtocol, validator: Validator)
    func validate(text: String, with rules: Rule) -> Bool
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!)
}

// MARK: ModuleProtocols
protocol AuthenticationModuleBuilderProtocol {
     func showLogin(router: RouterProtocol) -> UIViewController?
}
