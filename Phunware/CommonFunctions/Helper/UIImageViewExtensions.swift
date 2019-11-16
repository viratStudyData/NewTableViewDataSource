//
//  UIImageViewExtensions.swift
//  Phunware
//
//  Created by Gurleen on 20/08/19.
//  Copyright © 2019 MAC_MINI_6. All rights reserved.
//

import Foundation
import Nuke

extension UIImageView {
  func setImageKF(_ imageOrURL: Any?) {
    if let _image = imageOrURL as? UIImage {
      image = _image
    } else if let url = URL(string: /(imageOrURL as? String)) {
      var request = ImageRequest(url: url)
      request.memoryCacheOptions.isWriteAllowed = true
      request.priority = .high
      Nuke.loadImage(with: request, options: ImageLoadingOptions(transition: .fadeIn(duration: 0.33)), into: self)
    }
  }
}

extension UIView{
    // For insert layer in Foreground
    func addGradientLayerInForeground(frame: CGRect, colors:[UIColor]){
        let gradient = CAGradientLayer()
        gradient.frame = frame
        gradient.colors = colors.map{$0.cgColor}
        self.layer.addSublayer(gradient)
    }
    // For insert layer in background
    func addGradientLayerInBackground(frame: CGRect, colors:[UIColor]){
        let gradient = CAGradientLayer()
        gradient.frame = frame
        gradient.colors = colors.map{$0.cgColor}
        self.layer.insertSublayer(gradient, at: 0)
    }
}

