//
//  TBMerchInfoPackageTableCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/1.
//

import UIKit
import SwiftUI

class TBMerchInfoPackageTableCell: XSBaseTableViewCell {
    
    
    var packageModel: TBComboDetails? {
        didSet {
            guard let model = packageModel else { return }
            
            tipImg.xs_setImage(urlString: model.goodsPic)
            //tipImg.hg_setAllCornerWithCornerRadius(radius: 6)

            nameLab.text = model.goodsName
            
            evaluatView.hightEvaluate.text = "\(model.praise)%好评率"
            
            
            msgLab.text = model.salesDate + " " + (model.isReserve == 0 ? "预约" : "免预约")
            
            priceView.finalPriceLabel.text = "￥\(model.price)"
            priceView.previousPriceLabel.text = "￥\(model.originalPrice)"
            priceView.reduceDownPriceLabel.text = "\(model.discount)折"
            
        }
    }
    
    
    lazy var containerBackView: UIView = {
        let iv = UIView()
        iv.backgroundColor = .white
        iv.hg_setAllCornerWithCornerRadius(radius: 10)
        return iv
    }()

    //商家图片
    lazy var tipImg : UIImageView = {
        let tipImg = UIImageView()
        tipImg.contentMode = .scaleAspectFill
        tipImg.image = UIImage(named: "login_LOGO")
        tipImg.hg_setAllCornerWithCornerRadius(radius: 6)
        return tipImg
    }()
    //商家名称加标签
    lazy var nameLab : UILabel={
        let nameLab = UILabel()
        nameLab.numberOfLines = 1
        nameLab.font = MYBlodFont(size: 16)
        nameLab.textColor = .text
        let str = "商家名称商家名称商家名称商家名称"
        nameLab.text = str
        return nameLab
    }()
    
    lazy var msgLab : UILabel={
        let msgLab = UILabel()
        msgLab.font = MYFont(size: 13)
        msgLab.textColor = .twoText
        let str = "周一至周日 免预约"
        msgLab.text = str
        return msgLab
    }()
    
    lazy var evaluatView: XSCollectHightEvaluatView = {
        return XSCollectHightEvaluatView()
    }()
    
    lazy var priceView: XSCollectPriceView = {
        return XSCollectPriceView()
    }()
    
    //抢购
    lazy var rushToPurBtn : UIButton = {
        let arrowBtn = UIButton(type: .custom)
        arrowBtn.setTitle("抢购", for: UIControl.State.normal)
        arrowBtn.setTitleColor(.white, for: UIControl.State.normal)
        arrowBtn.hg_setAllCornerWithCornerRadius(radius: 12)
        arrowBtn.titleLabel?.font = MYFont(size: 14)
        arrowBtn.setBackgroundImage(UIColor.hex(hexString: "#F6094C").image(), for: UIControl.State.normal)
        arrowBtn.addTarget(self, action: #selector(rushToPurBtnAction), for: .touchUpInside)
        return arrowBtn
    }()
    
    @objc func rushToPurBtnAction() {
        NotificationCenter.default.post(name: NSNotification.Name.XSCartPlusBtnClickNotification , object: self, userInfo: ["TBMerchInfoDeliverCollectionViewCell" : self])
    }
    
    override func configUI() {
        super.configUI()
        
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        self.contentView.addSubview(containerBackView)
        containerBackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10))
        }
        
        containerBackView.addSubview(tipImg)
        tipImg.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(10)
            make.width.equalTo(120)
            /// multipliedBy, 120 * 0.75 , dividedBy , 直接除以一个数值
            make.height.equalTo(tipImg.snp_width).multipliedBy(0.75)
        }
        
        containerBackView.addSubview(nameLab)
        nameLab.snp.makeConstraints { make in
            make.top.equalTo(tipImg)
            make.height.equalTo(23)
            make.left.equalTo(tipImg.snp_right).offset(10)
        }
        
        containerBackView.addSubview(evaluatView)
        evaluatView.snp.makeConstraints { make in
            make.top.equalTo(nameLab.snp_bottom).offset(4)
            make.left.equalTo(nameLab)
            make.height.equalTo(18)
        }
        
        containerBackView.addSubview(msgLab)
        msgLab.snp.makeConstraints { make in
            make.top.equalTo(evaluatView.snp_bottom).offset(9)
            make.left.equalTo(nameLab)
            make.height.equalTo(18)

        }
        
        containerBackView.addSubview(rushToPurBtn)
        rushToPurBtn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-10)
            make.right.equalToSuperview().offset(-10)
            make.size.equalTo(CGSize(width: 60, height: 24))
        }
        
        containerBackView.addSubview(priceView)
        priceView.snp.makeConstraints { make in
            make.top.equalTo(msgLab.snp_bottom).offset(2)
            make.left.equalTo(nameLab)
            make.right.equalTo(rushToPurBtn.snp_left).offset(-10)
            make.height.equalTo(18)
        }
    }
}
