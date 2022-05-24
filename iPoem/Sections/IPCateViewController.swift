//
//  IPCateViewController.swift
//  iPoem
//
//  Created by zhengqiang zhang on 2022/5/22.
//

import UIKit

class IPCateViewController: UIViewController {

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
    
    var cate: IPPoemCate!
    convenience init(cate: IPPoemCate) {
        self.init(nibName: nil, bundle: nil)
        self.cate = cate
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        navigationItem.title = cate.title
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        
    }
    

    func gotoDetailVC(_ poem: IPPoem) {
        let vc = IPPoemViewController(poem: poem)
        navigationController?.pushViewController(vc, animated: true)
    }

}


extension IPCateViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cate.conetnt.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IPCateDetailCell", for: indexPath) as! IPCateDetailCell
        cell.poem = cate.conetnt[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 24, height: 65.adjust())
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 12, bottom: 12, right: 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        gotoDetailVC(cate.conetnt[indexPath.item])
    }
}
