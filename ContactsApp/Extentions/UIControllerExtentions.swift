//
//  UIControllerExtentions.swift
//  ContactsApp
//
//  Created by maxim mironov on 14.04.2020.
//  Copyright © 2020 maxim mironov. All rights reserved.
//

import Foundation
import UIKit

protocol UIViewControllerLoaderProtocol {
    func showSpinner(onView : UIView)
    func showLoadingView(onView : UIView, customView: UIView!, completion: ((UIView) -> ())? )
}
var loadingView : UIView?
extension UIViewController : UIViewControllerLoaderProtocol {
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)

        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        loadingView = spinnerView
    }
    func showLoadingView(onView : UIView, customView: UIView!, completion: ((UIView) -> ())?) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        DispatchQueue.main.async {
            spinnerView.addSubview(customView)
            onView.addSubview(spinnerView)
            if let completion = completion { 
                 completion(customView)
            }
        }
        loadingView = spinnerView
    }
    
    func removeLoader() {
        DispatchQueue.main.async {
            loadingView?.removeFromSuperview()
            loadingView = nil
        }
    }
}
