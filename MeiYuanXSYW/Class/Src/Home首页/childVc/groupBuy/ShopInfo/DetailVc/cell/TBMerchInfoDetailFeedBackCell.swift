//
//  TBMerchInfoDetailFeedBackCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/4.
//

import UIKit

class TBMerchInfoDetailFeedBackCell: XSBaseTableViewCell {

    lazy var feedBackTitleLab: UILabel = {
        let lab = UILabel()
        lab.textColor = .text
        lab.font = MYFont(size: 14)
        return lab
    }()
    
    
    override func configUI() {
        self.contentView.addSubview(feedBackTitleLab)
        feedBackTitleLab.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
