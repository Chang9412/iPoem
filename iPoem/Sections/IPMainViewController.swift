//
//  IAMainViewController.swift
//  iAccount
//
//  Created by zhengqiang zhang on 2022/5/12.
//

import UIKit

class IPMainViewController: UITabBarController {

    var dailyVC = IPDailyViewController()
    var tangVC = IPTangViewController()
    var songVC = IPSongViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.barTintColor = .rgb(0x686868)
        tabBar.tintColor = .tabbar
        tabBar.backgroundColor = .white
    
        // 取消tabbar灰色背景
        let tabBarApperance = UITabBarAppearance()
        tabBarApperance.backgroundColor = tabBar.backgroundColor
        tabBarApperance.shadowColor = nil
        tabBarApperance.shadowImage = tabBar.shadowImage
        tabBar.standardAppearance = tabBarApperance
        
        // Do any additional setup after loading the view.
        setupChildViewController(dailyVC, title: "每日推荐", normalImage: "tab_daliy", selectedImage: "tab_daliy_selected")
        setupChildViewController(tangVC, title: "唐诗", normalImage: "tab_tang", selectedImage: "tab_tang_selected")
        setupChildViewController(songVC, title: "宋词", normalImage: "tab_song", selectedImage: "tab_song_selected")
        
        
    }
    

    func setupChildViewController(_ vc: UIViewController, title: String, normalImage: String, selectedImage: String) {
        let tabbarItem = UITabBarItem(title: title, image: UIImage(named: normalImage), selectedImage: UIImage(named: selectedImage)!.withTintColor(.tabbar).original())
        let nav = IPNavigationController(rootViewController: vc)
        addChild(nav)
        vc.navigationItem.title = title
        nav.tabBarItem = tabbarItem
    }

}
