//
//  IPNavigationController.swift
//  iAccount
//
//  Created by zhengqiang zhang on 2022/5/12.
//

import UIKit

public protocol IPViewControllGobackDelegate: NSObjectProtocol {
    func ipnGoback()
}

//extension UIViewController: IPViewControllGobackDelegate {
//    public func ipnGoback() {
//
//    }
//}

class IPNavigationController: UINavigationController, UINavigationControllerDelegate {

    var pushing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationBar.isTranslucent = false
        navigationBar.barTintColor = .theme
        navigationBar.backgroundColor = .theme
//        navigationBar.setBackgroundImage(UIImage.color(UIColor.theme), for: .default)
        navigationBar.titleTextAttributes = [.foregroundColor:UIColor.white, .font:UIFont.boldSystemFont(ofSize: 17)]
        self.delegate = self;
        
        if #available(iOS 13.0, *) {
            let navigationBarApperance =  UINavigationBarAppearance()
            navigationBarApperance.backgroundColor = navigationBar.backgroundColor
            navigationBarApperance.backgroundEffect = nil
            navigationBarApperance.shadowColor = .clear
            navigationBarApperance.titleTextAttributes = navigationBar.titleTextAttributes!
            navigationBar.scrollEdgeAppearance = navigationBarApperance
            navigationBar.standardAppearance = navigationBarApperance
            
        } else {

        }
        
        if let gesture = interactivePopGestureRecognizer, let target = interactivePopGestureRecognizer?.delegate {
            let targetView = gesture.view
            let sel = Selector(("handleNavigationTransition:"))
            let pan = UIPanGestureRecognizer(target: target, action: sel)
            targetView?.addGestureRecognizer(pan)
            pan.delegate = self
            gesture.isEnabled = false
        }
        
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        pushing = false
    }
    
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.pushing {
            return
        }
        self.pushing = true
        if self.viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            let barItem = UIBarButtonItem(image: UIImage(named: "nav_back"), style: .plain, target: self, action: #selector(pop))
            barItem.tintColor = UIColor.white
            viewController.navigationItem.leftBarButtonItem = barItem
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    @objc func pop() {
        if let vc = topViewController as? IPViewControllGobackDelegate {
            vc.ipnGoback()
            return
        }
        popViewController(animated: true)
    }
    
    //
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        self.pushing = false
    }

    

}


extension IPNavigationController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if viewControllers.count <= 1 {
            return false
        }
        
//        if let _ = value(forKey: "_isTransitioning") as? Bool {
//            return false
//        }
        
        if let ges = gestureRecognizer as? UIPanGestureRecognizer {
            let p = ges.translation(in: gestureRecognizer.view)
            if p.x <= 0 {
                return false
            }
        }
            
        return true
    }
}
