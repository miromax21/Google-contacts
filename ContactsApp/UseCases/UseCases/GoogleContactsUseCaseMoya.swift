//
//  GoogleContactsUseCaseMoya.swift
//  ContactsApp
//
//  Created by maxim mironov on 14.05.2020.
//  Copyright © 2020 maxim mironov. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import RxCocoa

struct AuthrisationTokePlugin: PluginType {
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var request = request
//        guard let token =  UserDataWrapper.googleAccessToken else {
//            return request
//        }
//        request.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        return request
    }
}
class GoogleContactsUseCaseMoya {
    
    var provider : MoyaProvider<GoogleMoyaService>!
    
    init(moyaProvider: MoyaProvider<GoogleMoyaService>) {
        self.provider = MoyaProvider<GoogleMoyaService>(plugins:  [AuthrisationTokePlugin()])
    }
    
    func start() -> PrimitiveSequence<SingleTrait, [Entry]?> {
        guard
            let googleAccessTokken = UserDataWrapper.googleAccessToken,
            let email = UserDataWrapper.email,
            let tokkenExpired = UserDataWrapper.googleAccessTokenExpired,
            tokkenExpired.timeIntervalSince1970 > NSDate().timeIntervalSince1970,
            googleAccessTokken != ""
        else {
             return Single.error(RequestError.authentification)
        }

        return self.provider
            .rx
            .request(.getContacts(userEmail: email))
            .filterSuccessfulStatusCodes()
            .map(UserData.self).flatMap { (userData)  in
                return Single.just(userData.feed?.entry)
            }
            .catchError { (error) -> PrimitiveSequence<SingleTrait, [Entry]?> in
                if let err = error as? Moya.MoyaError{
                    let error  = NSError(domain: "Moya.Error", code: err.response!.statusCode, userInfo: nil)
                    return Single.error(RequestError.serverError(error: error))
                }
                return Single.error(RequestError.any)
            }
    }
}
