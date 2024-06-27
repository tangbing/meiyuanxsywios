//
//  XSVipBuySectionCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/8/25.
//

import UIKit
import QMUIKit
class XSVipBuySectionCell: XSBaseTableViewCell {
    
    
    
    var subLab : UILabel={
        let lab = UILabel()
        lab.font = MYFont(size: 12)
        lab.textColor = .tag
        lab.text = "购买提示：会员优惠券还有1天过期，请及时使用"
        return lab
    }()
    
    var tipLab : UILabel={
        let lab = UILabel()
        lab.font = MYBlodFont(size: 16)
        lab.textColor = .text
        lab.text = "会员优惠券"
        return lab
    }()
    var desLab : UILabel={
        let lab = UILabel()
        lab.font = MYFont(size: 12)
        lab.textColor = .twoText
        lab.text = "满15减5"
        lab.isHidden = true
        return lab
    }()
    var priceBtn : QMUIButton={
        let btn = QMUIButton()
        btn.setImage(UIImage(named: "vip_arrow_Check"), for: UIControl.State.normal)
        btn.setTitle("-￥5.00", for: UIControl.State.normal)
        btn.titleLabel?.font = MYBlodFont(size: 14)
        btn.setTitleColor(.red, for: UIControl.State.normal)
        btn.imagePosition = .right
        return btn
    }()


    

    override func configUI() {
        self.contentView.addSubview(subLab)
        subLab.snp_makeConstraints { make in
            make.top.equalTo(10)
            make.left.equalTo(15)
        }
        self.contentView.addSubview(tipLab)
        tipLab.snp_makeConstraints { make in
            make.left.equalTo(subLab.snp_left)
            make.top.equalTo(subLab.snp_bottom).offset(10)
        }
        self.contentView.addSubview(desLab)
        desLab.snp_makeConstraints { make in
            make.left.equalTo(tipLab.snp_right).offset(10)
            make.centerY.equalTo(tipLab.snp_centerY)
        }
        self.contentView.addSubview(priceBtn)
        priceBtn.snp_makeConstraints { make in
            make.right.equalTo(-20)
            make.centerY.equalTo(tipLab.snp_centerY)
        }
    }
}
