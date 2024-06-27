//
//  TBPicLocationApplyMerchTableViewCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/17.
//

import UIKit
import QMUIKit

class TBApplyMerchTopView: UIView {
    
    //适用商户
    lazy var titleLab : UILabel={
        let nameLab = UILabel()
        nameLab.numberOfLines = 1
        nameLab.font = MYBlodFont(size: 18)
        nameLab.textColor = .text
        nameLab.text = "适用商户"
        return nameLab
    }()
    
    var arrowBtn : QMUIButton = {
        let arrowBtn = QMUIButton()
        arrowBtn.imagePosition = QMUIButtonImagePosition.right
        arrowBtn.setTitle("245家门店通用", for: UIControl.State.normal)
        arrowBtn.setImage(UIImage(named: "merchInfo_detail_down"), for: UIControl.State.normal)
        arrowBtn.setTitleColor(.twoText, for: UIControl.State.normal)
        arrowBtn.titleLabel?.font = MYFont(size: 13)
        arrowBtn.spacingBetweenImageAndTitle = 3
        arrowBtn.addTarget(self, action: #selector(showMoreMerch), for: .touchUpInside)
        arrowBtn.isHidden = true
        return arrowBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func showMoreMerch() {
        
    }

    func setup() {
        self.addSubview(titleLab)
        titleLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(15)
        }
        
        self.addSubview(arrowBtn)
        arrowBtn.snp.makeConstraints { make in
            make.centerY.equalTo(titleLab)
            make.right.equalToSuperview().offset(-10)
        }
        
    }
}

class TBPicLocationApplyMerchTableViewCell: XSBaseTableViewCell {

    var callPhoneClickHandler: ((_ applyMerchModel: TBShopInfoApplyMerchModel) -> Void)?
    
    
    var applyMerchModel: TBShopInfoApplyMerchModel? {
        didSet {
            guard let model = applyMerchModel?.groupBuyGoodsItem else {
                return
            }
            
            iconView.xs_setImage(urlString: model.merchantLogo)
            
            nameLab.text = model.goodsName
            
            scoreLab.text = "\(model.merchantScore)分"
            
            addressBtn.setTitle(model.merchantAddress, for: .normal)
            
        }
    }
    
    lazy var contain: UIView = {
        let iv = UIView()
        iv.backgroundColor = .white
        iv.hg_setAllCornerWithCornerRadius(radius: 10)
        return iv
    }()
    
    lazy var topView: TBApplyMerchTopView = {
        return TBApplyMerchTopView()
    }()
    
    lazy var iconView: UIImageView = {
        let icon = UIImageView()
        icon.image = #imageLiteral(resourceName: "login_LOGO")
        return icon
    }()
    
    lazy var telephoneBtn: QMUIButton = {
        let btn = QMUIButton(type: .custom)
        btn.setImage(UIImage(named: "merch_info_telephone"), for: .normal)
        btn.setTitle("联系商家", for: .normal)
        btn.titleLabel?.font = MYFont(size: 12)
        btn.setTitleColor(.twoText, for: .normal)
        btn.spacingBetweenImageAndTitle = 3
        btn.imagePosition = .top
        btn.addTarget(self, action: #selector(callPhone), for: .touchUpInside)
        return btn
    }()
    
   
    //有效期
    lazy var nameLab : UILabel={
        let name = UILabel()
        name.numberOfLines = 1
        name.font = MYBlodFont(size: 13)
        name.textColor = .text
        name.text = "巴黎世家甜品工作室（罗湖店）"
        return name
    }()
    
    ///评分Icon
    lazy var scoreIcon : UIImageView = {
        let scoreIcon = UIImageView()
        scoreIcon.image = UIImage(named: "vip_score")
        return scoreIcon
    }()
    //评分
    lazy var scoreLab : UILabel={
        let scoreLab = UILabel()
        scoreLab.font = MYFont(size: 12)
        scoreLab.textColor = .warn
        scoreLab.text = "4.9分"
        return scoreLab
    }()
    
    lazy var addressBtn: QMUIButton = {
        let btn = QMUIButton(type: .custom)
        btn.setImage(UIImage(named: "merchInfo_detail_down"), for: .normal)
        btn.setTitle("深圳市罗湖区城市天地广场", for: .normal)
        btn.titleLabel?.font = MYFont(size: 12)
        btn.setTitleColor(.twoText, for: .normal)
        btn.spacingBetweenImageAndTitle = 1
        btn.imagePosition = .right
        btn.addTarget(self, action: #selector(callPhone), for: .touchUpInside)
        return btn
    }()
    
    override func configUI() {
        super.configUI()
        self.contentView.backgroundColor = .background
        setupCell()
    }
    
   func setupCell() {
       
       self.contentView.addSubview(contain)
       contain.snp.makeConstraints { make in
           make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
       }
       
       contain.addSubview(topView)
       topView.snp.makeConstraints { make in
           make.top.left.right.equalToSuperview()
           make.height.equalTo(43)
       }
       
       contain.addSubview(iconView)
       iconView.snp.makeConstraints { make in
           make.left.equalToSuperview().offset(10)
           make.bottom.equalToSuperview().offset(-16)
           make.top.equalTo(topView.snp_bottom).offset(0)
           make.width.height.equalTo(40)
       }
       
       contain.addSubview(telephoneBtn)
       telephoneBtn.snp.makeConstraints { make in
           make.right.equalToSuperview().offset(-10)
           make.top.equalTo(iconView.snp_top).offset(-5)
           make.width.height.equalTo(55)
       }
       
       contain.addSubview(nameLab)
       nameLab.snp.makeConstraints { make in
           make.top.equalTo(iconView).offset(0)
           make.right.equalTo(telephoneBtn.snp_right).offset(-10)
           make.left.equalTo(iconView.snp_right).offset(10)
           make.height.equalTo(13)
       }
       
       contain.addSubview(scoreLab)
       scoreLab.snp.makeConstraints { make in
           make.top.equalTo(nameLab.snp_bottom).offset(4)
           make.left.equalTo(nameLab)
           make.height.equalTo(15)
       }
       
       contain.addSubview(scoreIcon)
       scoreIcon.snp.makeConstraints { make in
           make.centerY.equalTo(scoreLab).offset(0)
           make.left.equalTo(scoreLab.snp_right).offset(4)
           make.width.height.equalTo(12)
       }
       
       contain.addSubview(addressBtn)
       addressBtn.snp.makeConstraints { make in
           make.top.equalTo(scoreLab.snp_bottom).offset(4)
           make.left.equalTo(nameLab)
           make.height.equalTo(12)
           make.bottom.equalToSuperview().offset(-10)
       }

    }
    
    @objc func callPhone(){
        callPhoneClickHandler?(applyMerchModel!)
    }


}
