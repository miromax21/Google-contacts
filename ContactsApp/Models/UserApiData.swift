//
//  UserApiData.swift
//  ContactsApp
//
//  Created by maxim mironov on 29.04.2020.
//  Copyright © 2020 maxim mironov. All rights reserved.
//

import Foundation
struct UserData : Codable{
    var feed : Feed?
    enum CodingKeys: String, CodingKey {
         case feed
     }
     init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.feed = try? container.decode(Feed.self, forKey: CodingKeys.feed)
    }
}

struct Feed : Codable{
    var entry: [Entry]?
    enum CodingKeys: String, CodingKey {
         case entry
     }

     init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.entry = try? container.decode([Entry].self, forKey: CodingKeys.entry)
    }
}
struct Entry: Codable{
    var gmail: Gmail?
    var title : String?
    var name : Name?
    
    enum CodingKeys: String, CodingKey {
         case gmail = "gd$email"
         case name = "gd$name"
         case title
     }
     init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.gmail = try? container.decode([Gmail].self, forKey: CodingKeys.gmail).first
        self.title = try? container.decode(SingleData.self, forKey: CodingKeys.title).key
    }
}

struct Gmail: Codable{
    var address: String?
    enum CodingKeys: String, CodingKey {
         case address
     }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.address = try? container.decode(String.self, forKey: CodingKeys.address)       
    }
}

struct Name: Codable{
    var fullName : String?
    
    enum CodingKeys: String, CodingKey {
        case fullName = "gd$fullName"
     }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.fullName = try? container.decode(SingleData.self, forKey: CodingKeys.fullName).key
    }
}
struct SingleData: Codable{
    var key : String?
    enum CodingKeys: String, CodingKey {
        case key = "$t"
     }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.key = try? container.decode(String.self, forKey: CodingKeys.key)
    }
}






