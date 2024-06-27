//
//  XSVipBuyFooterView.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/8/25.
//

import UIKit

class XSVipBuyFooterView: UIView {
    
    
    var money:String = ""{
        didSet{
            btipLab.text = "应付金额:￥" + money
            btipLab.jk.setSpecificTextColor("应付金额：", color: .twoText)
            btipLab.jk.setsetSpecificTextFont("¥", font: MYBlodFont(size: 12))
            btipLab.jk.setsetSpecificTextFont(money, font: MYBlodFont(size: 18))
            
            bsubLab.text = "优惠：¥0"
            bsubLab.jk.setSpecificTextColor("优惠：", color: .twoText)
            bsubLab.jk.setsetSpecificTextFont("¥", font: MYBlodFont(size: 12))
            bsubLab.jk.setsetSpecificTextFont("0", font: MYBlodFont(size: 18))
        }
    }
    
    var model:[String:String] = [:]{
        didSet{
            btipLab.text = "应付金额:￥\(model["price"]!)"
            btipLab.jk.setSpecificTextColor("应付金额：", color: .twoText)
            btipLab.jk.setsetSpecificTextFont("¥", font: MYBlodFont(size: 12))
            btipLab.jk.setsetSpecificTextFont(model["price"]!, font: MYBlodFont(size: 18))
            
            let discountAmt = Int(model["sprice"]!)! - Int(model["price"]!)!
            
            bsubLab.text = "优惠：¥\(discountAmt)"
            bsubLab.jk.setSpecificTextColor("优惠：", color: .twoText)
            bsubLab.jk.setsetSpecificTextFont("¥", font: MYBlodFont(size: 12))
            bsubLab.jk.setsetSpecificTextFont("\(discountAmt)", font: MYBlodFont(size: 18))
            
        }
    }
    
    var tipLab : UILabel={
        let lab = UILabel()
        lab.font = MYFont(size: 14)
        lab.textColor = .text
        lab.text = "确定支付则表示您同意《用户协议》"
        lab.jk.setSpecificTextColor("《用户协议》", color: .tag)
        return lab
    }()
    
    var btipLab : UILabel={
        let lab = UILabel()
        lab.font = MYFont(size: 12)
        lab.textColor = .text
        lab.text = "应付金额：¥15"
        lab.jk.setSpecificTextColor("应付金额：", color: .twoText)
        lab.jk.setsetSpecificTextFont("¥", font: MYBlodFont(size: 12))
        lab.jk.setsetSpecificTextFont("15", font: MYBlodFont(size: 18))

        return lab
    }()
    var bsubLab : UILabel={
        let lab = UILabel()
        lab.font = MYFont(size: 12)
        lab.textColor = .red
        lab.text = "优惠：¥15"
        lab.jk.setSpecificTextColor("优惠：", color: .twoText)
        lab.jk.setsetSpecificTextFont("¥", font: MYBlodFont(size: 12))
        lab.jk.setsetSpecificTextFont("15", font: MYBlodFont(size: 18))
        return lab
    }()

    var bottomView : UIView={
        let view = UIView()
        var payBtn : UIButton={
            let btn = UIButton()
            btn.setBackgroundImage(UIImage(named: "cartBackImg"), for: UIControl.State.normal)
            btn.setTitle("立即支付", for: UIControl.State.normal)
            btn.titleLabel?.font = MYBlodFont(size: 18)
            btn.setTitleColor(.white, for: UIControl.State.normal)
            btn.hg_setAllCornerWithCornerRadius(radius: 22)
            return btn
        }()
        view.addSubview(payBtn)
        payBtn.snp_makeConstraints { make in
            make.right.equalTo(-10)
            make.width.equalTo(111)
            make.height.equalTo(44)
            make.centerY.equalToSuperview()
        }
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        self.backgroundColor = .clear
        self.addSubview(tipLab)
        tipLab.snp_makeConstraints { make in
            make.left.equalTo(15)
            make.top.equalTo(12)
        }
        bottomView.backgroundColor = .white
        bottomView.addSubview(btipLab)
        btipLab.snp_makeConstraints { make in
            make.left.equalTo(15)
            make.top.equalTo(6)
        }
        bottomView.addSubview(bsubLab)
        bsubLab.snp_makeConstraints { make in
            make.left.equalTo(btipLab.snp_left)
            make.top.equalTo(btipLab.snp_bottom).offset(5)
        }
        self.addSubview(bottomView)
    
        bottomView.snp_makeConstraints { make in
            make.top.equalTo(tipLab.snp_bottom).offset(12)
            make.left.right.equalTo(0)
            make.bottom.equalTo(0)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
