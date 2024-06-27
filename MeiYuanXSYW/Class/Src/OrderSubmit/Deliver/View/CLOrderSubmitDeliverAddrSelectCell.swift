//
//  CLOrderSubmitDeliverAddrSelectCell.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/7.
//

import UIKit
import Kingfisher

class CLOrderSubmitDeliverAddrSelectCell: XSBaseTableViewCell {
    var addrSelectBlock:(()->())?
    var timeSelectBlock:(()->())?
    
    var hasAddr:Bool = false {
        didSet{
            
            if hasAddr == true {
                
                emptyAddrView.removeFromSuperview()
                
                baseView1.addSubviews(views: [addrImage,addrDetailLabel,personName,phone,accessImage,line])
                
                
                baseView1.snp.remakeConstraints { make in
                    make.left.right.top.equalToSuperview()
                    make.height.equalTo(69)
                }
                
                addrImage.snp.remakeConstraints { make in
                    make.left.equalToSuperview().offset(10)
                    make.top.equalToSuperview().offset(12.5)
                }
                
                addrDetailLabel.snp.remakeConstraints { make in
                    make.left.equalTo(addrImage.snp.right).offset(7)
                    make.top.equalTo(addrImage.snp.top)
                }
                
                personName.snp.remakeConstraints { make in
                    make.left.equalTo(addrDetailLabel.snp.left)
                    make.top.equalTo(addrDetailLabel.snp.bottom).offset(6)
                }
                
                phone.snp.remakeConstraints { make in
                    make.left.equalTo(personName.snp.right).offset(10)
                    make.centerY.equalTo(personName.snp.centerY)
                }
                
                accessImage.snp.remakeConstraints { make in
                    make.right.equalToSuperview()
                    make.top.equalToSuperview().offset(24)
                    make.width.height.equalTo(22)
                }
                line.snp.remakeConstraints { make in
                    make.left.equalToSuperview().offset(10)
                    make.right.equalToSuperview().offset(-10)
                    make.top.equalTo(personName.snp.bottom).offset(10)
                    make.height.equalTo(0.5)
                }

            }else{
                _ = baseView1.subviews.map {
                    $0.removeFromSuperview()
                }
                
                baseView1.addSubview(emptyAddrView)
                baseView1.snp.remakeConstraints { make in
                    make.left.right.top.equalToSuperview()
                    make.height.equalTo(53)
                }
                
                emptyAddrView.snp.makeConstraints { make in
                    make.left.top.right.bottom.equalToSuperview()
                }
            }
            

        }
    }

    
    let emptyAddrView = CLEmptyAddressView()

    
    let baseView1 = UIView().then{
        $0.backgroundColor = .white
    }
    
    let baseView2 = UIView().then{
        $0.backgroundColor = .white
    }
    
    
    let baseView = UIView().then{
        $0.backgroundColor = .white
    }
    
    
    let addrImage = UIImageView().then{
        $0.image = UIImage(named: "home_location")
    }
    
    let addrDetailLabel = UILabel().then{
        $0.text = "城市天地广场东卓6楼626"
        $0.textColor = .text
        $0.font = MYFont(size: 14)
    }
    
    let personName = UILabel().then{
        $0.text = "张先生"
        $0.textColor = .text
        $0.font = MYFont(size: 14)
    }
    
    let phone = UILabel().then{
        $0.text = "17623727382"
        $0.textColor = .twoText
        $0.font = MYFont(size: 14)
    }
    
    let accessImage = UIImageView().then{
        $0.image = UIImage(named: "home_hot_arow_right")        
    }
    
    let line = UIView().then{
        $0.backgroundColor = UIColor.borad
    }
    
    let deliverLabel = UILabel().then{
        $0.text = "立即送出"
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
    
    
    @objc func selectAddr(){
        guard let action = addrSelectBlock else {
            return
        }
        action()
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
        baseView.addSubviews(views: [baseView1,baseView2])
        
        let tap1 = UITapGestureRecognizer.init(target: self, action: #selector(selectAddr))
        baseView1.addGestureRecognizer(tap1)
      
        let tap2 = UITapGestureRecognizer.init(target: self, action: #selector(selectTime))
        baseView2.addGestureRecognizer(tap2)
        
        baseView1.addSubviews(views: [addrImage,addrDetailLabel,personName,phone,accessImage,line])
        baseView2.addSubviews(views: [deliverLabel,timeLabel,timeSelectImage])
        

        
        baseView.hg_setCornerOnBottomWithRadius(radius: 10)
        
        baseView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        baseView1.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(69)
        }
        
        baseView2.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(baseView1.snp.bottom)
            make.height.equalTo(44)
        }

        
        addrImage.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(12.5)
        }
        
        addrDetailLabel.snp.makeConstraints { make in
            make.left.equalTo(addrImage.snp.right).offset(7)
            make.top.equalTo(addrImage.snp.top)
        }
        
        personName.snp.makeConstraints { make in
            make.left.equalTo(addrDetailLabel.snp.left)
            make.top.equalTo(addrDetailLabel.snp.bottom).offset(6)
        }
        
        phone.snp.makeConstraints { make in
            make.left.equalTo(personName.snp.right).offset(10)
            make.centerY.equalTo(personName.snp.centerY)
        }
        
        accessImage.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.top.equalToSuperview().offset(24)
            make.width.height.equalTo(22)
        }
        line.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(personName.snp.bottom).offset(10)
            make.height.equalTo(0.5)
        }
        deliverLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalTo(baseView1.snp.bottom).offset(10)
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
    }
}
