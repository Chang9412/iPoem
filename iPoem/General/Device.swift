//
//  Device.swift
//  iPoem
//
//  Created by zhengqiang zhang on 2022/5/23.
//

import Foundation
import UIKit

extension UIDevice {
    
    static var isIphone: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }
    
}
