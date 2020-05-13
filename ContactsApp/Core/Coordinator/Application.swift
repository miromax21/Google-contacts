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

//protocol AppProtocol {
//    func start(coordinator: Coordinator)
//    func next(coordinator: Coordinator)
//}

class App  {
    
    var appCoordinator: AppCoordinator!
    var window : UIWindow!
    var cooordinator: Coordinator!
    
    init(window : UIWindow){
        self.window = window
        self.configureApp()
        self.start(coordinator: self.cooordinator)
    }
    
    func next(coordinator: Coordinator)  {
        self.appCoordinator.next(coordinator: coordinator)
    }
    
    func start(coordinator: Coordinator) {
        self.appCoordinator = AppCoordinator(coordinator: coordinator)
        self.appCoordinator.start()
        show()
    }
    func show()  {
        self.window.rootViewController = self.appCoordinator.navigationController
        self.window.makeKeyAndVisible()
    }

    fileprivate func configureApp(){
        self.cooordinator = ContactsCoordinator()
        //let firstCoordinator = LoginCoordinator()
        
// MARK: confuguration GIDSignIn
        if let key = Utils.shared.getBundleData(fileName: Constants.googleServicePlist.rawValue)?.value(forKey: Constants.googleServicePlistClientID.rawValue) as? String{
            GIDSignIn.sharedInstance().clientID  = key
            GIDSignIn.sharedInstance().scopes = ["https://www.googleapis.com/auth/contacts.readonly","https://www.googleapis.com/auth/plus.login","https://www.googleapis.com/auth/plus.me"];
        }
    }
    
}
