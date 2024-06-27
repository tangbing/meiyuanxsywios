//
//  CLDeliverRefundAddReasonCell.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/3.
//

import UIKit

class CLDeliverRefundAddReasonCell: XSBaseTableViewCell {
    
    let title = UILabel().then{
        $0.text = "其他补充"
        $0.textColor = .text
        $0.font = MYBlodFont(size: 14)
    }
    
    let baseView = UIView().then{
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10
    }

    let reasonLabel = UILabel().then{
        $0.text  = "原因原因原因原因原因原因原因原因原因原因原因原因原因原因原因原因原因原因原因原因原因原因原因原因原因原因原因原因原因原因原因原因"
        $0.textColor = .text
        $0.font = MYFont(size: 14)
        $0.numberOfLines = 0
    }
    
    let title1 = UILabel().then{
        $0.text = "凭证"
        $0.textColor = .text
        $0.font = MYBlodFont(size: 14)
    }
    
    
    override func configUI() {
        
        contentView.backgroundColor = .lightBackground
        self.selectionStyle = .none
        
        contentView.addSubviews(views: [title,baseView])
        baseView.addSubview(reasonLabel)
        self.addSubview(title1)
        
        title.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(10)
        }
        
        baseView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalTo(title.snp.bottom).offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(145)
        }
        
        reasonLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-21)
            make.top.equalToSuperview().offset(15)
        }
        
        title1.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.top.equalTo(baseView.snp.bottom).offset(10)
        }
        
        for i in 0...3 {
            let imageView =  UIImageView()
            imageView.contentMode = .scaleToFill
            imageView.image = UIImage(named: "test")
            imageView.layer.cornerRadius = 5
            imageView.clipsToBounds = true

            self.addSubview(imageView)
            imageView.snp.makeConstraints { make in
                make.left.equalToSuperview().offset(10 + 85*i)
                make.top.equalTo(title1.snp.bottom).offset(10)
                make.width.height.equalTo(75)
            }
        }
        
        
    }
}
