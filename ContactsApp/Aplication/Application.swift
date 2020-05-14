//
//  Aplication.swift
//  ContactsApp
//
//  Created by maxim mironov on 02.05.2020.
//  Copyright © 2020 maxim mironov. All rights reserved.
//

import Foundation
import UIKit
import GoogleSignIn
class App  {
    
    var appCoordinator: AppCoordinator!
    var window : UIWindow!
    
    init(window : UIWindow){
        self.window = window
        self.configureApp()
        self.start()
    }
    
    func start() {
        self.appCoordinator.next(coordinator: .contcts)
        self.window.rootViewController = self.appCoordinator.router.navigationController
        self.window.makeKeyAndVisible()
    }
    
// MARK: confuguration
    fileprivate func configureApp(){
        self.appCoordinator = AppCoordinator(window: self.window)
        
        if let key = Utils.shared.getBundleData(fileName: Constants.googleServicePlist.rawValue)?.value(forKey: Constants.googleServicePlistClientID.rawValue) as? String{
            GIDSignIn.sharedInstance().clientID  = key
            GIDSignIn.sharedInstance().scopes = ["https://www.googleapis.com/auth/contacts.readonly","https://www.googleapis.com/auth/plus.login","https://www.googleapis.com/auth/plus.me"];
        }
    }
    
}
