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
    var navigationController: UINavigationController { get set }
    var parentCoordinator: Coordinator! { get set }
    
    func start()
    func start(coordinator: Coordinator)
    func next(coordinator: Coordinator)
    func didFinish(coordinator: Coordinator)
}

class BaseCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator!
    var navigationController = UINavigationController()

    func start() {
        fatalError("Start method must be implemented")
    }
    
    func start(coordinator: Coordinator) {
        self.navigationController = coordinator.navigationController
        coordinator.parentCoordinator = self
        coordinator.start()
    }
    func next(coordinator: Coordinator) {
        self.childCoordinators.append(coordinator)
        self.willStart()
    }
    
    func willStart()  {
        var nextCoordinator : Coordinator
        if  self.childCoordinators.count > 0{
            nextCoordinator = self.childCoordinators.last!
        }else{
            nextCoordinator = self.parentCoordinator!
        }
        nextCoordinator.start()
        self.navigationController.viewControllers = nextCoordinator.navigationController.viewControllers
    }

    func didFinish(coordinator: Coordinator) {
        if let index = self.childCoordinators.firstIndex(where: { $0 === coordinator }) {
            self.childCoordinators.remove(at: index)
        }
    }
}
