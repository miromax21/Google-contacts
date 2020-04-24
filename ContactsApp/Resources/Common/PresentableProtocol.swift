//
//  PresentableProtocol.swift
//  ContactsApp
//
//  Created by maxim mironov on 23.04.2020.
//  Copyright © 2020 maxim mironov. All rights reserved.
//

import UIKit
protocol PresentableViewController: UIViewController {
    var complete : (()-> ())? { get set }
}

