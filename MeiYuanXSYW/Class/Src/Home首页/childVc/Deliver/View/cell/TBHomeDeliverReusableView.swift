//
//  TBTableViewCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/10/22.
//

import UIKit
import QMUIKit


class TBKillSecondView: UIView {
    
    lazy var hour: QMUILabel = {
        let hourLabel = createPaddingLabel(text: "00")
        return hourLabel
    }()
    
    lazy var minute: QMUILabel = {
        let minuteLabel = createPaddingLabel(text: "00")
        return minuteLabel
    }()
    
    lazy var second: QMUILabel = {
        let secondLabel = createPaddingLabel(text: "00")
        return secondLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        seutp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func seutp(){
        self.addSubview(hour)
        hour.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
        }
        
        let line1 = createPaddingLabel(text: ":")
        self.addSubview(line1)
        line1.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.left.equalTo(hour.snp_right).offset(2)
        }
        
        self.addSubview(minute)
        minute.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.left.equalTo(line1.snp_right).offset(2)
        }
        
        let line2 = createPaddingLabel(text: ":")
        self.addSubview(line2)
        line2.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.left.equalTo(minute.snp_right).offset(2)
        }
        
        self.addSubview(second)
        second.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.left.equalTo(line2.snp_right).offset(2)
        }
    }
    
   private func createPaddingLabel(text: String) -> QMUILabel {
        let paddingLabel: QMUILabel = QMUILabel()
        paddingLabel.text = text
        paddingLabel.contentEdgeInsets = UIEdgeInsets(top: 2, left: 1, bottom: 2, right: 1)
        paddingLabel.sizeToFit()
        if text != ":" {
            paddingLabel.backgroundColor = UIColor.hex(hexString: "#FF9502")
            paddingLabel.textColor = .white
        } else {
            paddingLabel.textColor = UIColor.hex(hexString: "#FF9502")
        }
        paddingLabel.font = MYFont(size: 12)
        paddingLabel.hg_setAllCornerWithCornerRadius(radius: 4)
        return paddingLabel
    }
}

class TBHomeDeliverReusableView: UBaseTableViewHeaderFooterView {

    var moreBtnClickHandler: ((_ reusable: TBHomeDeliverReusableView) -> Void)?
    
    lazy var indicator: UIImageView = {
        let iw = UIImageView()
        iw.image = UIImage(named: "vip_SectionIcon")
        return iw
    }()
    
    lazy var indicatorTitle: UILabel = {
        let lab = UILabel()
        lab.textColor = .text
        lab.font = MYBlodFont(size: 18)
        lab.text = "秒杀专场"
        return lab
    }()
    
    lazy var subTitleLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.hex(hexString: "#B3B3B3")
        lab.font = MYFont(size: 12)
        lab.text = "您的点餐好帮手"
        return lab
    }()
    
    //更多
    lazy var moreBtn : QMUIButton = {
        let arrowBtn = QMUIButton(type: .custom)
        arrowBtn.imagePosition = QMUIButtonImagePosition.right
        arrowBtn.setTitle("更多", for: UIControl.State.normal)
        arrowBtn.setTitleColor(UIColor.hex(hexString: "#AAAAAA"), for: UIControl.State.normal)
        arrowBtn.setImage(UIImage(named: "merchInfo_detail_down"), for: .normal)
        arrowBtn.titleLabel?.font = MYFont(size: 13)
        arrowBtn.addTarget(self, action: #selector(moreAction), for: .touchUpInside)
        return arrowBtn
    }()
    
    lazy var killSecond: TBKillSecondView = {
        return TBKillSecondView()
    }()
    
    public func configMerchInfo(more moreText: String? = nil) {
        self.backgroundColor = .clear
        self.contentView.backgroundColor = self.backgroundColor
        subTitleLab.isHidden = true
        killSecond.isHidden = true
        
        if let moreStr = moreText {
            moreBtn.setTitle(moreStr, for: .normal)
            moreBtn.isHidden = false
        } else {
            moreBtn.setTitle(moreText, for: .normal)
            moreBtn.isHidden = true
        }
       
        
    }
    
    override func configUI() {
        self.contentView.backgroundColor = .white
        self.backgroundColor = .clear
        self.contentView.hg_setCornerOnTopWithRadius(radius: 10)
        
        self.contentView.addSubview(indicator)
        indicator.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(17)
            make.left.equalToSuperview().offset(10)
            make.size.equalTo(CGSize(width: 6, height: 13))
        }
        
        self.contentView.addSubview(indicatorTitle)
        indicatorTitle.snp.makeConstraints { make in
            make.centerY.equalTo(indicator)
            make.left.equalTo(indicator.snp_right).offset(5)
        }
        
        self.contentView.addSubview(subTitleLab)
        subTitleLab.snp.makeConstraints { make in
            make.centerY.equalTo(indicator)
            make.left.equalTo(indicatorTitle.snp_right).offset(5)
        }
        
        self.contentView.addSubview(killSecond)
        killSecond.snp.makeConstraints { make in
            make.left.equalTo(indicatorTitle.snp_right).offset(10)
            make.width.equalTo(120)
            make.top.bottom.equalToSuperview()
        }
        
        self.contentView.addSubview(moreBtn)
        moreBtn.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-15)
            //make.width.equalTo(120)
            make.centerY.equalToSuperview()
        }
    }
    
    @objc func moreAction(){
        moreBtnClickHandler?(self)
    }

}
