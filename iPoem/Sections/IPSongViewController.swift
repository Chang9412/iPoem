//
//  IPSongViewController.swift
//  iPoem
//
//  Created by zhengqiang zhang on 2022/5/21.
//

import UIKit

class IPSongViewController: UIViewController {

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 12
        let collectView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), collectionViewLayout: layout)
        collectView.delegate = self
        collectView.dataSource = self
        collectView.backgroundColor = .clear
        collectView.alwaysBounceVertical = true
        collectView.register(IPPoemCateCell.self, forCellWithReuseIdentifier: "IPPoemCateCell")
        return collectView
    }()
    
    lazy var backgroundView: UIView = {
        let bgView = UIImageView()
        bgView.image = UIImage(named: "background_song")
        bgView.clipsToBounds = true
        bgView.contentMode = .scaleAspectFill
        return bgView
    }()
    
    let data = [IPPoemCate(title: "宋词 · 第一卷", image: "", fileName: "Song1", type: .song),
                IPPoemCate(title: "宋词 · 第二卷", image: "", fileName: "Song2", type: .song),
                IPPoemCate(title: "宋词 · 第三卷", image: "", fileName: "Song3", type: .song),
                IPPoemCate(title: "宋词 · 第四卷", image: "", fileName: "Song4", type: .song),
                IPPoemCate(title: "宋词 · 第五卷", image: "", fileName: "Song5", type: .song),
                IPPoemCate(title: "宋词 · 李清照", image: "", fileName: "L", type: .song),
                IPPoemCate(title: "宋词 · 苏轼", image: "", fileName: "S", type: .song),
                IPPoemCate(title: "宋词 · 欧阳修", image: "", fileName: "O", type: .song),
                IPPoemCate(title: "宋词 · 辛弃疾", image: "", fileName: "X", type: .song)

                ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        view.addSubview(backgroundView)
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        let barItem =  UIBarButtonItem(image: UIImage(named: "detail_more"), style: .plain, target: self, action: #selector(moreEvent))
        barItem.tintColor = .white
        navigationItem.rightBarButtonItem = barItem
    }
    
    @objc func moreEvent() {
        let vc = IPMoreViewController()
        let nav = IPNavigationController(rootViewController: vc)
        present(nav, animated: true)
    }

    func gotoCateVC(_ cate: IPPoemCate) {
        let vc = IPCateViewController(cate: cate)
        navigationController?.pushViewController(vc, animated: true)
    }

}


extension IPSongViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IPPoemCateCell", for: indexPath) as! IPPoemCateCell
        cell.cate = data[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 24, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        gotoCateVC(data[indexPath.item])
    }
}

