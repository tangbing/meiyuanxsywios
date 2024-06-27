//
//  CLMyOrderGroupBuyCell.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/11/26.
//

import UIKit
import Kingfisher

class CLMyOrderGroupBuyCell: XSBaseTableViewCell {
    
    var type:CLMyOrderShopType = .groupBuy(status: .waitPay, title: ""){
        didSet {
            switch type {
            case .deliver:
                return
            case .groupBuy(let status,let title):
                selectView.statusType = type
                statusLabel.text = title
            case .privateKitchen:
                return
            case .member:
                return
            case .allType:
                return
            }
        }
    }
    
    var model:CLMyOrderListModel? {
        didSet{
            guard let cellModel = model else { return }
            shopName.text = cellModel.merchantName
            goodName.text = cellModel.orderGoodsDetailVOList[0].goodsName
            goodImage.xs_setImage(urlString:cellModel.orderGoodsDetailVOList[0].topPic)
            orgrinPrice.text = "￥\(cellModel.orderGoodsDetailVOList[0].originalPrice)"
            orderTime.text = "下单时间:\(cellModel.orderTime)"
            let str1 = "￥\(cellModel.orderGoodsDetailVOList[0].salePrice)"
            price.attributedText = str1.setAttributed(font: MYBlodFont(size: 12), textColor: UIColor.qmui_color(withHexString: "#E61016")!, lineSpaceing: 0, wordSpaceing: 0, rangeFont: MYBlodFont(size: 16), range: NSMakeRange(1, str1.count - 1))
            num.text = "x\(cellModel.orderGoodsDetailVOList[0].account)"
            
            let str = "￥\(cellModel.payAmt)"
            moneyLabel.attributedText = str.setAttributed(font: MYBlodFont(size: 12), textColor: .text, lineSpaceing: 0, wordSpaceing: 0, rangeFont: MYBlodFont(size: 16), range: NSMakeRange(1, str.count - 1))
            
            discountLabel.text = cellModel.orderGoodsDetailVOList[0].discount
        }
    }
    var countDownZero:(()->())?

    var source:String? {
        didSet{
            guard let _ = source else { return }
                    
            statusLabel.text = String(format: "待支付,剩余%d分%d秒",(180/60)%60, 180%60)
            self.countDownNotification()
        }
    }
    @objc private func countDownNotification() {
        
        // 判断是否需要倒计时 -- 可能有的cell不需要倒计时,根据真实需求来进行判断
        guard let str = source else { return }

        // 计算倒计时
        let timeInterval: Int
        timeInterval = CLCountDownManager.sharedManager.timeIntervalWithIdentifier(identifier:str)
        let countDown = 180 - timeInterval
        // 当倒计时到了进行回调
        if (countDown <= 0) {
            self.statusLabel.text = "活动开始"
            guard let action = countDownZero else { return }
            action()
            // 回调给控制器
        }else{
            // 重新赋值
            self.statusLabel.text = String(format: "待支付,剩余%d分%d秒",(countDown/60)%60, countDown%60)
        }

    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    let baseView = UIView().then{
        $0.layer.cornerRadius = 10
        $0.backgroundColor = .white
    }
    
    let label = UILabel().then{
        $0.backgroundColor = UIColor.qmui_color(withHexString: "#F11F16")
        $0.layer.cornerRadius = 2
        $0.clipsToBounds = true
        $0.text = "到店"
        $0.textColor = .white
        $0.font = MYFont(size: 9)
        $0.textAlignment = .center
    }
    
    let shopName = UILabel().then{
        $0.text = "商家名称"
        $0.textColor = .text
        $0.font = MYBlodFont(size: 16)
    }

    let statusLabel = UILabel().then{
        $0.text = "待支付"
        $0.textColor = .king
        $0.font = MYFont(size: 14)
    }
    
    let line = UIView().then{
        $0.backgroundColor = .borad
    }
    

    let goodImage = UIImageView().then{
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 4
    }
    
    let goodName = UILabel().then{
        $0.text = "菜品名称"
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
        $0.text = "合计"
        $0.textColor = .twoText
        $0.font = MYFont(size: 12)
    }
    
    let moneyLabel = UILabel()
    
    let orgrinPrice = UILabel().then{
        $0.text = "￥110"
        $0.textColor = .twoText
        $0.font = MYFont(size: 12)
    }
    
    let orgrinPriceLine = UIView().then{
        $0.backgroundColor = .twoText
    }
    
    let discountLabel = UILabel().then{
        $0.text = "3.3折"
        $0.textColor = UIColor.qmui_color(withHexString: "#F11F16")
        $0.font = MYFont(size: 12)
        $0.layer.borderWidth = 0.5
        $0.layer.borderColor = UIColor.qmui_color(withHexString: "#F11F16")?.cgColor
        $0.textAlignment = .center
        $0.layer.cornerRadius = 2
    }
    
    let selectView = CLMyOrderStatusSelectView()

    override func configUI() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.countDownNotification), name: .CLCountDownNotification, object: nil)
        
        contentView.backgroundColor = .lightBackground
        contentView.addSubview(baseView)
        baseView.addSubviews(views: [label,shopName,statusLabel,line,goodImage,goodName,price,num,orderTime,preLabel,moneyLabel,selectView,orgrinPrice,orgrinPriceLine,discountLabel])
        
        let str = "￥519"
        moneyLabel.attributedText = str.setAttributed(font: MYBlodFont(size: 12), textColor: .text, lineSpaceing: 0, wordSpaceing: 0, rangeFont: MYBlodFont(size: 16), range: NSMakeRange(1, str.count - 1))

        
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
        
        orgrinPrice.snp.makeConstraints { make in
            make.left.equalTo(price.snp.right).offset(2)
            make.centerY.equalTo(price.snp.centerY)
        }
        
        orgrinPriceLine.snp.makeConstraints { make in
            make.left.equalTo(orgrinPrice.snp.left)
            make.right.equalTo(orgrinPrice.snp.right)
            make.centerY.equalTo(orgrinPrice.snp.centerY)
            make.height.equalTo(0.5)
        }
        
        discountLabel.snp.makeConstraints { make in
            make.left.equalTo(orgrinPrice.snp.right).offset(8)
            make.centerY.equalTo(orgrinPrice.snp.centerY)
            make.width.equalTo(35)
            make.height.equalTo(13)
        }

        num.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.centerY.equalTo(price.snp.centerY)
        }
        
        orderTime.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalTo(goodImage.snp.bottom).offset(12.5)
        }
        
        moneyLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.centerY.equalTo(orderTime.snp.centerY)
        }
        
        preLabel.snp.makeConstraints { make in
            make.right.equalTo(moneyLabel.snp.left).offset(-10)
            make.centerY.equalTo(moneyLabel.snp.centerY)
        }
        
        selectView.snp.makeConstraints { make in
            make.top.equalTo(orderTime.snp.bottom).offset(13)
            make.right.equalToSuperview().offset(-10)
            make.left.equalToSuperview().offset(10)
            make.height.equalTo(32)
        }

        
    }
}
