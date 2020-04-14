//
//  Validation.swift
//  Google contacts
//
//  Created by maxim mironov on 30.03.2020.
//  Copyright © 2020 maxim mironov. All rights reserved.
//

import Foundation
class Validator {
    func validate(text: String, with rule: Rule) -> Bool {
        return NSPredicate(format: "SELF MATCHES %@", rule.rawValue).evaluate(with: text)
    }
    
    func validate(validation:ValidationEnum) -> Bool{
        var valid = true
        switch validation{
            
        case .login(let value):
            valid = NSPredicate(format: "SELF MATCHES %@", Rule.login as! CVarArg).evaluate(with: value)
        case .password(let value):
            valid = NSPredicate(format: "SELF MATCHES %@", Rule.password as! CVarArg).evaluate(with: value)
        case .email(let value):
            valid = NSPredicate(format: "SELF MATCHES %@", Rule.email as! CVarArg).evaluate(with: value)
        }
        return valid
    }
}
enum Rule: String {
    case login = "^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$"
    case password = "password"
    case email = "email"
}

enum ValidationEnum {
    case login(String)
    case password(String)
    case email(String)
}
