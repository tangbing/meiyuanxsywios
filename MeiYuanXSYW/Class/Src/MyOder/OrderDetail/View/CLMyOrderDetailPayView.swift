//
//  CLMyOrderDetailPayView.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/11/25.
//

import UIKit

class CLMyOrderDetailPayView: TBBaseView {
    
    var submitClock:(()->())?
    
    let payTotalLabel = UILabel().then{
        $0.text = "合计:"
        $0.textColor = .twoText
        $0.font = MYFont(size: 12)
    }

    let payTotal = UILabel().then{
        $0.textColor = UIColor.qmui_color(withHexString: "#252525")!
        $0.font  = MYBlodFont(size: 18)
        $0.text = "￥1314.8"
    }
    
    let totalDiscountLabel = UILabel().then{
        $0.text = "总优惠:"
        $0.textColor = .twoText
        $0.font = MYFont(size: 12)
    }
    
    let totalDiscount = UILabel().then{
        $0.textColor = UIColor.qmui_color(withHexString: "#E61016")!
        $0.font  = MYBlodFont(size: 18)
        $0.text = "￥29.8"
    }
    
    
    let payButton = UIButton().then{
        $0.setTitle("继续支付", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.hg_setAllCornerWithCornerRadius(radius: 22)
        $0.setBackgroundImage(UIImage(named: "cartBackImg"), for: .normal)
        $0.addTarget(self, action: #selector(submit), for: .touchUpInside)
    }
    @objc func submit(){
        guard let action = submitClock else {return}
        action()
    }

    override func configUI() {
        self.addSubviews(views: [payTotalLabel,payTotal,totalDiscountLabel,totalDiscount,payButton])
        
        payTotalLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(15)
        }
        payTotal.snp.makeConstraints { make in
            make.left.equalTo(payTotalLabel.snp.right).offset(4)
            make.centerY.equalTo(payTotalLabel.snp.centerY)
        }
        totalDiscountLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-15)
        }
        totalDiscount.snp.makeConstraints { make in
            make.left.equalTo(totalDiscountLabel.snp.right).offset(4)
            make.centerY.equalTo(totalDiscountLabel.snp.centerY)
        }
        
        payButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
            make.width.equalTo(111)
            make.height.equalTo(44)
        }
    
    }
}
