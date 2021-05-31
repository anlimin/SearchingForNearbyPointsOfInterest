//
//  InsetsLabel.swift
//  MapSearch
//
//  Created by Map04 on 2021-05-18.
//  Copyright © 2021 Apple. All rights reserved.
//

import UIKit

class InsetsLabel: UILabel {
    
    var topInset: CGFloat
    var bottomInset: CGFloat
    var leftInset: CGFloat
    var rightInset: CGFloat
    
    required init(withInsets top: CGFloat, _ left: CGFloat, _ bottom: CGFloat, _ right: CGFloat) {
        self.topInset = top
        self.bottomInset = bottom
        self.leftInset = left
        self.rightInset = right
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }

    override var intrinsicContentSize: CGSize {
        var originalContentSize = super.intrinsicContentSize
        originalContentSize.height += topInset + bottomInset
        originalContentSize.width += leftInset + rightInset
        layer.masksToBounds = true
        return originalContentSize
    }
}
