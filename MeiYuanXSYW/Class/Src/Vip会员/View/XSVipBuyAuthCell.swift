//
//  XSVipBuyAuthCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/8/25.
//

import UIKit

class XSVipBuyAuthCell: XSBaseTableViewCell {
    var topView : UIView = {
        let view = UIView()
        var tipLab : UILabel={
            let lab = UILabel()
            lab.font = MYBlodFont(size: 16)
            lab.textColor = .text
            lab.text = "会员权限"
            return lab
        }()
        view.addSubview(tipLab)
        tipLab.snp_makeConstraints { make in
            make.center.equalToSuperview()
        }

        var leftImg : UIImageView={
            let img = UIImageView()
            img.image = UIImage(named: "vip_buy_authRight")?.jk.flipHorizontal()
            return img
        }()
        view.addSubview(leftImg)
        leftImg.snp_makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(tipLab.snp_left).offset(-30)
            make.width.equalTo(65)
            make.height.equalTo(17)
        }

        var rigthImg : UIImageView={
            let img = UIImageView()
            img.image = UIImage(named: "vip_buy_authRight")
            return img
        }()
        view.addSubview(rigthImg)
        rigthImg.snp_makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(tipLab.snp_right).offset(30)
        }
        return view
    }()

    var tipLab : UILabel={
        let lab = UILabel()
        lab.font = MYFont(size: 12)
        lab.textColor = .twoText
        lab.text = "将在2021.07.21生效"
        lab.textAlignment = .center
        return lab
    }()

    override func configUI() {
        self.contentView.addSubview(topView)
        topView.snp_makeConstraints { make in
            make.top.equalTo(15)
            make.left.right.equalTo(0)
            make.height.equalTo(20)
        }
        self.contentView.addSubview(tipLab)
        tipLab.snp_makeConstraints { make in
            make.top.equalTo(topView.snp_bottom)
            make.left.right.equalTo(0)
            make.bottom.equalTo(-15)
        }
    }
    
}
