//
//  IPFavViewController.swift
//  iPoem
//
//  Created by zhengqiang zhang on 2022/5/23.
//

import UIKit

class IPFavViewController: UIViewController {

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), collectionViewLayout: layout)
        collectView.delegate = self
        collectView.dataSource = self
        collectView.backgroundColor = .clear
        collectView.alwaysBounceVertical = true
        collectView.register(IPCateDetailCell.self, forCellWithReuseIdentifier: "IPCateDetailCell")
        return collectView
    }()
    
    var poems: [IPPoem]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        navigationItem.title = "我的收藏"
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        
        poems = IPPoemFavManager.shared.favPoems
        NotificationCenter.default.addObserver(self, selector: #selector(onFavPoemDidChange), name: .init(kFavPoemDidChange), object: nil)
    }
    
    @objc func onFavPoemDidChange() {
        poems = IPPoemFavManager.shared.favPoems
        collectionView.reloadData()
    }

    func gotoDetailVC(_ poem: IPPoem) {
        let vc = IPPoemViewController(poem: poem)
        navigationController?.pushViewController(vc, animated: true)
    }

}


extension IPFavViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return poems?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IPCateDetailCell", for: indexPath) as! IPCateDetailCell
        cell.poem = poems?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 24, height: 65)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 12, bottom: 12, right: 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        gotoDetailVC((poems?[indexPath.item])!)
    }
}
