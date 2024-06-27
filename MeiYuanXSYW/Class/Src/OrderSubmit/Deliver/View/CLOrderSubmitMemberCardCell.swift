//
//  CLOrderSubmitMemberCarCell.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/7.
//

import UIKit
import QMUIKit

class CLOrderSubmitMemberCardCell: XSBaseTableViewCell {
    
    var height = 160
    
    let baseView = UIView().then{
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
    }
    
    let memberName = UILabel().then{
        $0.text = "行膳月卡会员"
        $0.textColor = .text
        $0.font = MYBlodFont(size: 16)
    }
    
    let moreButton = QMUIButton().then{
        $0.imagePosition = .right
        $0.setImage(UIImage(named: "mine_arrow"), for: .normal)
        $0.setTitle("查看更多", for: .normal)
        $0.setTitleColor(.fourText, for: .normal)
        $0.titleLabel?.font = MYFont(size: 13)
        $0.spacingBetweenImageAndTitle = 2
    }
    
    let voucherImage = UIImageView().then{
        $0.image = UIImage(named: "bg_35")
    }
    
    let ￥ = UILabel().then{
        $0.text = "￥"
        $0.textColor = .white
        $0.font = MYBlodFont(size: 18)
    }
    
    let couponPrice = UILabel().then{
        $0.text = "5"
        $0.textColor = .white
        $0.font = MYFont(size: 35)
    }
    
    let noLimit = UILabel().then{
        $0.text = "无门槛"
        $0.textColor = .white
        $0.font = MYFont(size: 12)
    }
    
    let cardName = UILabel().then{
        $0.text = "行膳月卡会员"
        $0.textColor = .text
        $0.font = MYFont(size: 15)
    }
    
    let currentMonth = UILabel().then{
        $0.text = "当月有效"
        $0.textColor = .twoText
        $0.font = MYFont(size: 12)
    }
    
    let noticeLabel = UILabel().then{
        $0.text = "本单可使用5元,31天内有效,全平台通用"
        $0.textColor = .king
        $0.font = MYFont(size: 14)
    }
    
    let selectButton = UIButton().then{
        $0.setImage(UIImage(named: "payAddress_selector_selected"), for: .normal)
    }
    
    let price = UILabel()
    
    let orginPrice = UILabel().then{
        $0.text = "市值￥30"
        $0.textColor = .twoText
        $0.font = MYFont(size: 12)
    }
    
    let line = UIView().then{
        $0.backgroundColor = .twoText
    }
    
    override func configUI() {
        super.configUI()
        contentView.backgroundColor = .lightBackground
        contentView.addSubview(baseView)
        baseView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview()
        }
        
        baseView.addSubviews(views: [memberName,moreButton,voucherImage,selectButton,price,orginPrice,line,noticeLabel])
        
        let str = "￥15"
        price.attributedText = str.setAttributed(font: MYBlodFont(size: 12), textColor: UIColor.qmui_color(withHexString: "#E61016")!, lineSpaceing: 0, wordSpaceing: -1, rangeFont: MYBlodFont(size: 16), range: NSMakeRange(1,str.count - 1))
        
        voucherImage.addSubviews(views: [￥,couponPrice,noLimit,cardName,currentMonth])
        
        memberName.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(12.5)
        }
        
        moreButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.centerY.equalTo(memberName.snp.centerY)
            make.width.equalTo(75)
            make.height.equalTo(20)
        }
        
        voucherImage.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-73)
            make.top.equalTo(memberName.snp.bottom).offset(12)
            make.height.equalTo(75)
        }

        ￥.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(21)
            make.top.equalToSuperview().offset(27)
        }
        
        couponPrice.snp.makeConstraints { make in
            make.left.equalTo(￥.snp.right).offset(-2)
            make.bottom.equalTo(￥.snp.bottom).offset(5)
        }
        
        noLimit.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(21)
            make.bottom.equalToSuperview().offset(-11.5)
        }
        
        cardName.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(98)
            make.top.equalToSuperview().offset(18.5)
        }
        
        currentMonth.snp.makeConstraints { make in
            make.left.equalTo(cardName.snp.left)
            make.top.equalTo(cardName.snp.bottom).offset(5)
        }
        
        price.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-8.5)
            make.top.equalTo(voucherImage.snp.top).offset(15)
        }
        
        selectButton.snp.makeConstraints { make in
            make.right.equalTo(price.snp.left).offset(-5)
            make.centerY.equalTo(price.snp.centerY)
            make.width.height.equalTo(16)
        }
        
        orginPrice.snp.makeConstraints { make in
            make.top.equalTo(selectButton.snp.bottom).offset(9.5)
            make.right.equalToSuperview().offset(-8.5)
        }
        
        line.snp.makeConstraints { make in
            make.left.equalTo(orginPrice.snp.left)
            make.right.equalTo(orginPrice.snp.right)
            make.centerY.equalTo(orginPrice.snp.centerY)
            make.height.equalTo(0.5)
        }
        
        noticeLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalTo(voucherImage.snp.bottom).offset(10)
        }
    }
}
