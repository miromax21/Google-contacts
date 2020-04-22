//
//  Contacts.swift
//  Google contacts
//
//  Created by maxim mironov on 27.03.2020.
//  Copyright © 2020 maxim mironov. All rights reserved.
//

import Foundation

struct Contact:Codable {
    var id: UUID
    var name: String? = ""
    
    enum CodingKeys: String, CodingKey {
      case id
      case name
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
    }
    init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)
      id = try container.decode(UUID.self, forKey: .id)
      name = try container.decode(String.self, forKey: .name)
    }
    
    init(name:String?) {
        self.id = UUID.init()
        self.name = name
    }
}
