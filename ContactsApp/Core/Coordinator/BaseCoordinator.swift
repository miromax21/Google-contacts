//
//  BaseCoordinator.swift
//  ContactsApp
//
//  Created by maxim mironov on 01.05.2020.
//  Copyright © 2020 maxim mironov. All rights reserved.
//

import Foundation
import UIKit
protocol Coordinator: AnyObject {
    var appCoordinator: AppCoordinator! { get }
    func start() -> UIViewController
}

class BaseCoordinator: Coordinator {
    var appCoordinator: AppCoordinator!
    
    func start() -> UIViewController{
        fatalError("Start method must be implemented")
    }

    init(appCoordinator: AppCoordinator){
        self.appCoordinator = appCoordinator
    }
}
