//
//  UIColor+Extension.swift
//  RxNews
//
//  Created by minho on 2021/05/27.
//

import UIKit

extension UIColor {
    static func rgba(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat) -> UIColor {
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    }

    static var primary: UIColor { return UIColor.rgba(116, 185, 255,1.0) }
}
