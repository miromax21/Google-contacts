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

class LoginViewModel{
    
    weak var view: PresentableViewController?
    var router: RouterProtocol?
    let service: NetworkServiceProtocol!
    
    required init(view: PresentableViewController, service: NetworkServiceProtocol, router: RouterProtocol) {
        self.view = view
        self.service = service
        self.router = router
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if (error == nil) {
            guard
                let authentication = user.authentication,
                let email = user?.profile.email,
                let accessTokken = authentication.accessToken
            else { return }
            UserDataWrapper.email = email
            UserDataWrapper.googleAccessTokken = accessTokken
            if let complete = view?.complete {
                self.view?.dismiss(animated: true)
                self.view?.removeFromParent()
                complete()
                return
            }
            self.router?.onNext(nextView: .contacts)
        } else {
            print("\(error.localizedDescription)")
        }
    }
}
