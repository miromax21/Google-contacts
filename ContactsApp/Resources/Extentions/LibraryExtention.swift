//
//  LibraryExtention.swift
//  ContactsApp
//
//  Created by maxim mironov on 17.04.2020.
//  Copyright © 2020 maxim mironov. All rights reserved.
//

import Foundation
extension Decodable {
    init(jsonData: Data) throws {
        self = try JSONDecoder().decode(Self.self, from: jsonData)
    }
}
