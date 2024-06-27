//
//  XSSelectStandardItemCollectionViewCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/12/22.
//

import UIKit

class XSSelectStandardItemCollectionViewCell: XSBaseCollectionViewCell {
    
    lazy var titleLabel: UILabel = {
        let tl = UILabel()
        tl.textAlignment = .center
        tl.numberOfLines = 0
        tl.text = "11111"
        tl.font = UIFont.systemFont(ofSize: 14)
        tl.textColor = UIColor.text
        return tl
    }()
    
    override func configUI() {
        self.backgroundColor = UIColor.hex(hexString: "#F8F8F8")
        
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.hex(hexString: "#979797").cgColor
        
        hg_setAllCornerWithCornerRadius(radius: 16)
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)) }
        
    }
    
}
