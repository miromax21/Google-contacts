//
//  GoogleMoyeService.swift
//  ContactsApp
//
//  Created by maxim mironov on 06.05.2020.
//  Copyright © 2020 maxim mironov. All rights reserved.
//

import Foundation
import Moya
enum GoogleMoyaService {
    case getContacts(accessToken : String, userEmail : String)
}
extension GoogleMoyaService: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://www.google.com/m8/feeds/contacts/")!
    //  return GoogleServiceEnum.Domain.url
    }
    
    var path: String {
        switch self {
            case .getContacts(let token, let userEmail):
                return  "\(userEmail)/full?access_token=\(token)&max-results=\(999)&alt=json&v=3.0"
            //  return GoogleServiceEnum.Contacts(token: token, userEmail: userEmail).path
        }
    }
    
    var method:  Moya.Method {
        switch self {
            case .getContacts:
                return .get
        }
    }

    var task: Task {
        return .requestPlain
    }

    var headers: [String: String]? {
        return ["Content-type": "text/json; charset=utf-8"]
    }

    var sampleData: Data {
        return Data()
    }
}

