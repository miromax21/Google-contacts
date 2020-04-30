//
//  UITableViewCellExtention.swift
//  ContactsApp
//
//  Created by maxim mironov on 17.04.2020.
//  Copyright © 2020 maxim mironov. All rights reserved.
//

import UIKit
extension UITableViewCell{
    class var identifier: String{
        return String(describing: self)
    }
}
