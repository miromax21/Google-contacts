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
    case password = "(?=.*[!@#$%^&*?])"
    case email = "^([a-zA-Z0-9_\\-\\.]+)@([a-zA-Z0-9_\\-\\.]+)\\.([a-zA-Z]{2,5})$"
    case any = ".+"
    
    func validate(text: String) -> Bool {
        return NSPredicate(format: "SELF MATCHES %@", self.rawValue).evaluate(with: text)
    }
    
    func validate(text: String, validation: [ExtendedValidation]? ) -> Bool {
        
        if !NSPredicate(format: "SELF MATCHES %@", self.rawValue).evaluate(with: text){
            return false
        }
        
        if let validation = validation {
            for valide in validation{
                if !valide.validate(val: text){
                    return false
                }
            }
        }
        
        return true
    }
}

enum ExtendedValidation{
    case lenght(from:Int? = 0, to:Int? = 999)
    
    func validate(val:String) -> Bool {
        switch  self {
             case .lenght(let from, let to):
                 return NSPredicate(format: "SELF MATCHES %@","^(?=.{\(from),\(to)}$).*").evaluate(with: val)
         }
    }
}
