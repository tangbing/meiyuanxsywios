//
//  XSGoodsInfoKillSecondTableViewCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/12/9.
//

import UIKit

class XSGoodsInfoKillSecondTableViewCell: XSBaseTableViewCell {

    lazy var container: UIView = {
        let container = UIView()
        let colors = [UIColor.hex(hexString: "#A46EFF"),UIColor.hex(hexString: "#FA9CFF")]
        container.hg_addGradientColor(colors, size: CGSize(width: screenWidth, height: 60), startPoint: CGPoint(x: 1, y: 1), endPoint: CGPoint(x: 0.04, y: 0.04))
        return container
    }()
    
    lazy var killSecondIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "goodsInfo_panic_buying")
        return icon
    }()
    
    lazy var priceView: XSCollectPriceView = {
        let price = XSCollectPriceView()
        price.configGoodsInfoKillSecond(color: UIColor.hex(hexString: "#A46EFF"))
        return price
    }()
    
    lazy var killSecondTimerLabel: UILabel = {
        let timer = UILabel()
        timer.text = "距结束00:20:21"
        timer.textColor = .white
        timer.font = MYFont(size: 12)
        return timer
    }()
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func configUI() {
        super.configUI()
        
        self.contentView.addSubview(container)
        container.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        container.addSubview(killSecondIcon)
        killSecondIcon.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.size.equalTo(CGSize(width: 100, height: 32))
            make.top.equalToSuperview().offset(5)
        }
        
        container.addSubview(killSecondTimerLabel)
        killSecondTimerLabel.snp.makeConstraints { make in
            make.top.equalTo(killSecondIcon.snp_bottom).offset(5)
            make.right.equalTo(killSecondIcon)
        }
        
        container.addSubview(priceView)
        priceView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.bottom.equalToSuperview()
            make.right.equalTo(killSecondIcon.snp_left).offset(-10)
        }
        
        
        
    }

}
