//
//  GoogleServiceEnum.swift
//  ContactsApp
//
//  Created by maxim mironov on 08.05.2020.
//  Copyright © 2020 maxim mironov. All rights reserved.
//

import Foundation

fileprivate  let GoogleServiceBaseUrl:String = "https://www.google.com/m8/feeds/contacts/"

enum GoogleServiceEnum{
    case Domain
    case Users
    case Contacts(token:String, userEmail : String)
    var path : String {
        var path = ""
        switch self {
        case .Domain:
            path = ""
        case .Users:
            path = "/full"
        case .Contacts(let accessToken, let userEmail):
            path = "\(userEmail)/full?access_token=\(accessToken)&max-results=\(999)&alt=json&v=3.0"
        }
        return path
    }
    var url : URL{
        return URL(string: GoogleServiceBaseUrl + self.path)!
    }
}
