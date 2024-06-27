//
//  CLMyOrderDetailShopInfoCell.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/1.
//

import UIKit
import QMUIKit
import Kingfisher

class CLMyOrderDetailShopInfoCell: XSBaseTableViewCell {
    
    
    let baseView =  UIView().then{
        $0.backgroundColor = .white
        $0.hg_setAllCornerWithCornerRadius(radius: 10)
    }
        
    let shopImage = UIImageView().then{
        $0.image = UIImage(named: "login_LOGO")
    }
    
    let shopName = UILabel().then{
        $0.text = "巴黎世家甜品工作室（罗湖店）"
        $0.textColor = .text
        $0.font = MYBlodFont(size: 13)
    }
    
    let telephoneBtn = QMUIButton(type: .custom).then{
        $0.setImage(UIImage(named: "merch_info_telephone"), for: .normal)
        $0.setTitle("联系商家", for: .normal)
        $0.titleLabel?.font = MYFont(size: 12)
        $0.setTitleColor(.twoText, for: .normal)
        $0.spacingBetweenImageAndTitle = 3
        $0.imagePosition = .top
        $0.addTarget(self, action: #selector(callPhone), for: .touchUpInside)
    }
    
   
    @objc func callPhone(){
        
    }
    
    ///评分Icon
    let scoreIcon =  UIImageView().then{
        $0.image = UIImage(named: "vip_score")
    }
    //评分
    let scoreLab =  UILabel().then{
        $0.font = MYFont(size: 12)
        $0.textColor = .warn
        $0.text = "4.9分"
    }
    
    let address = UILabel().then{
        $0.text = "深圳市罗湖区城市天地广场"
        $0.textColor = .twoText
        $0.font = MYFont(size: 12)
    }
    
    override func configUI() {
        self.contentView.backgroundColor = .lightBackground
        self.selectionStyle = .none
        contentView.addSubview(baseView)
        
        baseView.addSubviews(views: [shopImage,shopName,scoreLab,scoreIcon,address,telephoneBtn])
        
        baseView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview()
        }
        
        shopImage.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(15)
            make.height.width.equalTo(40)
        }
        
        shopName.snp.makeConstraints { make in
            make.left.equalTo(shopImage.snp.right).offset(5)
            make.top.equalTo(shopImage.snp.top)
        }
        
        scoreLab.snp.makeConstraints { make in
            make.left.equalTo(shopImage.snp.right).offset(5)
            make.top.equalTo(shopName.snp.bottom).offset(2.5)
        }
        scoreIcon.snp.makeConstraints { make in
            make.left.equalTo(scoreLab.snp.right)
            make.centerY.equalTo(scoreLab.snp.centerY)
        }
        address.snp.makeConstraints { make in
            make.left.equalTo(shopImage.snp.right).offset(5)
            make.top.equalTo(scoreLab.snp.bottom).offset(4)
        }
        telephoneBtn.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(55)
        }
    }
    

}

