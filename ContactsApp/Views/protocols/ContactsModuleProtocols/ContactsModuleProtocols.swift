//
//  ModuleProtocols.swift
//  ContactsApp
//
//  Created by maxim mironov on 22.04.2020.
//  Copyright © 2020 maxim mironov. All rights reserved.
//

import UIKit
protocol ContactsModuleBuilderProtocol {
     func showDetails(contact:Contact?, router: RouterProtocol) -> UIViewController
     func showContacts(router: RouterProtocol) -> UIViewController
}
