//
//  ModuleBuilder.swift
//  Google contacts
//
//  Created by maxim mironov on 27.03.2020.
//  Copyright © 2020 maxim mironov. All rights reserved.
//

import UIKit

protocol AppModuleBuilderProtocol {
    var contactsModuleBuilder : ContactsModuleBuilder {get}
    var authenticationModuleBuilder: AuthenticationModuleBuilder {get}
}

class AppModuleBuilder: AppModuleBuilderProtocol {
    lazy var contactsModuleBuilder : ContactsModuleBuilder = {
        return ContactsModuleBuilder()
    }()
    lazy var authenticationModuleBuilder : AuthenticationModuleBuilder = {
         return AuthenticationModuleBuilder()
    }()
}
