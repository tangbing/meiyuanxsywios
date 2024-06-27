//
//  CLOrderSubmitGoodInfoHeadCell.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/7.
//

import UIKit

class CLOrderSubmitGoodInfoHeadCell: XSBaseTableViewCell {
    
    var height = 46
    
    var type:CLMyOrderShopType = .deliver(status:.waitPay,title:"") {
        didSet{
            switch type {
            case .deliver:
                shopTagLabel.text = "外卖"
                shopTagLabel.backgroundColor = .link
            case .groupBuy:
                shopTagLabel.text = "到店"
                shopTagLabel.backgroundColor = UIColor.qmui_color(withHexString: "#F11F16")
            case .privateKitchen:
                shopTagLabel.text = "私厨"
                shopTagLabel.backgroundColor = UIColor.qmui_color(withHexString: "#FF6E02")
            default:
                return
            }
        }
    }
    
    let baseView = UIView().then{
        $0.backgroundColor = .white
    }
    
    let shopTagLabel = UILabel().then{
        $0.text = "外卖"
        $0.textColor = .white
        $0.font = MYFont(size: 9)
        $0.backgroundColor = UIColor.qmui_color(withHexString: "#518DFF")
        $0.layer.cornerRadius = 2
        $0.clipsToBounds = true
        $0.textAlignment = .center
    }
    
    let shopLabel = UILabel().then{
        $0.text = "AAA商家名称"
        $0.textColor = .text
        $0.font = MYBlodFont(size: 16)
    }
    
    let line = UIView().then{
        $0.backgroundColor = .borad
    }
    
    override func configUI() {
        super.configUI()
        contentView.backgroundColor = .lightBackground
        
        contentView.addSubview(baseView)
        baseView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview()
        }
        baseView.hg_setCornerOnTopWithRadius(radius: 10)
        
        baseView.addSubviews(views: [shopTagLabel,shopLabel,line])
        
        shopTagLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(12.5)
            make.width.equalTo(23)
            make.height.equalTo(13)
        }
        shopLabel.snp.makeConstraints { make in
            make.left.equalTo(shopTagLabel.snp.right).offset(5)
            make.centerY.equalTo(shopTagLabel.snp.centerY)
        }
        
        line.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(shopTagLabel.snp.bottom).offset(10)
            make.height.equalTo(0.5)
        }
    }
}
