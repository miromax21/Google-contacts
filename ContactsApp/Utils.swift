//
//  Utils.swift
//  ContactsApp
//
//  Created by maxim mironov on 07.04.2020.
//  Copyright © 2020 maxim mironov. All rights reserved.
//

import Foundation
class Utils {
    init() {

    }
    static let shared = Utils()
    func JSONDecodeToData<T: Decodable>(data: Data?) -> T?{
        guard let data = data  else { return nil}
        let model = try? JSONDecoder().decode(T.self, from: data)
        guard let result = model else { return nil}
        return result
    }
    
    func GetBundleData(fileName: String, type: String? = "plist") -> NSDictionary? {
        guard let path = Bundle.main.path(forResource: fileName, ofType: type) else {
            return nil
        }
        return NSDictionary(contentsOfFile: path)
    }
}

extension Decodable {
    init(jsonData: Data) throws {
        self = try JSONDecoder().decode(Self.self, from: jsonData)
    }
}


