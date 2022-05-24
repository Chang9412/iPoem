//
//  IPPoemCateCell.swift
//  iPoem
//
//  Created by zhengqiang zhang on 2022/5/22.
//

import UIKit
import SnapKit


class IPPoemCateCell: UICollectionViewCell {

    lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .text
        label.font = .songTi(20.0.adjust())
        label.textAlignment = .center
        return label
    }()
    
    var cate: IPPoemCate? {
        didSet {
            self.imageView.image = cate?.image
            self.titleLabel.text = cate?.title
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup()  {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
