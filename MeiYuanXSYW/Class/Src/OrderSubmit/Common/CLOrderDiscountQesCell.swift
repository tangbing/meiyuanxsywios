//
//  CLOrderDiscountQesCell.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/8.
//

import UIKit
import QMUIKit

class CLOrderDiscountQesCell: XSBaseTableViewCell {
    
    var clickBlock:(()->())?
    
    var height = 46
    
    let baseView = UIView().then{
        $0.backgroundColor = .white
    }
    
    let qesButton = QMUIButton(type: .custom).then{
        $0.setTitle("多件折扣", for: .normal)
        $0.setTitleColor(.text, for: .normal)
        $0.titleLabel?.font = MYFont(size: 14)
        $0.setImage(UIImage(named: "icon_question"), for: .normal)
        $0.imagePosition = .right
        $0.addTarget(self, action: #selector(click), for: .touchUpInside)
    }
    
    @objc func click(){
        guard let action = clickBlock else { return }
        action()
    }
    
    
    let priceLabel = UILabel().then{
        $0.textColor = .twoText
        $0.font = MYFont(size: 16)
    }
    
    override func configUI() {
        super.configUI()
        contentView.backgroundColor = .lightBackground
        contentView.addSubview(baseView)
        baseView.addSubviews(views: [qesButton,priceLabel])
        
//        let str = "-￥27.5"
//        priceLabel.attributedText = str.setAttributed(font: MYFont(size: 12), textColor: .twoText, lineSpaceing: 0, wordSpaceing: -1, rangeFont: MYFont(size: 16), range: NSMakeRange(2,str.count - 2))
        
        baseView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.bottom.equalToSuperview()
        }
        qesButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(19)
            make.left.equalToSuperview().offset(10)
            make.width.equalTo(80)
            make.height.equalTo(20)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.centerY.equalTo(qesButton.snp.centerY)
        }
        
    }
}
