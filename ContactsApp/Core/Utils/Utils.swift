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
    
    static let shared = Utils()
    
    fileprivate let utilsQueue = DispatchQueue(label: "utilsQueue")
    lazy var isInternetAvailable : Bool = {
        return checkInternetConnection()
    }()

    func getBundleData(fileName: String, type: String? = "plist") -> NSDictionary? {
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


