//
//  CLPayStatusCell.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/13.
//

import UIKit

class CLPayStatusCell: XSBaseTableViewCell {
    
    let statusBaseView = UIView().then{
        $0.layer.cornerRadius = 10
        $0.backgroundColor = .white
    }
    
    let statusImage = UIImageView().then{
        $0.image = UIImage(named: "we-icon-success-fill")
    }
    
    let statusLabel = UILabel().then{
        $0.text = "订单支付成功"
        $0.textColor = .text
        $0.font = MYBlodFont(size: 18)
    }
    
    let orderLabel = UILabel().then{
        $0.text = "订单号:ORH000120029102389429942"
        $0.textColor = .twoText
        $0.font = MYFont(size: 14)
    }
    
    let payMoneyLabel = UILabel().then{
        $0.text = "支付金额:￥8762837.00"
        $0.textColor = .twoText
        $0.font = MYFont(size: 14)
    }

    let redLuckyMoney = UIImageView().then{
        $0.image = UIImage(named: "mine_banner")

    }
    
    let baseView = UIView().then{
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10
    }
    
    let boardBaseView = UIView().then{
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 2
        $0.addShadow(shadowColor: UIColor.borad, shadowOffset: CGSize(width: 0, height: 1.5), shadowOpacity: 1,shadowRadius:1.5)

    }
    
    let codeImage = UIImageView().then{
        $0.image = UIImage(named: "")
    }
    
    var descriptionString = """
添加平台小助手
1.每日抢红包，享免单机会
2.每次优惠菜品推荐
"""
    
    let des = UILabel().then{
        $0.numberOfLines = 0
    }
    
    let orderDetailButton = UIButton().then{
        $0.setTitle("查看订单详情", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = MYFont(size: 16)
        $0.setBackgroundImage(UIImage(named: "btnBackImg"), for: .normal)
        $0.layer.cornerRadius = 22
        $0.clipsToBounds = true
        $0.isHidden = true
    }
    
    let backToHome = UIButton().then{
        $0.setTitle("返回首页", for: .normal)
        $0.setTitleColor(.king, for: .normal)
        $0.titleLabel?.font = MYFont(size: 16)
        $0.layer.cornerRadius = 22
        $0.layer.borderColor = UIColor.king.cgColor
        $0.layer.borderWidth = 0.5
    }
    
    let orderDetail = UIButton().then{
        $0.setTitle("查看订单详情", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = MYFont(size: 16)
        $0.setBackgroundImage(UIImage(named: "btnBackImg"), for: .normal)
        $0.layer.cornerRadius = 22
        $0.clipsToBounds = true
    }
    
    override func configUI() {
        super.configUI()
        contentView.backgroundColor = .lightBackground
        
        self.contentView.addSubview(statusBaseView)
        self.contentView.addSubview(redLuckyMoney)
        self.contentView.addSubview(baseView)
        self.contentView.addSubview(orderDetailButton)
        self.contentView.addSubview(backToHome)
        self.contentView.addSubview(orderDetail)


        baseView.addSubview(boardBaseView)
        boardBaseView.addSubviews(views: [codeImage,des])

        statusBaseView.addSubviews(views: [statusImage,statusLabel,orderLabel,payMoneyLabel])
        
        des.attributedText =         descriptionString.attributedString(font: MYFont(size: 14), textColor: .twoText, lineSpaceing:8.5, wordSpaceing: 0)
        
        codeImage.image = UIImage.generateQRCode("这是一个二维码链接",120,nil,.text)
        
        statusBaseView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(10)
            make.height.equalTo(200)
        }
        
        statusImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(60)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.top.equalTo(statusImage.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        
        orderLabel.snp.makeConstraints { make in
            make.top.equalTo(statusLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        payMoneyLabel.snp.makeConstraints { make in
            make.top.equalTo(orderLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        redLuckyMoney.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(statusBaseView.snp.bottom).offset(10)
            make.height.equalTo(84)
        }
        
        baseView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(redLuckyMoney.snp.bottom).offset(10)
            make.height.equalTo(180)
        }
        
        boardBaseView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-15)
        }
        
        codeImage.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(120)
        }
        
        des.snp.makeConstraints { make in
            make.left.equalTo(codeImage.snp.right).offset(10)
            make.right.equalToSuperview().offset(28)
            make.top.equalToSuperview().offset(40)
        }
        
        orderDetailButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(44)
            make.top.equalTo(baseView.snp.bottom).offset(30)
        }
        
        backToHome.snp.makeConstraints { make in
            make.top.equalTo(baseView.snp.bottom).offset(30)
            make.height.equalTo(44)
            make.left.equalToSuperview().offset(15)
            make.width.equalTo((screenWidth - 45)/2)
        }
        orderDetail.snp.makeConstraints { make in
            make.top.equalTo(baseView.snp.bottom).offset(30)
            make.height.equalTo(44)
            make.right.equalToSuperview().offset(-15)
            make.width.equalTo((screenWidth - 45)/2)
        }
    }
}
