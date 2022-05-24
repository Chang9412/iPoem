//
//  Font.swift
//  iPoem
//
//  Created by zhengqiang zhang on 2022/5/23.
//

import Foundation
import UIKit

extension UIFont {
    class func songTi(_ fsize: CGFloat) -> UIFont {
//        for name in UIFont.familyNames {
//            print("===" + name + "===")
//            for fname in UIFont.fontNames(forFamilyName: name) {
//                print(fname)
//            }
//        }
        
        return UIFont(name: "FZSKBXKJW--GB1-0", size: fsize) ?? .systemFont(ofSize: fsize)
    }
    
    class func songTi(_ fsize: Float) -> UIFont {
        let size = CGFloat(fsize)
        return UIFont(name: "FZSKBXKJW--GB1-0", size: size) ?? .systemFont(ofSize: size)
    }
    
    class func songTi(_ fsize: Int) -> UIFont {
        let size = CGFloat(fsize)
        return UIFont(name: "FZSKBXKJW--GB1-0", size: size) ?? .systemFont(ofSize: size)
    }
}


//TODO: 泛型
public protocol IPAdjustiPadDelegate {
    associatedtype Number
    func adjust() -> Number
}

extension CGFloat: IPAdjustiPadDelegate {
    public typealias Number = CGFloat
    public func adjust() -> Number {
        return UIDevice.isIphone ? self : self * 1.5
    }
}

extension Float: IPAdjustiPadDelegate {
    public typealias Number = Float
    public func adjust() -> Number {
        return UIDevice.isIphone ? self : self * 1.5
    }
}

extension Double: IPAdjustiPadDelegate {
    public typealias Number = Double
    public func adjust() -> Number {
        return UIDevice.isIphone ? self : self * 1.5
    }
}


extension Int: IPAdjustiPadDelegate {
    public typealias Number = Int
    public func adjust() -> Number {
        return UIDevice.isIphone ? self : Int(Float(self) * 1.5)    }
}

//extension CGFloat {
//    var adjust: CGFloat {
//        get {
//            return UIDevice.isIphone ? self : self * 1.5
//        }
//    }
//}

//extension Float {
//    var adjust: Float {
//        get {
//            return UIDevice.isIphone ? self : self * 1.5
//        }
//    }
//}
//
//extension Int {
//    var adjust: Int {
//        get {
//            return UIDevice.isIphone ? self : Int(Float(self) * 1.5)
//        }
//    }
//}
