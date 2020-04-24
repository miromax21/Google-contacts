//
//  Utils.swift
//  ContactsApp
//
//  Created by maxim mironov on 07.04.2020.
//  Copyright © 2020 maxim mironov. All rights reserved.
//

import Foundation
import Network
class Utils {
    
    fileprivate let utilsQueue = DispatchQueue(label: "utilsQueue")
    lazy var isInternetAvailable : Bool = {
        return checkInternetConnection()
    }()
    
    init() {}
    
    static let shared = Utils()
    func JSONDecodeToData<T: Decodable>(data: Data?) -> T?{
        guard let data = data else { return nil}
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

//MARK: privet Utils functions
    fileprivate func checkInternetConnection() -> Bool  {
        let monitor = NWPathMonitor()
        var connectionerror = false
        monitor.start(queue: self.utilsQueue)
        monitor.pathUpdateHandler   = { pathUpdateHandler in
             if !(pathUpdateHandler.status == .satisfied){
                connectionerror = true
             }
        }
        return connectionerror
    }
}


