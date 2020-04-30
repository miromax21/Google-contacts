//
//  UIControllerExtentions.swift
//  ContactsApp
//
//  Created by maxim mironov on 14.04.2020.
//  Copyright © 2020 maxim mironov. All rights reserved.
//


import UIKit
import RxCocoa
import RxSwift

protocol LoaderViewProtocol {
    var isLoading : PublishSubject<Bool> {get}
}

final class LoaderView : LoaderViewProtocol{
    typealias Animate = (UIView) ->()?
    var loadingView: UIView! {
        willSet{
            if (newValue is UIActivityIndicatorView){
                self.isLoadingTypeDefault = false
            }
        }
    }
    var isLoading = PublishSubject<Bool>()
    var onView : UIView!
    var animate: Animate?
    
    var disposeBag = DisposeBag()
    var isLoadingTypeDefault: Bool = true
    
    init(onview: UIView, loadingView: UIView? = nil, animate : Animate? = nil) {
        
        self.onView = onview
        self.loadingView = loadingView ?? UIActivityIndicatorView.init(style: UIActivityIndicatorView.Style.large)
        setupBindings()
        self.loadingView.frame = onview.frame
        self.loadingView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        self.onView.addSubview(self.loadingView)
        self.animate = animate
        
    }
    func setupBindings(){
        self.isLoading.subscribe(onNext: { [unowned self] loading in
            self.loadingTypeDefault(show: loading)
        }).disposed(by: self.disposeBag)
    }
    
    private func loadingTypeDefault(show:Bool){
        if self.isLoadingTypeDefault {
            let ai = (self.loadingView as! UIActivityIndicatorView)
            show ? ai.startAnimating() : ai.stopAnimating()
            return
        }
        self.onView.addSubview(self.loadingView)
        if show, let animate = self.animate {
           animate(self.loadingView!)
        }
    }
    
}
