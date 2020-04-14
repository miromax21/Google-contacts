//
//  LoginPresenter.swift
//  Google contacts
//
//  Created by maxim mironov on 31.03.2020.
//  Copyright © 2020 maxim mironov. All rights reserved.
//

import Foundation
import RxSwift
import GoogleSignIn

protocol LoginViewPresenterProtocol : class {
    init(view: UIViewController, service: NetworkServiceProtocol, router:RouterProtocol, validator: Validator)
    func validate(text: String, with rules: Rule) -> Bool
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!)
}

class LoginViewPresenter: LoginViewPresenterProtocol {
    weak var view: UIViewController?
    var router: RouterProtocol?
    let service: NetworkServiceProtocol!
    var contact: Contact?
    var validator: Validator!
    required init(view: UIViewController, service: NetworkServiceProtocol, router: RouterProtocol, validator: Validator) {
        self.view = view
        self.service = service
        self.router = router
        self.validator = validator
    }
    func validate(text: String, with rules: Rule) -> Bool {
        return false
    }
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if (error == nil) {
            guard let authentication = user.authentication else { return }
            guard let idtoken = authentication.idToken, let accessTokken = authentication.accessToken else { return }
            UserDataWrapper.token = idtoken
            UserDataWrapper.googleAccessTokken = accessTokken
            self.router?.onNext(nextView: .contacts)
        } else {
            print("\(error.localizedDescription)")
        }
    }
    
}
