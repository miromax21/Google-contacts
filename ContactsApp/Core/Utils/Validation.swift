//
//  Validation.swift
//  Google contacts
//
//  Created by maxim mironov on 30.03.2020.
//  Copyright © 2020 maxim mironov. All rights reserved.
//

import Foundation
enum Validation: String {
    case login = "^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$"
    case password = "password"
    case email = "email"
    
    func validate(text: String, additionally: ((String) -> Bool)? = nil) -> Bool {
        var valid = true
        if let additionally = additionally{
            valid = additionally(text)
        }
        return NSPredicate(format: "SELF MATCHES %@", self.rawValue).evaluate(with: text) && valid
    }
}

