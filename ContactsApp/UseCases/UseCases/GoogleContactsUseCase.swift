//
//  GoogleContactsUseCase.swift
//  ContactsApp
//
//  Created by maxim mironov on 07.04.2020.
//  Copyright © 2020 maxim mironov. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Moya

class GoogleContactsUseCase  {
    var service: NetworkServiceProtocol!
    var provider : MoyaProvider<GoogleMoyaService>!
    
    init(service: NetworkServiceProtocol!, moyaProvider: MoyaProvider<GoogleMoyaService>) {
        self.service = service
        self.provider = MoyaProvider<GoogleMoyaService>()
    }
   func fetchContacts() -> Observable<[Entry]?>{
        guard
            let googleAccessTokken = UserDataWrapper.googleAccessTokken,
            let email = UserDataWrapper.email,
            let tokkenExpired = UserDataWrapper.googleAccessTokkenExpired,
            tokkenExpired.timeIntervalSince1970 > NSDate().timeIntervalSince1970
            else {
                return Observable.error(RequestError.authentification)
            }
    
        return Observable.deferred {
            return self.service.request(path: .Contacts(token: googleAccessTokken, userEmail: email) )
                .flatMap { (userData)  -> Observable<[Entry]?>  in
                    return Observable.of(userData?.feed?.entry)
            }
        }
    }

    func fetchContactsWithMoya() -> PrimitiveSequence<SingleTrait, [Entry]?> {
        guard
            let googleAccessTokken = UserDataWrapper.googleAccessTokken,
            let email = UserDataWrapper.email,
            let tokkenExpired = UserDataWrapper.googleAccessTokkenExpired,
            tokkenExpired.timeIntervalSince1970 < NSDate().timeIntervalSince1970
        else {
            return Single.error(RequestError.authentification)
        }

        return self.provider
            .rx
            .request(.getContacts(accessToken: googleAccessTokken, userEmail: email))
            .filterSuccessfulStatusCodes()
            .map(UserData.self).flatMap { (userData)  in
                return Single.just(userData.feed?.entry)
            }.catchError { (error) -> PrimitiveSequence<SingleTrait, [Entry]?> in
                if let err = error as? Moya.MoyaError{
                    let error  = NSError(domain: "Moya.Error", code: err.response!.statusCode, userInfo: nil)
                    return Single.error(RequestError.serverError(error: error))
                }
                return Single.error(RequestError.any)
            }
    }
    
}
