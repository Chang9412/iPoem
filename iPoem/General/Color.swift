//
//  UIColorUtils.swift
//  iAccount
//
//  Created by zhengqiang zhang on 2022/5/12.
//

import UIKit

extension UIColor {
    open class func rgb(_ value: Int, alpha: CGFloat = 1) -> UIColor {
        let r = (value & 0xff0000) >> 16
        let g = (value & 0xff00) >> 8
        let b = (value & 0xff)
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
    }
    
    open class var theme: UIColor {
        get {
            return rgb(0xbdaead)
//            return rgb(0x621624)
        }
    }
    
    open class var tabbar: UIColor {
        get {
            return rgb(0x500a16)
        }
    }
    
    open class var text: UIColor {
        get {
            return rgb(0x333333)
        }
    }
    
    open class var detail: UIColor {
        get {
            return rgb(0x696969)
        }
    }
    
    open class var separator: UIColor {
        get {
            return rgb(0xe7e7e7)
        }
    }
    
    open class var defaultBackground: UIColor {
        get {
            return rgb(0xf2f2f5)
        }
    }
}
