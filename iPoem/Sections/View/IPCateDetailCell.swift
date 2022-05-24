//
//  IPCateDetailCell.swift
//  iPoem
//
//  Created by zhengqiang zhang on 2022/5/22.
//

import UIKit
import SnapKit

class IPCateDetailCell: UICollectionViewCell {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .text
        label.font = .songTi(20.adjust())
        return label
    }()
    
    lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .detail
        return label
    }()
    
    lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .separator
        return view
    }()
    
    var poem: IPPoem? {
        didSet {
            self.titleLabel.text = poem?.title
            let type = poem?.type.rawValue ?? "唐"
            let author = "[\(type)] "+(poem?.name ?? "")
            let text = NSMutableAttributedString(string: author, attributes: [.foregroundColor:UIColor.rgb(0x999999), .font:UIFont.songTi(16.adjust())])
            self.authorLabel.attributedText = text
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
        contentView.addSubview(authorLabel)
        contentView.addSubview(lineView)
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(12)
            make.top.equalTo(10.adjust())
        }
        authorLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel)
            make.bottom.equalTo(-10.adjust())
        }
        lineView.snp.makeConstraints { make in
            make.left.equalTo(titleLabel)
            make.right.equalTo(-12)
            make.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }
    
}
