//
//  UIView+Extension.swift
//  FoodOrderApp
//
//  Created by Felix-ITS015 on 19/10/1944 Saka.
//  Copyright © 1944 Felix. All rights reserved.
//

import UIKit
extension UIView {
  @IBInspectable  var cornerRadius: CGFloat {
        get { return cornerRadius }
        set {
            self.layer.cornerRadius = newValue
        }
    }
}
