//
//  IPDailyCell.swift
//  iPoem
//
//  Created by zhengqiang zhang on 2022/5/23.
//

import UIKit
import SnapKit

class IPDailyHeader: UICollectionReusableView {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .text
        label.font = .songTi(28.adjust())
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .detail
        label.font = .songTi(16.adjust())
        label.textAlignment = .center
        
        return label
    }()
    
    var origin: SentenceResponse.Origin? {
        didSet {
            let style = NSMutableParagraphStyle()
            style.lineSpacing = CGFloat(10.adjust())
            style.alignment = .center
            let attributedText = NSAttributedString(string: origin?.title ?? "", attributes: [.paragraphStyle:style, .foregroundColor: titleLabel.textColor!, .font:titleLabel.font!])
            self.titleLabel.attributedText = attributedText
            self.authorLabel.text = "\(origin?.dynasty ?? "")  \(origin?.author ?? "")"
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        addSubview(authorLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(12)
            make.right.equalTo(-12)
            make.top.equalToSuperview()
            make.height.equalTo(28.adjust())
        }
        authorLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(10.adjust())
            make.height.equalTo(16.adjust())
        }
    }
    
    class func height(_ text: String?, _ width: CGFloat) -> CGFloat {
        let string = NSString(string: text ?? "")
        var height: CGFloat = 0
        let style = NSMutableParagraphStyle()
        style.lineSpacing = CGFloat(10.adjust())
        height += string.boundingRect(with: CGSize(width: width - 24, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, attributes: [.paragraphStyle:style, .font:UIFont.songTi(20.adjust())], context: nil).size.height
        return height + CGFloat(10.adjust() + 16.adjust() + 10.adjust())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class IPDailyCell: UICollectionViewCell {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .text
        label.font = .songTi(20.adjust())
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    var text: String? {
        didSet {
            let style = NSMutableParagraphStyle()
            style.lineSpacing = CGFloat(5.adjust())
            style.alignment = .center
            let attributedText = NSAttributedString(string: text ?? "", attributes: [.paragraphStyle:style, .foregroundColor: titleLabel.textColor!, .font:titleLabel.font!])
            titleLabel.attributedText = attributedText
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup()  {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.center.equalToSuperview()
        }
    }
    
    class func height(_ text: String, _ width: CGFloat) -> CGFloat {
        let string = NSString(string: text)
        var height: CGFloat = 0
        height += 8
        let style = NSMutableParagraphStyle()
        style.lineSpacing = CGFloat(5.adjust())
        height += string.boundingRect(with: CGSize(width: width - 40, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, attributes: [.paragraphStyle:style, .font:UIFont.songTi(20.adjust())], context: nil).size.height
        height += 8
        return height
    }
    
}
