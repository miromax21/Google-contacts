//
//  ContactsAppTests.swift
//  ContactsAppTests
//
//  Created by maxim mironov on 01.04.2020.
//  Copyright © 2020 maxim mironov. All rights reserved.
//

import XCTest
@testable import ContactsApp
class MockView: ContactsViewProtocol {
    func success() {
    }
    
    func failure(error: Error) {
    }
}
class MockGoogleService:NetworkServiceProtocol{
    var contacts: [Contact]!
    init(){}
    convenience init(contacts:[Contact]?){
        self.init()
        self.contacts = contacts
    }
    func getContacts(completion: @escaping (Result<[Contact]?, Error>) -> Void) {
        if let contacts = contacts{
            completion(.success(contacts))
        }else {
            let error = NSError(domain: "0", code: 0, userInfo: nil)
            completion(.failure(error))
        }
    }
  
}
class ContactsPresenterTest: XCTestCase {
    var view: MockView!
    var presenter: ContactsPresentor!
    var googleService: NetworkServiceProtocol!
    var router: RouterProtocol!
    var contacts =  [Contact]()
    
    override func setUp() {
        let nav = UINavigationController()
        let module = ModuleBuilder()
        router = Router(navigationController: nav, moduleBuilder: module)
    }
    override func tearDownWithError() throws {
        view = nil
        googleService = nil
        presenter = nil
    }

    func testGetSuccessContacts(){
        let contact = Contact(id: 1, name: "n1", username: "un1", email: "e1")
        self.contacts.append(contact)
        
        view = MockView()
        googleService = MockGoogleService(contacts: contacts)
        presenter = ContactsPresentor(view: view, service: googleService, router: router)
        
        var catchContacts : [Contact]?
        
        googleService.getContacts { result in
            switch result{
                case .success(let contacts):
                    catchContacts = contacts
                case .failure(let error):
                    print(error)
            }
        }
        XCTAssertNotEqual(catchContacts?.count, 0)
        XCTAssertEqual(catchContacts?.count, contacts.count)
        
    }
    func testGetFailureContacts(){
        view = MockView()
        googleService = MockGoogleService()
        presenter = ContactsPresentor(view: view, service: googleService, router: router)
        
        var catchError : Error?
        
        googleService.getContacts { result in
            switch result{
                case .success(_):
                    break
                case .failure(let error):
                    catchError = error
            }
        }
        XCTAssertNotNil(catchError)
    }

}
