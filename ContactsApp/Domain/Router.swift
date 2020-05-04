////
////  Router.swift
////  Google contacts
////
////  Created by maxim mironov on 27.03.2020.
////  Copyright © 2020 maxim mironov. All rights reserved.
////
//
//import UIKit
//import  RxCocoa
//import RxSwift
//final class Routerb: RouterProtocol {
//    var navigationController: UINavigationController!
//    var userDataProvider = UserDataProvider()
//
//    init(navigationController :UINavigationController, firstView: ControllersEnum = .login ) {
//       // self.navigationController = navigationController
//        //self.setAsRoot(viewControllerAsRoot: getVC(nextView: firstView))
//    }
//
//    func onNext(nextView: UIViewController){
//        navigateTo(nextView: nextView)
//    }
//    func present(presentView: ControllersEnum, completion: ((PresentableViewController) -> ())?) {
//        if let presentView = getVC(nextView: presentView) as? PresentableViewController{
//            presentView.complete = {
//                if let completion = completion{
//                    completion(presentView)
//                }
//                return
//            }
//            self.navigationController.viewControllers.last?.present(presentView , animated: true)
//        }
//    }
//
//    func goBackward() {
//        if self.navigationController.viewControllers.count > 1 {
//            self.navigationController.popToRootViewController(animated: true)
//        }
//    }
//
//  // MARK: Private Methods
//    private func navigateTo(nextView: UIViewController) {
//        self.navigationController.pushViewController(nextView, animated: true)
//    }
//
//    private func getVC(nextView: ControllersEnum) -> UIViewController{
//        var vc:  UIViewController!
////        switch nextView {
////            case .login:
////                vc = LoginViewModel.init(router: self).Output
////            case .contacts:
////                let vcc = ContactsViewController()
////                vcc.setUp(router: self)
////                //vc.s
////                vc = vcc
////            case .contactsDetails(let contact):
////                vc = DetailViewModel.init(router: self, contact: contact).Output
////        }
//        return vc
//    }
//
//    private func goForward(next:UIViewController?){
//        guard let next = next else {return}
//        self.navigationController.pushViewController(next, animated: true)
//    }
//
//    private func setAsRoot(viewControllerAsRoot:UIViewController?)  {
//        guard let viewController = viewControllerAsRoot else {return}
//        self.navigationController.viewControllers = [viewController]
//    }
//
//}
