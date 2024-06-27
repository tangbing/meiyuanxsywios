//
//  qqq.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/24.
//

import UIKit


class XSCollectPriceView: UIView {
    lazy var finalPriceLabel: UILabel = {
        let ib = UILabel()
        ib.textColor = UIColor.hex(hexString: "#E61016")
        ib.font = MYBlodFont(size: 12)
        ib.text = "¥28.5"
        return ib
    }()
    
    lazy var previousPriceLabel: UILabel = {
        let ib = UILabel()
        ib.textColor = UIColor.hex(hexString: "#B3B3B3")
        ib.font = MYFont(size: 11)
        ib.text = "¥110"
        ib.jk.setSpecificTextDeleteLine("¥110", color: ib.textColor)
        return ib
    }()
    
    lazy var reduceDownPriceLabel : UILabel = {
        let ib = UILabel()
        ib.textColor = UIColor.hex(hexString: "#F11F16")
        ib.font = MYFont(size: 11)
        ib.text = "3.3折"
        ib.textAlignment = .center
        ib.hg_setAllCornerWithCornerRadius(radius: 4)
        ib.jk.addBorder(borderWidth: 1, borderColor: .red)
        return ib
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.addSubview(finalPriceLabel)
        finalPriceLabel.snp.makeConstraints { make in
            make.left.centerY.equalToSuperview()
        }
        
        self.addSubview(previousPriceLabel)
        previousPriceLabel.snp.makeConstraints { make in
            make.bottom.equalTo(finalPriceLabel)
            make.left.equalTo(finalPriceLabel.snp_right).offset(6)
        }
        
        self.addSubview(reduceDownPriceLabel)
        reduceDownPriceLabel.snp.makeConstraints { make in
            make.bottom.equalTo(finalPriceLabel)
            make.size.equalTo(CGSize(width: 35, height: 13))
            make.left.equalTo(previousPriceLabel.snp_right).offset(6)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configGoodsInfoKillSecond(color killSecondColor: UIColor) {
//        finalPriceLabel.font = MYBlodFont(size: 18)
//        finalPriceLabel.textColor = killSecondColor
        
        previousPriceLabel.textColor = UIColor.hex(hexString: "#979797")
        previousPriceLabel.font = MYFont(size: 14)
        
        reduceDownPriceLabel.backgroundColor = .white
        reduceDownPriceLabel.hg_setAllCornerWithCornerRadius(radius: 2)
        reduceDownPriceLabel.textColor = killSecondColor
        reduceDownPriceLabel.jk.addBorder(borderWidth: 1, borderColor: killSecondColor)

    }
    
}

