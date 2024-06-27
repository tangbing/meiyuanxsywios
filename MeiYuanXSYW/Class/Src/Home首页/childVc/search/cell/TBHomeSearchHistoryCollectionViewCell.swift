//
//  TBHomeSearchHistoryCollectionViewCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/10/12.
//

import UIKit

class TBHomeSearchHistoryCollectionViewCell: XSBaseCollectionViewCell {
    lazy var titleLabel: UILabel = {
        let tl = UILabel()
        tl.textAlignment = .center
        tl.numberOfLines = 0
        tl.font = UIFont.systemFont(ofSize: 14)
        tl.textColor = UIColor.text
        return tl
    }()
    override func configUI() {
        self.backgroundColor = UIColor.hex(hexString: "#F8F8F8")
        
//        layer.borderWidth = 1
//        layer.borderColor = UIColor.background.cgColor
      
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)) }
    }
    

}
