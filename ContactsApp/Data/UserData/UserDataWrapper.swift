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
    
    static var googleAccessToken: String? {
        get {
            return userDataProvider.getData(for: .googleAccessTokken)
        }
        set {
            userDataProvider.setData(value: newValue, for: .googleAccessTokken)
        }
    }
    static var googleIdToken: String? {
        get {
            return userDataProvider.getData(for: .googleIdToken)
        }
        set {
            userDataProvider.setData(value: newValue, for: .googleIdToken)
        }
    }
    static var googleAccessTokenExpired: Date?{
        get {
            return userDataProvider.getDate(for: .googleAccessTokkenExpired)
         }
         set {
            userDataProvider.setDate(value: newValue, for: .googleAccessTokkenExpired)
         }
    }
    static var email: String? {
        get {
            return userDataProvider.getData(for: .userEmail)
        }
        set {
            userDataProvider.setData(value: newValue, for: .userEmail)
        }
    }
}
