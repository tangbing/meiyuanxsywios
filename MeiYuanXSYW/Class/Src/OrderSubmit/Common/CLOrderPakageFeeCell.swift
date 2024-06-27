//
//  CLOrderPakageFeeCell.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/8.
//

import UIKit

class CLOrderPakageFeeCell: XSBaseTableViewCell {
    
    var height = 77
    
    let baseView = UIView().then{
        $0.backgroundColor = .white
    }
    
    let label = UILabel().then{
        $0.text = "打包费"
        $0.textColor = .text
        $0.font = MYFont(size: 14)
    }
    
    let fee = UILabel().then{
        $0.text = "￥2.0"
        $0.textColor = .twoText
        $0.font = MYFont(size: 16)
        $0.jk.setsetSpecificTextFont("￥", font:MYBlodFont(size: 12))

    }
    
    let deliverFeeLabel = UILabel().then{
        $0.text = "预计配送费"
        $0.textColor = .text
        $0.font = MYFont(size: 14)
    }
    
    let deliverFee = UILabel().then{
        $0.text = "￥0"
        $0.textColor = .twoText
        $0.font = MYFont(size: 16)
        $0.jk.setsetSpecificTextFont("￥", font:MYBlodFont(size: 12))

    }
    
    let orginDeliverFee = UILabel().then{
        $0.text = "￥0.0"
        $0.textColor = .fourText
        $0.font = MYFont(size: 16)
    }
    
    let crossLine = UIView().then{
        $0.backgroundColor = .fourText
    }

    override func configUI() {
        super.configUI()
        contentView.backgroundColor = .lightBackground
        
        contentView.addSubview(baseView)
        baseView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.bottom.equalToSuperview()
        }
        
        baseView.addSubviews(views: [label,fee,deliverFeeLabel,deliverFee,orginDeliverFee,crossLine])
        
        
//        let str = "￥2"
//        fee.attributedText = str.setAttributed(font: MYFont(size: 12), textColor: .twoText, lineSpaceing: 0, wordSpaceing: -1, rangeFont: MYFont(size: 16), range: NSMakeRange(1,str.count - 1))
//
//        let str1 = "￥0"
//        deliverFee.attributedText = str1.setAttributed(font: MYFont(size: 12), textColor: .twoText, lineSpaceing: 0, wordSpaceing: -1, rangeFont: MYFont(size: 16), range: NSMakeRange(1,str1.count - 1))
        
        label.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(20)
        }
        fee.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.centerY.equalTo(label.snp.centerY)
        }
        deliverFeeLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalTo(label.snp.bottom).offset(18)
        }
        deliverFee.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.centerY.equalTo(deliverFeeLabel.snp.centerY)
        }
        orginDeliverFee.snp.makeConstraints { make in
            make.right.equalTo(deliverFee.snp.left).offset(-2)
            make.centerY.equalTo(deliverFeeLabel.snp.centerY)
        }
        
        crossLine.snp.makeConstraints { make in
            make.left.equalTo(orginDeliverFee.snp.left)
            make.right.equalTo(orginDeliverFee.snp.right)
            make.centerY.equalTo(orginDeliverFee.snp.centerY)
            make.height.equalTo(0.5)
        }
        
    }
}
