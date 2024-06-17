//
//  UIView + Extension.swift
//  Catstagram
//
//  Created by 김민지 on 4/7/24.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadiu: CGFloat {   // 모따기
        get {
            return layer.cornerRadius  // 얼마나 둥근지 정도의 수치를 나타냄
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}
