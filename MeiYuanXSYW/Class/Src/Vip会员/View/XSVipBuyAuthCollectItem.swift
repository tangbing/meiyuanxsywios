//
//  XSVipBuyAuthCollectItem.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/8/19.
//

import UIKit
import QMUIKit

class XSVipBuyAuthCollectItem: XSBaseCollectionViewCell {
    
    var model:[String:String]?{
        didSet{
            guard let dic = model else { return }
            tipLab.text = dic["tipLab"]
            subLab.text = dic["subLab"]
            iconImg.image = UIImage(named: dic["image"]!)
        }
    }
    
    var backView : UIView={
        let backView = UIView()
        backView.backgroundColor = .white
        return backView
    }()
    var iconImg : UIImageView={
        let img = UIImageView()
        img.image = UIImage(named: "vip_buy_envelope_icon")
        return img
    }()

    var tipLab : UILabel={
        let lab = UILabel()
        lab.font = MYBlodFont(size: 12)
        lab.textColor = .text
        lab.textAlignment = .center
        lab.text = "会员权限"
        return lab
    }()
    var subLab : UILabel={
        let lab = UILabel()
        lab.font = MYFont(size: 11)
        lab.textColor = .twoText
        lab.numberOfLines = 2
        lab.textAlignment = .center
        lab.text = "会员权限"
        return lab
    }()


    
    override func configUI(){
//        contentView.backgroundColor = .background
        contentView.addSubview(backView)
        backView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }

        backView.addSubview(iconImg)
        iconImg.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(44)
        }

        
        backView.addSubview(tipLab)
        tipLab.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.right.equalTo(0)
            make.top.equalTo(iconImg.snp_bottom).offset(5)
        }
        backView.addSubview(subLab)
        subLab.snp.makeConstraints { make in
            make.top.equalTo(tipLab.snp_bottom).offset(5)
            make.left.right.equalTo(0)
        }
    }

}
