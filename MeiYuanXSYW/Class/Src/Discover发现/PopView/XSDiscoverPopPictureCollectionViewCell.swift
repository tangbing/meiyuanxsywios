//
//  XSDiscoverPopPictureCollectionViewCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/12/7.
//

import UIKit

class XSDiscoverPopPictureCollectionViewCell: XSBaseCollectionViewCell {
    
    lazy var contentImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        iv.image = UIImage(named: "group buy_picture4")
        return iv
    }()
    
    override func configUI() {
        super.configUI()
        
        self.contentView.addSubview(contentImageView)
        contentImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
}
