//
//  UIImageUtils.swift
//  iAccount
//
//  Created by zhengqiang zhang on 2022/5/12.
//

import UIKit

extension UIImage {
    
    func original() -> UIImage {
        return self.withRenderingMode(.alwaysOriginal)
    }
    
    class func color(_ color: UIColor) -> UIImage? {
        let frame = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(frame.size)
        color.setFill()
        UIRectFill(frame)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
