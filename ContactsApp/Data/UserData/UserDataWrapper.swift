//
//  UserDataWrapper.swift
//  ContactsApp
//
//  Created by maxim mironov on 13.04.2020.
//  Copyright © 2020 maxim mironov. All rights reserved.
//

import Foundation
struct UserDataWrapper {
    fileprivate static let userDataProvider = UserDataProvider()
    
    static var googleAccessTokken: String? {
        get {
            return userDataProvider.getData(for: .googleAccessTokken)
        }
        set {
            userDataProvider.setData(value: newValue, for: .googleAccessTokken)
        }
    }
    
    static var token: String? {
        get {
            return userDataProvider.getData(for: .googleIdToken)
        }
        set {
            userDataProvider.setData(value: newValue, for: .googleIdToken)
        }
    }
}
