//
//  UIViewControllerExtensions.swift
//  Phunware
//
//  Created by Gurleen on 20/08/19.
//  Copyright © 2019 MAC_MINI_6. All rights reserved.
//

import UIKit

extension UIViewController {
  func pushVC(_ vc: UIViewController, animated: Bool = true) {
    navigationController?.pushViewController(vc, animated: animated)
  }
  
  func popVC() {
    navigationController?.popViewController(animated: true)
  }
  
  func presentVC(_ vc: UIViewController) {
    navigationController?.present(vc, animated: true, completion: nil)
  }
  
  func dismissVC() {
    dismiss(animated: true, completion: nil)
  }
  
  func topMostVC() -> UIViewController {
    let vc = UIApplication.topVC()
    guard let topVC = vc else {
      return UIViewController()
    }
    return topVC
  }
  
  func popTo<T: UIViewController>(toControllerType: T.Type) {
    if var viewControllers: [UIViewController] = self.navigationController?.viewControllers {
      viewControllers = viewControllers.reversed()
      for currentViewController in viewControllers {
        if currentViewController .isKind(of: toControllerType) {
          self.navigationController?.popToViewController(currentViewController, animated: true)
          break
        }
      }
    }
  }
  
  func alertBoxOKCancel(title: String?, message: String?, tapped: (() -> Void)?, cancelTapped: (() -> Void)?) {
    let messageString = NSMutableAttributedString.init(string: /message, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14, weight: .medium),
                                                                              NSAttributedString.Key.foregroundColor: Color.textBlack90.value])
    
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: { (_) in
      cancelTapped?()
    }))
    alert.setValue(messageString, forKey: "attributedMessage")
    alert.addAction(UIAlertAction.init(title: "OK", style: .default, handler: { (_) in
      tapped?()
    }))
    present(alert, animated: true, completion: nil)
  }
}
