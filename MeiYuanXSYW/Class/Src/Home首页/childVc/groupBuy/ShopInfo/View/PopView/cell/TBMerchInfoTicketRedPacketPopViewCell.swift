//
//  TB.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/3.
//

import UIKit
import QMUIKit
import JKSwiftExtension

class TBVipTicketView:UIView{
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

class TBVipTicketRule:UIView{
    var lineView : TBDashLine = {
        let view = TBDashLine()
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
class TBDashLine:UIView{
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

class TBMerchInfoTicketRedPacketPopViewCell: XSBaseTableViewCell {
    typealias XSVipTicketExpandBlock = () ->Void
    var expandBlock:XSVipTicketExpandBlock?
    var exchangeMerchantHandler: ((_ model: Any) -> Void)?
    
    
    var memberCardModels: MemberCardVoList? {
        didSet {
            guard let model = memberCardModels else {
                return
            }
            ticketView.subLab.text = "无门槛"
            
            ticketView.tipLab.text = "￥\(model.discountAmount) X \(model.giveNum)张"
            ticketView.tipLab.jk.setsetSpecificTextFont("¥", font: MYBlodFont(size: 16))

            
            tipLab.text = model.memberCardName
            subLab.text = "购买后\(model.validTime)天有效"
                        
            useBtn.setTitle("\(model.price)元抢", for: .normal)
                
        }
    }
    
    
    
    var myRedMemberPacketModels: FreeCouponList? {
        didSet {
            guard let model = myRedMemberPacketModels else {
                return
            }
            
            /// 使用门槛（0无门槛1满减2月卡可用3季卡可用4年卡可用）
            if model.useCondition != 1 {
                ticketView.subLab.text = "无门槛"
            } else if(model.useCondition == 1) {
                ticketView.subLab.text = "满\(model.fullReductionAmount)元可用"
            }
            ticketView.tipLab.text = "￥\(model.merchantAmount)"
            ticketView.tipLab.jk.setsetSpecificTextFont("¥", font: MYBlodFont(size: 16))

            
            tipLab.text = model.couponName
            subLab.text = "购买后\(model.validTime)天有效"
            
            ruleView.tipLab.text = model.useExplain
            
            configTicketState()

            //展开折叠
            if model.ruleExpand {
                ruleView.isHidden = false
                backView.backgroundColor = .white
                ruleView.snp_remakeConstraints { make in
                    make.left.right.bottom.equalTo(0)
                    make.top.equalTo(ticketView.snp_bottom)
                }
            }
            else{
                ruleView.isHidden = true
                backView.backgroundColor = .clear
                ruleView.snp_remakeConstraints { make in
                    make.left.right.bottom.equalTo(0)
                    make.top.equalTo(ticketView.snp_bottom)
                    make.height.equalTo(0)
                }
            }

            
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
    
    

    var backView = UIView()
    
    var backImg : UIImageView={
        let img = UIImageView()
        img.image = UIImage(named:"merchinfo_redpacket_bg")
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


    lazy var ruleBtn : QMUIButton={
        let btn = QMUIButton()
        btn.setTitle("使用规则", for: UIControl.State.normal)
        btn.setTitleColor(.twoText, for: UIControl.State.normal)
        btn.titleLabel?.font = MYFont(size: 12)
        btn.imagePosition = .right
        btn.setImage(UIImage(named: "vip_arrow_Check_down"), for: UIControl.State.normal)
        btn.setImage(UIImage(named: "vip_arrow_Check_up"), for: UIControl.State.selected)
        btn.add(self, action: #selector(clickRuleExpand))

        return btn
    }()

    lazy var useBtn : QMUIButton={
        let btn = QMUIButton()
        btn.setTitle("40元抢", for: UIControl.State.normal)
        btn.setTitleColor(.tag, for: UIControl.State.normal)
        btn.titleLabel?.font = MYFont(size: 12)
        btn.hg_setAllCornerWithCornerRadius(radius: 12)
        btn.addTarget(self, action: #selector(userBtnClick), for: .touchUpInside)
        return btn
    }()
    
    lazy var priviousPrice: UILabel = {
        let privious = UILabel()
        privious.text = "原价40"
        privious.textColor = .twoText
        privious.font = MYFont(size: 10)
        return privious
    }()
    
    lazy var convertSign: UILabel = {
        let convert = UILabel()
        convert.text = "1个会员红包"
        convert.textColor = UIColor.hex(hexString: "#979797")
        convert.font = MYFont(size: 12)
        convert.isHidden = true
        return convert
    }()
    
    lazy var reducePrice : JKPaddingLabel = {
        let ib = JKPaddingLabel()
        ib.paddingLeft = 4
        ib.paddingRight = 4
        ib.paddingTop = 1
        ib.paddingBottom = 1
        ib.textColor = UIColor.hex(hexString: "#F11F16")
        ib.font = MYFont(size: 11)
        ib.text = "3.3折"
        ib.textAlignment = .center
        ib.hg_setAllCornerWithCornerRadius(radius: 4)
        ib.jk.addBorder(borderWidth: 1, borderColor: .red)
        return ib
    }()
    
    

    var ruleView = XSVipTicketRule()
    
 

    override func configUI() {
        contentView.backgroundColor = .lightBackground
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
            make.left.equalTo(ticketView.snp_right).offset(26)
        }
        
        backView.addSubview(subLab)
        subLab.snp_makeConstraints { make in
            make.top.equalTo(tipLab.snp_bottom).offset(7)
            make.left.equalTo(tipLab.snp_left)
        }

        backView.addSubview(ruleBtn)
        ruleBtn.snp_makeConstraints { make in
            make.top.equalTo(subLab.snp_bottom).offset(16)
            make.left.equalTo(tipLab.snp_left)
        }

        backView.addSubview(useBtn)
        useBtn.jk.addBorder(borderWidth: 1, borderColor: .tag)
        useBtn.snp_makeConstraints { make in
            make.centerY.equalTo(ruleBtn.snp_centerY).offset(-10)
            make.right.equalTo(-10)
            make.width.equalTo(72)
            make.height.equalTo(24)
        }
        
        backView.addSubview(convertSign)
        convertSign.snp.makeConstraints { make in
            make.bottom.equalTo(useBtn.snp_top).offset(-5)
            make.centerX.equalTo(useBtn)
        }
        
        backView.addSubview(priviousPrice)
        priviousPrice.snp.makeConstraints { make in
            make.left.equalTo(useBtn)
            make.top.equalTo(useBtn.snp_bottom).offset(4)
        }
        
        backView.addSubview(reducePrice)
        reducePrice.snp.makeConstraints { make in
            make.left.equalTo(priviousPrice.snp_right).offset(2)
            make.centerY.equalTo(priviousPrice)
        }
        
        backView.addSubview(ruleView)
        ruleView.snp_makeConstraints { make in
            make.left.right.bottom.equalTo(0)
            make.top.equalTo(ticketView.snp_bottom)
        }
        
    }
    
    
    
    public func configTicketState() {
        ruleBtn.isHidden = true
        convertSign.isHidden = false
        priviousPrice.isHidden = true
        reducePrice.isHidden = priviousPrice.isHidden
        useBtn.setTitle("兑换", for: .normal)
        
    }

    @objc func clickRuleExpand() {
        expandBlock?()
    }
    
    @objc func userBtnClick() {
        if let myRedMemberPacketModels = myRedMemberPacketModels {
            if let result = exchangeMerchantHandler {
                result(myRedMemberPacketModels)

            }
        } else {
            exchangeMerchantHandler?(memberCardModels ?? MemberCardVoList())
        }
       
    }

}



