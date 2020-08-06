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
        return GoogleServiceEnum.Domain.url.absoluteURL
    }
    
    var path: String {
        switch self {
            case .getContacts(let accessToken, let userEmail):
                return GoogleServiceEnum.UserContacts(userEmail: userEmail).path
        }
    }
    
    var method:  Moya.Method {
        return .get
    }

    var task: Task {
        return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
    }

    var headers: [String: String]? {
        return nil
    }

    var sampleData: Data {
        return Data()
    }
    
    var parameters: [String: Any] {
        guard let googleAccessToken = UserDataWrapper.googleAccessToken else {
            return  ["alt":"json"]
        }
        return ["alt":"json", "access_token": googleAccessToken]
    }

}

