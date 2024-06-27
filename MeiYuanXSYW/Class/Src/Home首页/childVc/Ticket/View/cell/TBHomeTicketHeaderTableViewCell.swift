//
//  TBHomeTicketHeaderTableViewCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/10/21.
//

import UIKit
import QMUIKit

class TBHomeTicketHeaderTableViewCell: XSBaseTableViewCell {

    lazy var leftLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = .text
        lb.font = MYBlodFont(size: 16)
        lb.text = "我的红包/抵用券"
        return lb
    }()
    
    var seeAllBtn : QMUIButton={
        let btn = QMUIButton()
        btn.setTitle("查看全部(全部13张)", for: UIControl.State.normal)
        btn.setTitleColor(.twoText, for: UIControl.State.normal)
        btn.titleLabel?.font = MYFont(size: 13)
        btn.imagePosition = .right
        btn.isUserInteractionEnabled = false
        btn.setImage(UIImage(named: "home_hot_arow_right"), for: UIControl.State.normal)
        return btn
    }()
    
    override func configUI() {
        
        self.backgroundColor = .clear
        contentView.backgroundColor = .white
        contentView.hg_setAllCornerWithCornerRadius(radius: 10)
        
        self.contentView.addSubview(leftLabel)
        leftLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
        }
        
        self.contentView.addSubview(seeAllBtn)
        seeAllBtn.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-4)
            make.centerY.equalToSuperview()
        }
    }
    
}
