//
//  CLSubmitPayCell.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/13.
//

import UIKit

class CLSubmitPayCell: XSBaseTableViewCell {
    
    let logo = UIImageView()
    
    let name = UILabel().then{
        $0.text = "微信支付"
        $0.textColor = .text
        $0.font = MYFont(size: 14)
    }
    
    let selectButton = UIButton().then{
        $0.setImage(UIImage(named: "payAddress_selector_selected"), for: .normal)
    }
    
    let line = UIView().then{
        $0.backgroundColor = .borad
    }
    
    func updateLineConstraints(){
        line.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(33.5)
            make.right.equalToSuperview().offset(-12)
            make.bottom.equalToSuperview()
            make.width.height.equalTo(0.5)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected == true {
            self.selectButton.setImage(UIImage(named: "payAddress_selector_selected"), for: .normal)
        }else{
            self.selectButton.setImage(UIImage(named: "payAddress_selector_unchecked"), for: .normal)
        }
    }
    
    override func configUI() {
        super.configUI()
        contentView.backgroundColor = .white
        contentView.addSubviews(views: [logo,name,selectButton,line])
        
        logo.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(8.5)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(20)
        }
        
        name.snp.makeConstraints { make in
            make.left.equalTo(logo.snp.right).offset(5)
            make.centerY.equalToSuperview()
        }
        
        selectButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-12)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(16)
        }
        
        line.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(8.5)
            make.right.equalToSuperview().offset(-12)
            make.bottom.equalToSuperview()
            make.width.height.equalTo(0.5)
        }
        
    }
}
