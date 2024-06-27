//
//  CLOrderRefundNoticeCell.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/28.
//

import UIKit

class CLOrderRefundNoticeCell: XSBaseTableViewCell {
    let noticeLabel = UILabel().then{
        $0.text = "消费之后超过24小时不可以申请理赔"
        $0.textColor = .king
        $0.font = MYFont(size: 12)
    }
    
    override func configUI() {
        super.configUI()
        self.contentView.backgroundColor = .lightBackground
        contentView.addSubview(noticeLabel)
        noticeLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
    }
}
