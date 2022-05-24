//
//  IPMoreViewController.swift
//  iPoem
//
//  Created by zhengqiang zhang on 2022/5/21.
//

import UIKit
import StoreKit

class IPMoreViewController: UIViewController {

    let items = ["我的收藏", "反馈与建议", "去评分鼓励我们", "当前版本"]
    var reviewedInApp = false
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), collectionViewLayout: layout)
        collectView.delegate = self
        collectView.dataSource = self
        collectView.backgroundColor = .clear
        collectView.alwaysBounceVertical = true
        collectView.register(IPMoreCell.self, forCellWithReuseIdentifier: "IPMoreCell")
        return collectView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "更多"
        view.backgroundColor = .white
        let barItem =  UIBarButtonItem(image: UIImage(named: "nav_back"), style: .plain, target: self, action: #selector(goback))
        barItem.tintColor = .white
        navigationItem.leftBarButtonItem = barItem
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
    }
    
    @objc func goback() {
        if navigationController?.viewControllers.count == 1 {
            navigationController?.dismiss(animated: true)
            return
        }
        navigationController?.popViewController(animated: true)
    }

    

}

extension IPMoreViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IPMoreCell", for: indexPath) as! IPMoreCell
        cell.titleLabel.text = items[indexPath.row]
        if indexPath.item == 3 {
            cell.detail = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        } else {
            cell.detail = nil
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 24, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 12, bottom: 12, right: 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 0 {
            let vc = IPFavViewController()
            navigationController?.pushViewController(vc, animated: true)
            return
        }
        if indexPath.item == 1 {
            let urlString = "https://wj.qq.com/s2/10275506/2494/"
            guard let url = URL(string: urlString) else { return }
            let request = URLRequest(url: url)
            let vc = IPWebViewController(request: request)
            navigationController?.pushViewController(vc, animated: true)
            return
        }
        
        if indexPath.item == 2 {
            guard !reviewedInApp else {
                // TODO: 更换id
                let appid = "1625107781"
                let urlString = "https://itunes.apple.com/us/app/itunes-u/id\(appid)?action=write-review&mt=8"
                guard let url = URL(string: urlString) else { return }
                UIApplication.shared.open(url)
                return
            }
            SKStoreReviewController.requestReview()
            reviewedInApp = true
            return
        }
    }
}
