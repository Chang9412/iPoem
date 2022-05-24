//
//  IPPoemMoreView.swift
//  iPoem
//
//  Created by zhengqiang zhang on 2022/5/23.
//

import UIKit
import SnapKit

class IPPoemMoreView: UIView {

    lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .rgb(0x000000, alpha: 0.5)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismiss)))
        return view
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        return view
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.alwaysBounceVertical = false
        collectionView.register(IPPoemMoreViewCell.self, forCellWithReuseIdentifier: "IPPoemMoreViewCell")
        return collectionView
    }()
    
    lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("取消", for: .normal)
        button.titleLabel?.font = .songTi(20.adjust())
        button.setTitleColor(.tabbar, for: .normal)
        button.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
        return button
    }()
    
    var titles: [String]!
    
    convenience init(titles: [String]) {
        self.init(frame: CGRect.zero)
        self.titles = titles
        setup()

    }
    
    var didSelectItem: ((Int)->())?

    override init(frame: CGRect) {
        super.init(frame: frame)
//        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup()  {
        addSubview(backgroundView)
        addSubview(contentView)
        contentView.addSubview(collectionView)
        contentView.addSubview(cancelButton)
        
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        let bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        contentView.snp.makeConstraints { make in
            make.left.bottom.right.equalToSuperview()
            make.height.equalTo(CGFloat(titles.count) * 50.adjust() + 50.adjust() + bottom)
        }
        collectionView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(titles.count * 50.adjust())
        }
        cancelButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(collectionView.snp.bottom)
            make.height.equalTo(50.adjust())
        }
        
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        backgroundView.alpha = 0
        let bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        contentView.transform = CGAffineTransform(translationX: 0, y: bottom+50.adjust()+50.adjust()*CGFloat(titles.count))
        UIView.animate(withDuration: 0.25) {
            self.backgroundView.alpha = 1
            self.contentView.transform = CGAffineTransform.identity
        }
    }
    
    @objc func dismiss() {
        UIView.animate(withDuration: 0.25) {
            self.backgroundView.alpha = 0
            self.contentView.transform = CGAffineTransform(translationX: 0, y: self.contentView.bounds.height)
        } completion: { _ in
            self.removeFromSuperview()
        }
    }
}

extension IPPoemMoreView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IPPoemMoreViewCell", for: indexPath) as! IPPoemMoreViewCell
        cell.titleLabel.text = titles?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 50.adjust())
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let didSelectItem = didSelectItem {
            didSelectItem(indexPath.item)
        }
        dismiss()
    }
}


class IPPoemMoreViewCell: UICollectionViewCell {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .tabbar
        label.font = .songTi(20.adjust())
        return label
    }()
    
    lazy var iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "search")?.withTintColor(.tabbar)
        return imageView
    }()
    
    lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .separator
        return view
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup()  {
        contentView.addSubview(titleLabel)
        contentView.addSubview(iconView)
        contentView.addSubview(lineView)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(contentView.snp.centerX).offset(16)
            make.centerY.equalToSuperview()
        }
        iconView.snp.makeConstraints { make in
            make.right.equalTo(titleLabel.snp.left).offset(-10)
            make.centerY.equalToSuperview()
        }
        lineView.snp.makeConstraints { make in
            make.left.equalTo(12)
            make.right.equalTo(-12)
            make.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }
    
}
