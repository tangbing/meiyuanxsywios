//
//  CLMyOrderMemberCell.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/11/30.
//

import UIKit

class CLMyOrderMemberCell: XSBaseTableViewCell {
    
    var type:CLMyOrderShopType = .deliver(status:.waitPay,title:"") {
        didSet {
            switch type {
            case .deliver:
                return
            case .groupBuy:
                return
            case .privateKitchen:
                return
            case .member(let status):
                selectView.statusType = type
                statusLabel.text = status
            case .allType(status: let status):
                return
            }
        }
    }
    
    let baseView = UIView().then{
        $0.layer.cornerRadius = 10
        $0.backgroundColor = .white
    }
    
    let label = UILabel().then{
        $0.backgroundColor = UIColor.qmui_color(withHexString: "#312534")!
        $0.layer.cornerRadius = 2
        $0.text = "会员"
        $0.textColor = .white
        $0.font = MYFont(size: 9)
        $0.textAlignment = .center
        $0.layer.cornerRadius = 2
    }
    
    let shopName = UILabel().then{
        $0.text = "行善有味"
        $0.textColor = .text
        $0.font = MYBlodFont(size: 16)
    }

    let statusLabel = UILabel().then{
        $0.text = "已完成"
        $0.textColor = .king
        $0.font = MYFont(size: 14)
    }
    
    let line = UIView().then{
        $0.backgroundColor = .borad
    }
    

    let goodImage = UIImageView().then{
        $0.image = UIImage(named: "test")
    }
    
    let goodName = UILabel().then{
        $0.text = "行善有味会员(月卡)"
        $0.textColor = .text
        $0.font = MYFont(size: 14)
    }
    
    let price = UILabel()
    
    let num = UILabel().then{
        $0.text  = "x1"
        $0.textColor  = .twoText
        $0.font = MYFont(size: 15)
    }
    
    let orderTime = UILabel().then{
        $0.text = "下单时间:2021-09-01 10:23:44"
        $0.textColor = .twoText
        $0.font = MYFont(size: 12)
    }
    
    let preLabel = UILabel().then{
        $0.text = "实际支付￥5"
        $0.textColor = UIColor.qmui_color(withHexString: "#E61016")
        $0.font = MYFont(size: 12)
    }
        
    let selectView = CLMyOrderStatusSelectView()

    override func configUI() {
        contentView.backgroundColor = .lightBackground
        contentView.addSubview(baseView)
        baseView.addSubviews(views: [label,shopName,statusLabel,line,goodImage,goodName,price,num,orderTime,preLabel,selectView])
        let str = "￥28.5"
        price.attributedText = str.setAttributed(font: MYBlodFont(size: 12), textColor: UIColor.qmui_color(withHexString: "#E61016")!, lineSpaceing: 0, wordSpaceing: 0, rangeFont: MYBlodFont(size: 16), range: NSMakeRange(1, str.count - 1))
                
        baseView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
        }
        
        label.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(12)
            make.width.equalTo(30)
            make.height.equalTo(15)
        }
        
        shopName.snp.makeConstraints { make in
            make.left.equalTo(label.snp.right).offset(5)
            make.centerY.equalTo(label.snp.centerY)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.centerY.equalTo(shopName.snp.centerY)
        }
        
        line.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(label.snp.bottom).offset(10)
            make.height.equalTo(1)
        }
        
        goodImage.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalTo(line.snp.bottom).offset(10)
            make.width.equalTo(80)
            make.height.equalTo(60)
        }
        
        goodName.snp.makeConstraints { make in
            make.left.equalTo(goodImage.snp.right).offset(10)
            make.top.equalTo(goodImage.snp.top)
        }
        
        price.snp.makeConstraints { make in
            make.left.equalTo(goodImage.snp.right).offset(10)
            make.bottom.equalTo(goodImage.snp.bottom)
        }

        num.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.centerY.equalTo(price.snp.centerY)
        }
        
        orderTime.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalTo(goodImage.snp.bottom).offset(10)
        }
        
        
        preLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.centerY.equalTo(orderTime.snp.centerY)
        }
        
        
        selectView.snp.makeConstraints { make in
            make.top.equalTo(orderTime.snp.bottom).offset(13)
            make.right.equalToSuperview().offset(-10)
            make.left.equalToSuperview().offset(10)
            make.height.equalTo(32)
        }
        
        
    }
}
