//
//  LoginViewController.swift
//  Google contacts
//
//  Created by maxim mironov on 31.03.2020.
//  Copyright © 2020 maxim mironov. All rights reserved.
//

import UIKit
import GoogleSignIn

class LoginViewController: UIViewController, PresentableViewController, GIDSignInUIDelegate {
    
    var complete: (() -> ())?
    var presentor: LoginViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConfigureGoogleSignInButton()
    }
    
    fileprivate func ConfigureGoogleSignInButton(){
        let googleSignButton = GIDSignInButton()
        googleSignButton.center = view.center
        googleSignButton.bottomAnchor.anchorWithOffset(to: view.safeAreaLayoutGuide.bottomAnchor)
        view.addSubview(googleSignButton)
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
    }
}

// MARK: Extensions

extension LoginViewController: GIDSignInDelegate{
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        self.presentor.sign(signIn, didSignInFor: user, withError: error)
    }
}
