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
    
    func setDate(value: Date?, for key: UserDataKeysEnum ){
        guard let value = value else { return }
        let dateFormatter = ISO8601DateFormatter()
        keychain.set(dateFormatter.string(from: value), forKey: key.rawValue)
    }
    func getDate(for key: UserDataKeysEnum) -> Date?{
        let dateFormatter = ISO8601DateFormatter()
        guard
            let value = keychain.get(key.rawValue),
            let date = dateFormatter.date(from: value)
        else {
            return nil
        }
        return date
    }
    

}
