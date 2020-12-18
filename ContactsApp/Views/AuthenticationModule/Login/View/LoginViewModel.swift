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

class LoginViewModel: ViewModelProtocol{
    
    var view: LoginViewController
    
    var Output: UIViewController! {
         get{
             return self.view
         }
     }
    init(coordinator: BaseCoordinator!) {
        self.view = LoginViewController()
        self.view.presentor = self
    }

    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print("\(error.localizedDescription)")
            return
        }
        guard
            let authentication = user.authentication,
            let email = user?.profile.email,
            let accessToken = authentication.accessToken,
            let idToken = authentication.idToken
        else { return }
        
        UserDataWrapper.email = email
        UserDataWrapper.googleAccessToken = accessToken
        UserDataWrapper.googleAccessTokenExpired = Date(timeIntervalSince1970: authentication.accessTokenExpirationDate.timeIntervalSince1970)
        UserDataWrapper.googleIdToken = idToken
        
        self.view.dismiss(animated: true)
        self.view.removeFromParent()
        if let complete = view.complete {
            complete()
        }
    }
}
