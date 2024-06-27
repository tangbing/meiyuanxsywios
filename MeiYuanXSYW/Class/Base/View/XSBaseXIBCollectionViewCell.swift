//
//  XSBaseXIBCollectionViewCell.swift
//  MeiYuanXSYW
//
//  Created by Tb on 2021/9/12.
//

import UIKit
import Reusable

class XSBaseXIBCollectionViewCell: UICollectionViewCell, NibReusable {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configUI()
    }
    
    open func configUI() {}
}
