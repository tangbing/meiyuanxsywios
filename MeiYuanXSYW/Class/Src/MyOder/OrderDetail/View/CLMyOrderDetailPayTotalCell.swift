//
//  CLMyOrderDetailPayTotalCell.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/11/25.
//

import UIKit

class CLMyOrderDetailPayTotalCell: XSBaseTableViewCell {
    
    let totalDiscountLabel = UILabel().then{
        $0.text = "合计优惠:"
        $0.textColor = .text
        $0.font = MYFont(size: 14)
    }
    
    let totalDiscount = UILabel().then{
        $0.text = "-$28.5"
        $0.textColor = UIColor.qmui_color(withHexString: "#E61016")!
        $0.font = MYFont(size: 16)
    }
    
    let payTotalLabel = UILabel().then{
        $0.text = "实际支付"
        $0.textColor = .text
        $0.font = MYFont(size: 14)
    }

    let payTotal = UILabel().then{
        $0.text = "$5896.6"
        $0.textColor = .text
        $0.font = MYBlodFont(size: 16)
    }
    
    override func configUI() {
        self.contentView.addSubviews(views: [totalDiscountLabel,totalDiscount,payTotalLabel,payTotal])
        
        let str = "￥5896.6"
        payTotal.attributedText = str.setAttributed(font: MYBlodFont(size: 12), textColor: .text, lineSpaceing: 0, wordSpaceing: -1, rangeFont: MYBlodFont(size: 16), range: NSMakeRange(1,str.count - 1))
        
        let str1 = "-￥28.5"
        totalDiscount.attributedText = str1.setAttributed(font: MYFont(size: 12), textColor: UIColor.qmui_color(withHexString: "#E61016")!, lineSpaceing: 0, wordSpaceing: -1, rangeFont: MYFont(size: 16), range: NSMakeRange(2,str1.count - 2))
        
        totalDiscount.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(15)
        }
        
        totalDiscountLabel.snp.makeConstraints { make in
            make.right.equalTo(totalDiscount.snp.left).offset(-4)
            make.centerY.equalTo(totalDiscount.snp.centerY)
        }
        
        payTotal.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(totalDiscount.snp.bottom).offset(10)
        }
        
        payTotalLabel.snp.makeConstraints { make in
            make.right.equalTo(payTotal.snp.left).offset(-4)
            make.centerY.equalTo(payTotal.snp.centerY)
        }
        
    }

}
