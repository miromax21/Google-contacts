//
//  LoginViewController.swift
//  Google contacts
//
//  Created by maxim mironov on 31.03.2020.
//  Copyright © 2020 maxim mironov. All rights reserved.
//

import UIKit
import GoogleSignIn
import GoogleUtilities
class LoginViewController: UIViewController{

    @IBOutlet weak var login: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loadingSpinner: UIActivityIndicatorView!
    
    var presentor: LoginViewPresenterProtocol!
    override func viewDidLoad() {
        super.viewDidLoad()
        ConfigureGoogleSignInButton()
    }
    
    @IBAction func SignIn(_ sender: Any) {
        
    }
    fileprivate func ConfigureGoogleSignInButton(){
        let googleSignButton = GIDSignInButton()
        googleSignButton.center = view.center
        googleSignButton.bottomAnchor.anchorWithOffset(to: view.safeAreaLayoutGuide.bottomAnchor)
        view.addSubview(googleSignButton)
        GIDSignIn.sharedInstance().presentingViewController = self
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().presentingViewController = self
    }
}

extension LoginViewController:GIDSignInDelegate{
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        self.presentor.sign(signIn, didSignInFor: user, withError: error)
    }
}
