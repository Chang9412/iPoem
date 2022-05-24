//
//  String.swift
//  iAccount
//
//  Created by zhengqiang zhang on 2022/5/16.
//

import Foundation

extension String {
    
//    var length: Int {
//        return count
//    }
//    subscript (i: Int) -> String {
//        return self[i ..< i + 1]
//    }
//    
//    func substring(fromIndex: Int) -> String {
//        return self[min(fromIndex, length) ..< length]
//    }
//    
//    func substring(toIndex: Int) -> String {
//        return self[0 ..< max(0, toIndex)]
//    }
//    
//    subscript (r: Range<Int>) -> String {
//        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
//                                            upper: min(length, max(0, r.upperBound))))
//        let start = index(startIndex, offsetBy: range.lowerBound)
//        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
//        return String(self[start ..< end])
//    }
}

extension String {
    static var privacy: String {
        get {
            return "https://docs.qq.com/doc/p/6262fd2c858bcfebe43d3f3c4dba38633e37a6e2?u=f8d6d4eee5504f66bdc4c3d41a967fb9&dver=3.0.27548027"
        }
    }
    
    static var users: String {
        get {
            return "https://docs.qq.com/doc/p/e6eb1f0bcaa3f27efef1b917274706690a4b5d6e?u=f8d6d4eee5504f66bdc4c3d41a967fb9&dver=3.0.27536109"
        }
    }
}

extension String {
    
    static func baike(_ param: String?) -> String {
        if let param = param {
            return "https://baike.baidu.com/item/\(param)".addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? "https://baike.baidu.com/item"
        }
        return "https://baike.baidu.com/item"
    }
}
