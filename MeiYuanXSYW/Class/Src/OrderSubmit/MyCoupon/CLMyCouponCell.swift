//
//  CLMyCouponCell.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/16.
//

import UIKit

class CLMyCouponCell: XSBaseTableViewCell {
    
    var isAbel:Bool = true {
        didSet{
            if isAbel == true{
                self.coupnImage.alpha = 1
                self.selectButton.isHidden  = false
                
            }else{
                self.coupnImage.alpha = 0.5
                self.selectButton.isHidden  = true
            }
        }
    }
    
    let coupnImage = UIImageView().then{
        $0.image = UIImage(named: "bg001")
    }
    
    let ￥ = UILabel().then{
        $0.textColor = .white
    }
    
    let useLimit = UILabel().then{
        $0.text = "满50元使用"
        $0.textColor = .white
        $0.font = MYFont(size: 12)
    }
    
    let couponName = UILabel().then{
        $0.text = "行膳有味会员红包"
        $0.textColor = .text
        $0.font  = MYBlodFont(size: 15)
    }
    let leftTime = UILabel().then{
        $0.text = "使用剩余时间: 1天14:25:36"
        $0.textColor = .twoText
        $0.font  = MYFont(size: 12)
    }
    let des = UILabel().then{
        $0.text = "使用条件:仅限AAA使用"
        $0.textColor = .twoText
        $0.font  = MYFont(size: 12)
    }

    let selectButton = UIButton().then{
        $0.setImage(UIImage(named: "payAddress_selector_selected"), for: .normal)
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
        coupnImage.addSubviews(views: [￥,useLimit,couponName,leftTime,des,selectButton])
        
        ￥.attributedText = self.attributedString(string:"￥10",font: MYFont(size: 18), textColor: .white, lineSpaceing: 0, wordSpaceing:-3)

    
        coupnImage.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(80)
        }
        
        ￥.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(22)
            make.top.equalToSuperview().offset(14.5)
        }
        
        useLimit.snp.makeConstraints { make in
            make.centerX.equalTo(￥.snp.centerX)
            make.top.equalTo(￥.snp.bottom).offset(2)
        }
        
        couponName.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(90)
        }
        
        leftTime.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(90)
            make.top.equalTo(couponName.snp.bottom).offset(7)
        }
        
        des.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(90)
            make.top.equalTo(leftTime.snp.bottom).offset(11)
        }
        
        selectButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-15)
            make.top.equalToSuperview().offset(15)
            make.width.height.equalTo(16)
        }
        
    }
}
