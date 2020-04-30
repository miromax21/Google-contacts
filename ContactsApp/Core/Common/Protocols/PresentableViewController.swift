//
//  PresentableViewController.swift
//  ContactsApp
//
//  Created by maxim mironov on 30.04.2020.
//  Copyright © 2020 maxim mironov. All rights reserved.
//

import Foundation
import UIKit
protocol PresentableViewController : UIViewController{
    var complete: (() -> ())? {get set}
}

