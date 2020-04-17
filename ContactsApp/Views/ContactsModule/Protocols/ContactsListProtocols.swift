//
//  ContactsListProtocols.swift
//  ContactsApp
//
//  Created by maxim mironov on 17.04.2020.
//  Copyright © 2020 maxim mironov. All rights reserved.
//

import Foundation
import UIKit
protocol ContactsViewProtocol: class {
    func showAlert(title: String?, message: ContactsAlertMessegeEnum! , style : UIAlertController.Style?)
}
enum ContactsAlertMessegeEnum{
    case authorizationError
    case serverError(errorTitle:String, errorMessege: String?)
}
