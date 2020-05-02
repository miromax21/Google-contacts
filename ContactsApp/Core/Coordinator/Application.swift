//
//  Aplication.swift
//  ContactsApp
//
//  Created by maxim mironov on 02.05.2020.
//  Copyright © 2020 maxim mironov. All rights reserved.
//

import Foundation
import UIKit
protocol AppProtocol {
    func start(coordinator: Coordinator)
    func next(coordinator: Coordinator)
}

class App : AppProtocol {
    var appCoordinator: AppCoordinator!
    var window : UIWindow?
    init(window : UIWindow?){
        self.window = window
        let firstCoordinator = ContactsCoordinator()
        self.start(coordinator: firstCoordinator)
    }
    func start(coordinator: Coordinator) {
        self.appCoordinator = AppCoordinator(coordinator: coordinator)
        self.appCoordinator.start()
        show()
    }
    
    func next(coordinator: Coordinator)  {
        self.appCoordinator.next(coordinator: coordinator)
    }
    private func show(){
        self.window?.rootViewController = self.appCoordinator.navigationController
        self.window?.makeKeyAndVisible()
    }
    
}
