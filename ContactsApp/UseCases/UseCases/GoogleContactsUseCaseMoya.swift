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

class GoogleContactsUseCaseMoya {
    
    var provider : MoyaProvider<GoogleMoyaService>!
    
    init(moyaProvider: MoyaProvider<GoogleMoyaService>) {
        self.provider = MoyaProvider<GoogleMoyaService>()
    }
    
    func start() -> PrimitiveSequence<SingleTrait, [Entry]?> {
        guard
            let googleAccessTokken = UserDataWrapper.googleAccessTokken,
            let email = UserDataWrapper.email,
            let tokkenExpired = UserDataWrapper.googleAccessTokkenExpired,
            tokkenExpired.timeIntervalSince1970 > NSDate().timeIntervalSince1970,
            googleAccessTokken != ""
        else {
             return Single.error(RequestError.authentification)
        }

        return self.provider
            .rx
            .request(.getContacts(accessToken: googleAccessTokken, userEmail: email))
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
