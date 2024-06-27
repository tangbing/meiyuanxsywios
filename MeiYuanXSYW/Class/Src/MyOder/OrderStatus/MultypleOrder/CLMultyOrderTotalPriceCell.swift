//
//  CLMultyOrderTotalPriceCell.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/17.
//

import UIKit

class CLMultyOrderTotalPriceCell: XSBaseTableViewCell {
    let baseView = UIView().then{
        $0.hg_setCornerOnBottomWithRadius(radius: 10)
        $0.backgroundColor = .white
    }
    
    let pre1 = UILabel().then{
        $0.text = "已优惠:"
        $0.textColor = .twoText
        $0.font = MYFont(size: 14)
    }
    
    let pre2 = UILabel().then{
        $0.text = "小计:"
        $0.textColor = .text
        $0.font = MYBlodFont(size: 14)
    }
    
    let discountPrice = UILabel()
    let totalPrice = UILabel()
    override func configUI() {
        super.configUI()
        
        self.contentView.backgroundColor = .lightBackground
        contentView.addSubview(baseView)
        baseView.addSubviews(views: [pre1,pre2,discountPrice,totalPrice])
        
        let str = "-￥28.5"
        discountPrice.attributedText = str.setAttributed(font: MYBlodFont(size: 12), textColor: UIColor.qmui_color(withHexString: "#E61016")!, lineSpaceing: 0, wordSpaceing: -1, rangeFont: MYBlodFont(size: 16), range: NSMakeRange(2, str.count - 2))
        
        let str1 = "￥258.5"
        totalPrice.attributedText = str1.setAttributed(font: MYBlodFont(size: 12), textColor: UIColor.qmui_color(withHexString: "#E61016")!, lineSpaceing: 0, wordSpaceing: -1, rangeFont: MYBlodFont(size: 16), range: NSMakeRange(1, str1.count - 1))
        
        
        baseView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.bottom.equalToSuperview()
        }
        
        pre1.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(15)
        }
        discountPrice.snp.makeConstraints { make in
            make.left.equalTo(pre1.snp.right)
            make.centerY.equalTo(pre1.snp.centerY)
        }
        totalPrice.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.centerY.equalTo(pre1.snp.centerY)
        }
        pre2.snp.makeConstraints { make in
            make.right.equalTo(totalPrice.snp.left)
            make.centerY.equalTo(pre1.snp.centerY)
        }
    }
}
