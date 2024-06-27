//
//  CLOrderSubmitTakeBySelfCell.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/9.
//

import UIKit

class CLOrderSubmitTakeBySelfCell:  XSBaseTableViewCell {
    
    var timeSelectBlock:(()->())?

    
    let baseView = UIView().then{
        $0.backgroundColor = .white
    }
    
    let baseView1 = UIView().then{
        $0.backgroundColor = .white
    }
    
    let baseView2 = UIView().then{
        $0.backgroundColor = .white
    }
    
    let baseView3 = UIView().then{
        $0.backgroundColor = .white
    }
    
    let addrImage = UIImageView().then{
        $0.image = UIImage(named: "home_location")
    }
    
    let addrDetailLabel = UILabel().then{
        $0.text = "城市天地广场东卓6楼626城市天地广场东卓6楼626"
        $0.textColor = .text
        $0.font = MYFont(size: 14)
        $0.numberOfLines = 2
    }
    
    let locationImage = UIImageView().then{
        $0.image = UIImage(named: "merch_info_location")
    }
    
    let line = UIView().then{
        $0.backgroundColor = UIColor.borad
    }
    
    let deliverLabel = UILabel().then{
        $0.text = "自取时间"
        $0.textColor = .text
        $0.font = MYBlodFont(size: 14)
    }
    
    let timeLabel = UILabel().then{
        $0.text = "大约20:20送达"
        $0.textColor = .king
        $0.font = MYFont(size: 12)
    }
    let timeSelectImage = UIImageView().then{
        $0.image = UIImage(named: "icon_more1")
    }
    
    let reservedLabel = UILabel().then{
        $0.text = "预留电话"
        $0.textColor = .text
        $0.font = MYBlodFont(size: 14)
    }
    
    let phoneLabel = UITextField().then{
        $0.text = "17603078077"
        $0.textColor = .twoText
        $0.font = MYFont(size: 12)
        $0.borderStyle = .none
        $0.placeholder = "请填写手机号"
    }

    
    let accessImage = UIImageView().then{
        $0.image = UIImage(named: "home_hot_arow_right")
    }
    
    @objc func selectTime(){
        guard let action = timeSelectBlock else {
            return
        }
        action()
    }

    override func configUI() {
        super.configUI()
        contentView.backgroundColor = .lightBackground
        contentView.addSubview(baseView)
//        baseView.addSubviews(views: [addrImage,addrDetailLabel,locationImage,reservedLabel,phoneLabel,accessImage,line,deliverLabel,timeLabel,timeSelectImage])
        baseView.addSubviews(views: [baseView1,baseView2,baseView3])
        baseView1.addSubviews(views: [addrImage,addrDetailLabel,locationImage,line])
        baseView2.addSubviews(views: [deliverLabel,timeLabel,timeSelectImage])
        baseView3.addSubviews(views: [reservedLabel,phoneLabel,accessImage])
        
        baseView.hg_setCornerOnBottomWithRadius(radius: 10)
        
        
        let tap1 = UITapGestureRecognizer.init(target: self, action: #selector(selectTime))
        baseView2.addGestureRecognizer(tap1)
        
        baseView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        baseView1.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(68)
        }
        
        baseView2.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(baseView1.snp.bottom)
            make.height.equalTo(30)
        }
        
        baseView3.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(baseView2.snp.bottom)
            make.bottom.equalToSuperview()
        }
        
        
        addrImage.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(12.5)
        }
        
        addrDetailLabel.snp.makeConstraints { make in
            make.left.equalTo(addrImage.snp.right).offset(6)
            make.top.equalTo(addrImage.snp.top)
            make.width.equalTo(170)
        }
        
        locationImage.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(addrImage.snp.top).offset(9.5)
            make.height.width.equalTo(22)
        }
        
        line.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }

        deliverLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(10)
        }
        
        timeSelectImage.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-6)
            make.centerY.equalTo(deliverLabel.snp.centerY)
            make.width.height.equalTo(11)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.right.equalTo(timeSelectImage.snp.left).offset(-3)
            make.centerY.equalTo(deliverLabel.snp.centerY)
        }
        
        reservedLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(10)
        }
        
        accessImage.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.centerY.equalTo(reservedLabel.snp.centerY)
            make.width.height.equalTo(22)
        }
        
        phoneLabel.snp.makeConstraints { make in
            make.right.equalTo(accessImage.snp.left).offset(-2)
            make.centerY.equalTo(accessImage.snp.centerY)
        }
        

    }
}
