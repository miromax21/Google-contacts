//
//  UserDataProviderProtocols.swift
//  ContactsApp
//
//  Created by maxim mironov on 13.04.2020.
//  Copyright © 2020 maxim mironov. All rights reserved.
//

import Foundation

protocol UserDataProviderProtocol {
    func setData(value:String?, for key: UserDataKeysEnum)
    func getData(for key: UserDataKeysEnum) -> String?
}

enum UserDataKeysEnum:String{
    case googleIdToken
    case googleAccessTokken
}
