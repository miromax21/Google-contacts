//
//  AppCoordinator.swift
//  ContactsApp
//
//  Created by maxim mironov on 01.05.2020.
//  Copyright © 2020 maxim mironov. All rights reserved.
//

import Foundation
import UIKit
class AppCoordinator: BaseCoordinator {
    var coordinator: Coordinator!
    init(coordinator: Coordinator!) {
        self.coordinator = coordinator
    }
    override func start() {
        super.start(coordinator: self.coordinator)
    }
}

