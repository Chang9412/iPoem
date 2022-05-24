//
//  IAGradientView.swift
//  iAccount
//
//  Created by zhengqiang zhang on 2022/5/13.
//

import UIKit

class GradientView: UIView {

    var start = CGPoint(x: 0, y: 0) {
        didSet {
            gradientLayer.startPoint = start
        }
    }
    var end = CGPoint(x: 1, y: 0) {
        didSet {
            gradientLayer.endPoint = end
        }
    }
    
    var colors: [CGColor]? {
        didSet {
            gradientLayer.colors = colors
        }
    }
    var locations: [NSNumber]? {
        didSet {
            gradientLayer.locations = locations
        }
    }
    
    lazy var gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.startPoint = start
        layer.endPoint = end
        layer.colors = colors
        layer.locations = locations
        return layer
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.addSublayer(gradientLayer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
}
