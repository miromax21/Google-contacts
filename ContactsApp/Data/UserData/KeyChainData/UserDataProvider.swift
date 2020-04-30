//
//  UserDataProvider.swift
//  ContactsApp
//
//  Created by maxim mironov on 30.04.2020.
//  Copyright © 2020 maxim mironov. All rights reserved.
//

import Foundation
import KeychainSwift

struct UserDataProvider: UserDataProviderProtocol{
    var keychain = KeychainSwift()
    
    func setData(value:String?, for key: UserDataKeysEnum ){
        guard let value = value else { return }
        keychain.set(value, forKey: key.rawValue)
    }
    func getData(for key: UserDataKeysEnum) -> String?{
        return keychain.get(key.rawValue)
    }
}
