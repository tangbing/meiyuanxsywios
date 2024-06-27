//
//  CLMyOrderCommonOtherCell.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/2.
//

import UIKit

class CLMyOrderCommonOtherCell: XSBaseTableViewCell {
    let baseView = UIView().then{
        $0.backgroundColor = .white
    }
    
    let shopImage = UIImageView().then{
        $0.image = UIImage(named: "test")
        $0.hg_setAllCornerWithCornerRadius(radius: 10)
    }

    let shopName = UILabel().then{
        $0.text = "商家名称"
        $0.textColor = .text
        $0.font = MYBlodFont(size: 16)
    }
    
    let des = UILabel().then{
        $0.text = "商家名称1张"
        $0.textColor = .text
        $0.font = MYFont(size: 13)
        $0.isHidden = true
    }
    
    let time = UILabel().then{
        $0.text = "2021.01.01消费"
        $0.textColor = .twoText
        $0.font = MYFont(size: 12)
    }
    
    let commentButton = UIButton().then{
        $0.setTitle("写评价", for: .normal)
        $0.setTitleColor(.king, for: .normal)
        $0.titleLabel?.font = MYFont(size: 14)
        $0.layer.borderWidth = 0.5
        $0.layer.borderColor = UIColor.king.cgColor
        $0.layer.cornerRadius = 12

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        commentButton.hg_setCorner(conrners: .allCorners, radius: 12, borderWidth: 0.5, borderColor: .king)
    }
    override func configUI() {
        super.configUI()
        contentView.backgroundColor = .lightBackground
        
        contentView.addSubview(baseView)
        baseView.addSubviews(views: [shopImage,shopName,des,time,commentButton])
        
        baseView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.top.equalToSuperview()
        }
        
        shopImage.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(10)
            make.width.height.equalTo(65)
        }
        
        shopName.snp.makeConstraints { make in
            make.left.equalTo(shopImage.snp.right).offset(9)
            make.top.equalTo(shopImage.snp.top)
        }
        
        des.snp.makeConstraints { make in
            make.left.equalTo(shopImage.snp.right).offset(9)
            make.top.equalTo(shopName.snp.bottom).offset(7)
        }
        
        time.snp.makeConstraints { make in
            make.left.equalTo(shopImage.snp.right).offset(9)
            make.bottom.equalTo(shopImage.snp.bottom).offset(-4)
        }
        
        commentButton.snp.makeConstraints { make in
            make.centerY.equalTo(shopImage.snp.centerY)
            make.right.equalToSuperview().offset(-10)
            make.width.equalTo(74)
            make.height.equalTo(24)
        }
    }
}
