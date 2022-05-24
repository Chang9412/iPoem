//
//  IPMoreCell.swift
//  iPoem
//
//  Created by zhengqiang zhang on 2022/5/23.
//

import UIKit
import SnapKit

class IPMoreCell: UICollectionViewCell {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .text
        label.font = .songTi(18)
        return label
    }()
    
    lazy var detailLabel: UILabel = {
        let label = UILabel()
        label.textColor = .detail
        label.font = .songTi(15)
        label.textAlignment = .right
        return label
    }()
    
    lazy var arrowView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "arrow")
        return imageView
    }()
    
    lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .separator
        return view
    }()
    
    var detail: String? {
        didSet {
            if let detail = detail {
                detailLabel.text = detail
                arrowView.isHidden = true
            } else {
                detailLabel.text = nil
                arrowView.isHidden = false
            }
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
        contentView.addSubview(titleLabel)
        contentView.addSubview(arrowView)
        contentView.addSubview(detailLabel)

        contentView.addSubview(lineView)
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.centerY.equalToSuperview()
        }
        arrowView.snp.makeConstraints { make in
            make.right.equalTo(-10)
            make.centerY.equalToSuperview()
        }
        detailLabel.snp.makeConstraints { make in
            make.right.equalTo(-10)
            make.centerY.equalToSuperview()
        }
        lineView.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.right.equalTo(0)
            make.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }
}
