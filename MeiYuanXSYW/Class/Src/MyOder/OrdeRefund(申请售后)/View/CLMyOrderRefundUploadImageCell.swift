//
//  CLMyOrderRefundUploadImageCell.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/11/30.
//

import UIKit
import QMUIKit

class CLMyOrderRefundUploadImageCell: XSBaseTableViewCell {
    
    var collectionView:UICollectionView!
    
    override func configUI() {
        self.contentView.backgroundColor = .lightBackground
        self.selectionStyle = .none
        
        let layout =  UICollectionViewFlowLayout.init()
        layout.itemSize = CGSize(width: 75, height: 75)
        layout.minimumInteritemSpacing = 5
        collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CLMyOrderCommentCollectionCell.self, forCellWithReuseIdentifier: "CLMyOrderCommentCollectionCell")

        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = .lightBackground
        contentView.addSubview(collectionView)

        collectionView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview()
        }
        
    }
}
