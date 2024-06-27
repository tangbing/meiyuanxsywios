//
//  CLMyOrderDetailGoodPriceAndNumView.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/1.
//

import UIKit

class CLMyOrderDetailGoodPriceAndNumCell: XSBaseTableViewCell {
    
    let baseView = UIView().then{
        $0.backgroundColor = .white
    }

    let goodName = UILabel().then{
        $0.text = "口味鱼"
        $0.textColor = .text
        $0.font = MYFont(size: 12)
    }
    
    let num = UILabel().then{
        $0.text = "(1份)"
        $0.textColor = .twoText
        $0.font = MYFont(size: 12)
    }
    
    let price = UILabel().then{
        $0.text = "￥68"
        $0.textColor = .text
        $0.font = MYFont(size: 12)
    }
    
    
    func setting(_ name:String,_ num:String,_ price:String){
        self.goodName.text = name
        self.num.text = num
        self.price.text = price
    }
    
    override func configUI() {
        contentView.addSubview(baseView)
        contentView.backgroundColor = .lightBackground
        
        baseView.addSubviews(views: [goodName,num,price])
        
        baseView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.bottom.equalToSuperview()
        }
        
        goodName.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(25.5)
            make.bottom.equalToSuperview()
        }
        num.snp.makeConstraints { make in
            make.left.equalTo(goodName.snp.right).offset(10)
            make.centerY.equalTo(goodName.snp.centerY)
        }
        price.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.centerY.equalTo(goodName.snp.centerY)
        }
    }

}
