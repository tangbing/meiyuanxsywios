//
//  XSVipAddBuyCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/8/28.
//

import UIKit

class XSVipAddBuyCell: XSBaseTableViewCell {
    var backView : UIView={
        let backView = UIView()
        backView.hg_setAllCornerWithCornerRadius(radius: 6)
        return backView
    }()

    var tipLab : UILabel={
        let lab = UILabel()
        lab.font = MYBlodFont(size: 16)
        lab.textColor = .text
        lab.text = "行膳会员红包加量包"
        return lab
    }()
    var subLab : UILabel={
        let lab = UILabel()
        lab.font = MYFont(size: 13)
        lab.textColor = .twoText
        lab.text = "1.红包有效期\n2.限行膳有味会员使用，若会员本月服务周期失效加量包也将失效\n3.限在线支付时使用\n4.可升级为更高价值的商家红包\n5.不限外卖/到店套餐订单业务\n6.限XX账户使用"
        lab.jk.changeLineSpace(space: 8)
        lab.numberOfLines = 0
        return lab
    }()

    override func configUI() {
        contentView.backgroundColor = .background
        backView.backgroundColor = .white

        contentView.addSubview(backView)
        backView.snp_makeConstraints { make in
            make.left.top.equalTo(10)
            make.right.equalTo(-10)
            make.bottom.equalTo(0)
        }
        
        backView.addSubview(tipLab)
        tipLab.snp_makeConstraints { make in
            make.left.equalTo(10)
            make.top.equalTo(15)
        }
        
        backView.addSubview(subLab)
        subLab.snp_makeConstraints { make in
            make.left.equalTo(tipLab.snp_left)
            make.top.equalTo(tipLab.snp_bottom).offset(10)
            make.right.equalTo(-10)
            make.bottom.equalTo(-15)
        }
    }
}
