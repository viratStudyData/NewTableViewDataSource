//
//  CommonFunctions.swift
//  Phunware
//
//  Created by Gurleen on 20/08/19.
//  Copyright © 2019 Code Brew Labs. All rights reserved.
//

import UIKit

class CommonFuncs {
    
    static let shared = CommonFuncs()
    
    func storyboardReInstantiateFor(_ purpose: ReInstantiatePurpose) {
        let window = UIApplication.shared.delegate?.window
        window??.rootViewController = purpose.vcLinked
        window??.backgroundColor = UIColor.white
        window??.makeKeyAndVisible()
        UIView.transition(with: window!!, duration: 0.4, options: UIView.AnimationOptions.transitionCrossDissolve, animations: {
        }, completion: { _ in })
    }
    
    
    
}

class Utility: UIViewController{
    
    static let functions = Utility()
    
    func shareTextImage(shareData : [Any]?){
        let activityViewController = UIActivityViewController(activityItems: shareData ?? [] , applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        UIApplication.topVC()?.present(activityViewController, animated: true, completion: nil)
    }
    
}
