//
//  CLOrderMemberCouponCell.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/8.
//

import UIKit

class CLOrderMemberCouponCell: XSBaseTableViewCell {
    
    var upgradBlock:(()->())?
    
    let baseView = UIView().then{
        $0.backgroundColor = .white
    }
    
    let image = UIImageView().then{
        $0.image = UIImage(named: "icon_member1")
    }
    let title = UILabel().then{
        $0.text = "会员红包"
        $0.textColor = .text
        $0.font = MYFont(size: 14)
    }
    let info = UILabel().then{
        $0.text = "无门槛"
        $0.textColor = .fourText
        $0.font = MYFont(size: 14)
    }
    let price = UILabel()
    
    let cashCoupon = UIButton().then{
        $0.setTitle("去兑换7元会员红包", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = MYFont(size: 10)
        $0.setBackgroundImage(UIImage(named: "btnBackImg"), for: .normal)
        $0.hg_setAllCornerWithCornerRadius(radius: 2)
        $0.addTarget(self, action: #selector(upgrade), for: .touchUpInside)
    }
    
    let memberCoupon = UIButton().then{
        $0.setTitle("会员红包", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = MYFont(size: 10)
        $0.setBackgroundImage(UIImage(named: "btnBackImg"), for: .normal)
    }
    
    @objc func upgrade(){
        guard let action = upgradBlock else {return}
        action()
    }
    
    override func configUI() {
        super.configUI()
        contentView.backgroundColor = .lightBackground
        contentView.addSubview(baseView)
        baseView.addSubviews(views: [image,title,info,price,cashCoupon])
        
        let str = "-￥5.0"
        price.attributedText = str.setAttributed(font: MYFont(size: 12), textColor: .twoText, lineSpaceing: 0, wordSpaceing: -1, rangeFont: MYFont(size: 16), range: NSMakeRange(2,str.count - 2))
        
        baseView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.top.equalToSuperview()
        }
        
        image.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(16)
        }
        
        title.snp.makeConstraints { make in
            make.left.equalTo(image.snp.right).offset(7)
            make.centerY.equalTo(image.snp.centerY)
        }
        
        info.snp.makeConstraints { make in
            make.left.equalTo(title.snp.right).offset(10)
            make.centerY.equalTo(image.snp.centerY)
        }
        
        price.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.centerY.equalTo(image.snp.centerY)
        }
        
        cashCoupon.snp.makeConstraints { make in
            make.right.equalTo(price.snp.left).offset(-2)
            make.centerY.equalTo(price.snp.centerY)
            make.height.equalTo(13)
            make.width.equalTo(95)
        }
        
    }

}
