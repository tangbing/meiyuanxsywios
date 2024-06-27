//
//  CLUpgradeMemberCell.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/9.
//

import UIKit

class CLUpgradeMemberCell: XSBaseTableViewCell {
    
    var isAbel:Bool = true {
        didSet{
            if isAbel == true{
                self.coupnImage.image = UIImage(named: "bg002")
                self.coupnImage.alpha = 1
                selectButton.isHidden = false
                leftLabel.isHidden = false
                useLimit.isHidden  = true

            }else{
                self.coupnImage.image = UIImage(named: "bg001")
                self.coupnImage.alpha = 0.5
                selectButton.isHidden = true
                leftLabel.isHidden = true
                useLimit.isHidden  = false
                
                ￥.snp.remakeConstraints { make in
                    make.left.equalToSuperview().offset(22)
                    make.top.equalToSuperview().offset(14.5)
                }
            }
        }
    }
    
    
    let coupnImage = UIImageView().then{
        $0.image = UIImage(named: "bg002")
    }
    
    let ￥ = UILabel().then{
        $0.textColor = .white
//        let attributedString = NSMutableAttributedString(string: "￥8")
//        attributedString.addAttribute(NSAttributedString.Key.font, value: MYFont(size: 18), range: NSMakeRange(0, attributedString.length - 1))
//
//        attributedString.addAttribute(NSAttributedString.Key.font, value: MYFont(size: 18), range: NSMakeRange(0, 0))
//        attributedString.addAttribute(NSAttributedString.Key.font, value: MYFont(size: 35), range: NSMakeRange(1, attributedString.length - 1))
//
//        $0.attributedText = attributedString
    }
    
    let useLimit = UILabel().then{
        $0.text = "满50元使用"
        $0.textColor = .white
        $0.font = MYFont(size: 12)
        $0.isHidden = true
    }
    
    let couponName = UILabel().then{
        $0.text = "行膳有味会员红包"
        $0.textColor = .text
        $0.font  = MYBlodFont(size: 15)
    }
    let endTime = UILabel().then{
        $0.text = "有效期至 2021.6.21"
        $0.textColor = .twoText
        $0.font  = MYFont(size: 12)
    }
    let des = UILabel().then{
        $0.text = "仅限 154 2562 2541 使用"
        $0.textColor = .twoText
        $0.font  = MYFont(size: 12)
    }

    let selectButton = UIButton().then{
        $0.setImage(UIImage(named: "payAddress_selector_selected"), for: .normal)
    }
    let leftLabel = UILabel().then{
        $0.text = "还剩2张"
        $0.textColor = .king
        $0.font = MYFont(size: 12)
    }
    
    func attributedString(string:String,font: UIFont, textColor: UIColor, lineSpaceing: CGFloat, wordSpaceing: CGFloat) -> NSAttributedString {
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = lineSpaceing
        let attributes = [
                NSAttributedString.Key.font             : font,
                NSAttributedString.Key.foregroundColor  : textColor,
                NSAttributedString.Key.paragraphStyle   : style,
                NSAttributedString.Key.kern             : wordSpaceing]
            
            as [NSAttributedString.Key : Any]
        let attrStr = NSMutableAttributedString.init(string:string, attributes: attributes)
        
        // 设置某一范围样式
//        attrStr.addAttribute(NSAttributedString.Key.font, value: MYFont(size: 18), range: NSMakeRange(0, 0))
        attrStr.addAttribute(NSAttributedString.Key.font, value: MYFont(size: 35), range: NSMakeRange(1, string.count - 1))

        return attrStr
    }
    
    
    override func configUI() {
        super.configUI()
        contentView.backgroundColor = .white
        contentView.addSubview(coupnImage)
        coupnImage.addSubviews(views: [￥,useLimit,couponName,endTime,des,selectButton,leftLabel])
        
        ￥.attributedText = self.attributedString(string:"￥8",font: MYFont(size: 18), textColor: .white, lineSpaceing: 0, wordSpaceing:-2)

    
        coupnImage.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(80)
        }
        
        ￥.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(22)
            make.top.equalToSuperview().offset(22.5)
        }
        
        useLimit.snp.makeConstraints { make in
            make.centerX.equalTo(￥.snp.centerX)
            make.top.equalTo(￥.snp.bottom).offset(2)
        }
        
        couponName.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(90)
        }
        
        endTime.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(90)
            make.top.equalTo(couponName.snp.bottom).offset(7)
        }
        
        des.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(90)
            make.top.equalTo(endTime.snp.bottom).offset(11)
        }
        
        selectButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-15)
            make.top.equalToSuperview().offset(15)
            make.width.height.equalTo(16)
        }
        
        leftLabel.snp.makeConstraints { make in
            make.right.equalTo(selectButton.snp.left).offset(-6)
            make.centerY.equalTo(selectButton.snp.centerY)
        }
    }
}
