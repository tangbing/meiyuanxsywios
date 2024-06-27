//
//  CLReturnStatusStepCell.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/11/26.
//

import UIKit

class CLReturnStatusStepCell: XSBaseTableViewCell {
    
    var line1Status:Bool = true{
        didSet {
            if line1Status == false {
                self.line1.isHidden = true
            }else{
                self.line1.isHidden = false
            }
        }
    }
    
    var line2Status:Bool = true{
        didSet {
            if line2Status == false {
                self.line2.isHidden = true
            }else{
                self.line2.isHidden = false
            }
        }
    }
    
    let baseView = UIView().then{
        $0.backgroundColor = .white
    }
    
    let dotView = UIView().then{
        $0.backgroundColor = .borad
        $0.layer.cornerRadius = 3.5
    }
    
    let line1 = UIView().then{
        $0.backgroundColor = .borad
    }
    
    let line2 = UIView().then{
        $0.backgroundColor = .borad
    }
    
    let title = UILabel().then{
        $0.text = "退款入账中"
        $0.textColor = .text
        $0.font = MYFont(size: 12)
    }
    
    let time = UILabel().then{
        $0.text = "2020-01-01 20:12:45"
        $0.textColor = .twoText
        $0.font = MYFont(size: 12)
    }

    let des = UILabel().then{
        $0.text = "平台自动退款"
        $0.textColor = .twoText
        $0.font = MYFont(size: 12)
    }
    
    
    override func configUI(){
        contentView.backgroundColor = .lightBackground
        contentView.addSubview(baseView)
        baseView.addSubviews(views: [dotView,line1,line2,title,time,des])
        
        baseView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        dotView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(18)
            make.width.height.equalTo(7)
        }
        
        title.snp.makeConstraints { make in
            make.left.equalTo(dotView.snp.right).offset(3.5)
            make.centerY.equalTo(dotView.snp.centerY)
        }
        
        time.snp.makeConstraints { make in
            make.left.equalTo(title.snp.right).offset(40)
            make.centerY.equalTo(dotView.snp.centerY)
        }
        
        des.snp.makeConstraints { make in
            make.left.equalTo(title.snp.left)
            make.top.equalTo(title.snp.bottom).offset(15)
        }
        
        line1.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalTo(dotView.snp.centerX)
            make.width.equalTo(0.5)
            make.bottom.equalTo(dotView.snp.top)
        }
        
        line2.snp.makeConstraints { make in
            make.top.equalTo(dotView.snp.bottom)
            make.centerX.equalTo(dotView.snp.centerX)
            make.width.equalTo(0.5)
            make.bottom.equalToSuperview()
        }
        
    }
}
