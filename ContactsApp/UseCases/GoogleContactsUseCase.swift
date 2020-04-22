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

class GoogleContactsUseCase : GoogleUseCases {
    var service: NetworkServiceProtocol!
    required init(service: NetworkServiceProtocol!) {
        self.service = service
    }
    
   func fetchContacts() -> Observable<[Contact]?>{
        guard let googleAccessTokken = UserDataWrapper.googleAccessTokken else { return Observable.of(nil)}
        return Observable.deferred {
            return self.service.fetch(path: .Contacts(token: googleAccessTokken)).flatMap { (data) -> Observable<[Contact]?> in
                
                var contscts = [Contact]()
                
                guard let data = data,
                      let json = try? JSONSerialization.jsonObject(with:data) as? NSDictionary,
                      let feeds = json["feed"] as? NSDictionary,
                      let entryDictionaries = feeds["entry"] as? [Dictionary<String, AnyObject>]
                else { return Observable.of(contscts)}

                for entryDictionary in entryDictionaries {
                    if let name = entryDictionary["gd$name"], let fullName = name["gd$fullName"] as? Dictionary<String, AnyObject>  {
                        let contact = Contact(name: fullName.first?.value as? String)
                        contscts.append(contact)
                    }
                }
 
                return Observable.of(contscts)
            }
        }
    }
}
