//
//  XSDiscoverStudySpaceMerchInfoTableViewCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/12/6.
//

import UIKit

class XSDiscoverStudySpaceMerchInfoTableViewCell: XSBaseTableViewCell {

    
    lazy var containerView: UIView = {
        let contain = UIView()
        contain.backgroundColor = .white
        return contain
    }()
    
    lazy var bottomMerchInfoView: XSDiscoverRecommandMerchInfoView = {
        let merchInfo = XSDiscoverRecommandMerchInfoView()
        return merchInfo
    }()
    
    
    override func configUI() {
        self.contentView.backgroundColor = .clear
        
        self.contentView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
        }
        
        containerView.addSubview(bottomMerchInfoView)
        bottomMerchInfoView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
        }
    }

}
