//
//  XSVipTicketCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/8/30.
//

import UIKit
import QMUIKit

class XSVipTicketView:UIView{
    var tipLab : UILabel={
        let lab = UILabel()
        lab.font = MYBlodFont(size: 35)
        lab.textColor = .white
        lab.text = "¥5"
        return lab
    }()
    var subLab : UILabel={
        let lab = UILabel()
        lab.font = MYFont(size: 12)
        lab.textColor = .white
        lab.text = "满100元使用"
        return lab
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(tipLab)
        tipLab.snp_makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(20)
        }
        self.addSubview(subLab)
        subLab.snp_makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(tipLab.snp_bottom)
        }

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
class XSVipTicketRule:UIView{
    var lineView : XSDashLine = {
        let view = XSDashLine()
        view.lineView.jk.drawDashLine(strokeColor: UIColor.fourText, lineLength: 4, lineSpacing: 4, direction: .horizontal)
        return view
    }()

    var tipLab : UILabel={
        let lab = UILabel()
        lab.font = MYFont(size: 12)
        lab.textColor = .twoText
        lab.text = "1、周一到周五10:00-22:00可用。\n2、仅XXX 商品可用。"
        lab.numberOfLines = 0
        lab.jk.changeLineSpace(space: 8)
        return lab
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(lineView)
        lineView.snp_makeConstraints { make in
            make.top.left.equalTo(10)
            make.right.equalTo(-10)
            make.height.equalTo(1)
        }
        self.addSubview(tipLab)
        tipLab.snp_makeConstraints { make in
            make.left.equalTo(10)
            make.top.equalTo(lineView.snp_bottom).offset(6)
            make.bottom.right.equalTo(-10)
        }

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
class XSDashLine:UIView{
    var lineView : UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 2))
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(lineView)
        self.clipsToBounds = true
        lineView.snp_makeConstraints { make in
            make.center.equalToSuperview()
            make.left.equalTo(0)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class XSVipTicketCell: XSBaseTableViewCell {
    typealias XSVipTicketExpandBlock = () ->Void
    var expandBlock:XSVipTicketExpandBlock?
    var useBtnClickHandler: ((_ dataModel: FreeCouponList) -> Void)?
    
    
    var model:CLMyCouponModel?{
        didSet {
            guard let model = model else { return }
            /// 使用门槛（0无门槛1满减2月卡可用3季卡可用4年卡可用）
            if model.useCondition != 1 {
                ticketView.subLab.text = "无门槛"
            } else if(model.useCondition == 1) {
                ticketView.subLab.text = "满\(model.fullReductionAmount)元可用"
            }
            ticketView.tipLab.text = "￥\(model.discountAmount)"
            ticketView.tipLab.jk.setsetSpecificTextFont("¥", font: MYBlodFont(size: 16))

            
            tipLab.text = model.couponName
            subLab.text = "有效期至\(model.endDate)"
            
            ruleView.tipLab.text = model.useExplain
//            useBtn.setTitle(model.btnTitle, for: .normal)
            
            
            maskImg.isHidden = true
            
//            //展开折叠
//            if model.ruleExpand {
//                lineView.isHidden = true
//                ruleView.isHidden = false
//                backView.backgroundColor = .white
//                ruleView.snp_remakeConstraints { make in
//                    make.left.right.bottom.equalTo(0)
//                    make.top.equalTo(ticketView.snp_bottom)
//                }
//            }
//            else{
//                lineView.isHidden = false
//                ruleView.isHidden = true
//                backView.backgroundColor = .clear
//                ruleView.snp_remakeConstraints { make in
//                    make.left.right.bottom.equalTo(0)
//                    make.top.equalTo(ticketView.snp_bottom)
//                    make.height.equalTo(0)
//                }
//            }
        }
    }
    
    var dataModel: FreeCouponList? {
        didSet {
            guard let model = dataModel else {
                return
            }
            
            /// 使用门槛（0无门槛1满减2月卡可用3季卡可用4年卡可用）
            if model.useCondition != 1 {
                ticketView.subLab.text = "无门槛"
            } else if(model.useCondition == 1) {
                ticketView.subLab.text = "满\(model.fullReductionAmount)元可用"
            }
            ticketView.tipLab.text = "￥\(model.discountAmount)"
            ticketView.tipLab.jk.setsetSpecificTextFont("¥", font: MYBlodFont(size: 16))

            
            tipLab.text = model.couponName
            subLab.text = "有效期至\(model.endDate)"
            
            ruleView.tipLab.text = model.useExplain
            useBtn.setTitle(model.btnTitle, for: .normal)
            
            
            maskImg.isHidden = true
            
            //展开折叠
            if model.ruleExpand {
                lineView.isHidden = true
                ruleView.isHidden = false
                backView.backgroundColor = .white
                ruleView.snp_remakeConstraints { make in
                    make.left.right.bottom.equalTo(0)
                    make.top.equalTo(ticketView.snp_bottom)
                }
            }
            else{
                lineView.isHidden = false
                ruleView.isHidden = true
                backView.backgroundColor = .clear
                ruleView.snp_remakeConstraints { make in
                    make.left.right.bottom.equalTo(0)
                    make.top.equalTo(ticketView.snp_bottom)
                    make.height.equalTo(0)
                }
            }
            
        }
    }
    
    var backView = UIView()
    var backImg : UIImageView={
        let img = UIImageView()
        img.image = UIImage(named:"vip_ticket_coupon")
        return img
    }()
    
    var ticketView = XSVipTicketView()
    
    var tipLab : UILabel={
        let lab = UILabel()
        lab.font = MYBlodFont(size: 15)
        lab.textColor = .text
        lab.text = "行膳有味月卡会员 "
        return lab
    }()
    var subLab : UILabel={
        let lab = UILabel()
        lab.font = MYFont(size: 12)
        lab.textColor = .twoText
        lab.text = "购买后30天有效"
        return lab
    }()
    var lineView : XSDashLine = {
        let view = XSDashLine()
        view.lineView.jk.drawDashLine(strokeColor: UIColor.fourText, lineLength: 4, lineSpacing: 4, direction: .horizontal)
        return view
    }()


    var ruleBtn : QMUIButton={
        let btn = QMUIButton()
        btn.setTitle("使用规则", for: UIControl.State.normal)
        btn.setTitleColor(.twoText, for: UIControl.State.normal)
        btn.titleLabel?.font = MYFont(size: 12)
        btn.imagePosition = .right
        btn.setImage(UIImage(named: "vip_arrow_Check_down"), for: UIControl.State.normal)
        btn.setImage(UIImage(named: "vip_arrow_Check_up"), for: UIControl.State.selected)
        return btn
    }()

    var useBtn : QMUIButton={
        let btn = QMUIButton()
        btn.setTitle("立即使用", for: UIControl.State.normal)
        btn.setTitleColor(.tag, for: UIControl.State.normal)
        btn.titleLabel?.font = MYFont(size: 12)
        btn.hg_setAllCornerWithCornerRadius(radius: 12)
        btn.addTarget(self, action: #selector(useBtnClick), for: .touchUpInside)
        return btn
    }()
    
    var ruleView = XSVipTicketRule()
    
    var maskImg : UIImageView={
        let img = UIImageView()
        img.image = UIImage(named:"vip_ticket_coupon2")
        return img
    }()
    
    
    var maskIconImg : UIImageView={
        let img = UIImageView()
        img.image = UIImage(named:"vip_ticket_timeout")
        return img
    }()

    override func configUI() {
        contentView.backgroundColor = .background
        contentView.addSubview(backView)

        backView.hg_setAllCornerWithCornerRadius(radius: 8)
        backView.snp_makeConstraints { make in
            make.left.top.equalTo(10)
            make.right.equalTo(-10)
            make.bottom.equalTo(0)
        }
        
        backView.addSubview(backImg)
        backImg.snp_makeConstraints { make in
            make.left.top.right.equalTo(0)
            make.height.equalTo(100)
        }

        backView.addSubview(ticketView)
        ticketView.snp_makeConstraints { make in
            make.left.top.equalTo(0)
            make.width.height.equalTo(100)
        }
        
        backView.addSubview(tipLab)
        tipLab.snp_makeConstraints { make in
            make.top.equalTo(12)
            make.left.equalTo(ticketView.snp_right).offset(16)
            
        }
        backView.addSubview(subLab)
        subLab.snp_makeConstraints { make in
            make.top.equalTo(tipLab.snp_bottom).offset(2)
            make.left.equalTo(tipLab.snp_left)
        }
        backView.addSubview(lineView)
        lineView.snp_makeConstraints { make in
            make.top.equalTo(subLab.snp_bottom).offset(10)
            make.left.equalTo(tipLab.snp_left)
            make.right.equalTo(-10)
            make.height.equalTo(1)
        }
        
        backView.addSubview(ruleBtn)
        ruleBtn.add(self, action: #selector(clickRuleExpand))

        ruleBtn.snp_makeConstraints { make in
            make.top.equalTo(lineView.snp_bottom).offset(15)
            make.left.equalTo(tipLab.snp_left)
        }

        backView.addSubview(useBtn)
        useBtn.jk.addBorder(borderWidth: 1, borderColor: .tag)
        useBtn.snp_makeConstraints { make in
            make.centerY.equalTo(ruleBtn.snp_centerY)
            make.right.equalTo(-10)
            make.width.equalTo(72)
            make.height.equalTo(24)
        }
        
        backView.addSubview(ruleView)
        ruleView.snp_makeConstraints { make in
            make.left.right.bottom.equalTo(0)
            make.top.equalTo(ticketView.snp_bottom)
        }
        
        backView.addSubview(maskImg)
        maskImg.snp_makeConstraints { make in
            make.edges.equalTo(0)
        }
        
        maskImg.addSubview(maskIconImg)
        maskIconImg.snp_makeConstraints { make in
            make.right.equalTo(-10)
            make.width.height.equalTo(60)
            make.centerY.equalToSuperview()
        }

    }
    
    public func configMerchInfoPopTicket() {
        contentView.backgroundColor = .lightBackground
        backView.backgroundColor = contentView.backgroundColor

        ruleBtn.setImage(nil, for: .normal)
        ruleBtn.isUserInteractionEnabled = false
        ruleBtn.setTitle("到店订单有效", for: .normal)
        
        lineView.isHidden = true
    }

    @objc func clickRuleExpand() {
        expandBlock?()
    }
    
    @objc func useBtnClick() {
        useBtnClickHandler?(dataModel ?? FreeCouponList())
    }

}
