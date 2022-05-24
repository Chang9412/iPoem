//
//  ToastHelper.swift
//  iAccount
//
//  Created by zhengqiang zhang on 2022/5/13.
//

import Foundation
import MBProgressHUD


class ToastHelepr {
    class func show(_ message: String?, _ complete: (()->Void)? = nil) {
        if let view = UIApplication.shared.keyWindow {
            let hud = MBProgressHUD.showAdded(to: view, animated: true)
            hud.isUserInteractionEnabled = false
            hud.label.text = message
            hud.mode = .text
            hud.removeFromSuperViewOnHide = true
            hud.hide(animated: true, afterDelay: 1.5)
            if let b = complete {
                DispatchQueue.main.asyncAfter(deadline: .now()+1.5) {
                    b()
                }
            }
        }
    }
    
    class func showMoreLines(_ message: String?, _ complete: (()->Void)? = nil) {
        if let view = UIApplication.shared.keyWindow {
            let hud = MBProgressHUD.showAdded(to: view, animated: true)
            hud.isUserInteractionEnabled = false
            hud.detailsLabel.text = message
            hud.detailsLabel.numberOfLines = 0
            hud.detailsLabel.font = .systemFont(ofSize: 16)
            hud.mode = .text
            hud.removeFromSuperViewOnHide = true
            hud.hide(animated: true, afterDelay: 1.5)
            if let b = complete {
                DispatchQueue.main.asyncAfter(deadline: .now()+1.5) {
                    b()
                }
            }
        }
    }
}
