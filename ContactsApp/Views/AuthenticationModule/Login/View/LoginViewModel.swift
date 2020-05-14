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
    
    var view: LoginViewController
   // var router: RouterProtocol
  //  let service: NetworkServiceProtocol!
    var Output: LoginViewController {
         get{
             return self.view
         }
     }
    init(coordinator: BaseCoordinator!) {
        self.view = LoginViewController()
        self.view.presentor = self
    }
//    required init() {
//        self.view = LoginViewController()
//        self.service = GoogleService()
//    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print("\(error.localizedDescription)")
            return
        }
        guard
            let authentication = user.authentication,
            let email = user?.profile.email,
            let accessTokken = authentication.accessToken
        else { return }
        
        UserDataWrapper.email = email
        UserDataWrapper.googleAccessTokken = accessTokken
        UserDataWrapper.googleAccessTokkenExpired = Date(timeIntervalSince1970: authentication.accessTokenExpirationDate.timeIntervalSince1970)
        
        if let complete = view.complete {
            self.view.dismiss(animated: true)
            self.view.removeFromParent()
            complete()
            return
        }
        
        let scene = UIApplication.shared.connectedScenes.first
        if let sd : SceneDelegate = (scene?.delegate as? SceneDelegate) {
           // sd.app.start(coordinator: ContactsCoordinator(router: ))
        }

    }
}
