//
//  CLMyOrderGroupBuyVoucherInfoCell.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/2.
//

import UIKit
import Kingfisher

class CLMyOrderGroupBuyVoucherInfoCell: XSBaseTableViewCell {
    
    var model:CLOrderGoodsDetailVOList?{
        didSet{
            guard let newModel = model else { return }
            goodName.text = newModel.goodsName
            goodImage.xs_setImage(urlString: newModel.topPic)
            useImage.isHidden = true
            codeImage.xs_setImage(urlString: newModel.voucherCodePic)
        }
    }
    
    let baseView = UIView().then{
        $0.backgroundColor = .white
    }
    
    let goodImage = UIImageView().then{
        $0.image = UIImage(named: "test")
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 5
        $0.clipsToBounds = true
    }

    let goodName = UILabel().then{
        $0.text = "菜品名称"
        $0.textColor = .text
        $0.font = MYBlodFont(size: 14)
    }
    
    let endTime = UILabel().then{
        $0.text = "2021-12-01 23.59到期"
        $0.textColor = .twoText
        $0.font = MYFont(size: 12)
    }
        
    let voucherName = UILabel().then{
        $0.text = "劵1"
        $0.textColor = .twoText
        $0.font = MYBlodFont(size: 15)
    }
    
    let voucherNum = UILabel().then{
        $0.textColor = .twoText
        $0.text = "0987 6543 4345"
        $0.font = MYFont(size: 15)
    }
    
    let line = UIView().then{
        $0.backgroundColor = .twoText
    }
    
    let voucherImage = UIView().then{
        $0.backgroundColor = UIColor.qmui_color(withHexString: "#F6F6F6")
        $0.layer.cornerRadius = 2
        $0.clipsToBounds = true
    }
    
    let codeImage = UIImageView()
    
    let useImage = UIImageView().then{
        $0.image = UIImage(named: "used")
        $0.backgroundColor = .clear
    }
    
    let orderTime = UILabel().then{
        $0.text = "2021-12-01 23.59到期"
        $0.textColor = .twoText
    }
    
    
    let refundButton = UIButton().then{
        $0.backgroundColor = UIColor.qmui_color(withHexString: "#FFF3F3")
        $0.setTitle("售后", for: .normal)
        $0.setTitleColor(UIColor.qmui_color(withHexString: "#E61016"), for: .normal)
        $0.titleLabel?.font = MYFont(size: 13)
        $0.layer.cornerRadius  = 10
    }
    
    override func configUI() {
        contentView.backgroundColor = .lightBackground
        self.selectionStyle = .none
        contentView.addSubview(baseView)
        baseView.addSubviews(views: [goodImage,goodName,endTime,voucherName,voucherNum,line,voucherImage,codeImage,useImage,orderTime,refundButton])
        
        voucherImage.addSubview(codeImage)
        
        baseView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.bottom.equalToSuperview()
        }
        
        goodImage.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(10)
            make.height.width.equalTo(90)
        }
        
        goodName.snp.makeConstraints { make in
            make.left.equalTo(goodImage.snp.right).offset(10)
            make.top.equalTo(goodImage.snp.top)
        }
        
        endTime.snp.makeConstraints { make in
            make.left.equalTo(goodImage.snp.right).offset(10)
            make.top.equalTo(goodName.snp.bottom).offset(10)
        }
        
        voucherName.snp.makeConstraints { make in
            make.left.equalTo(goodImage.snp.right).offset(10)
            make.top.equalTo(endTime.snp.bottom).offset(10)
        }
        
        voucherNum.snp.makeConstraints { make in
            make.left.equalTo(voucherName.snp.right).offset(10)
            make.centerY.equalTo(voucherName.snp.centerY)
        }
        
        line.snp.makeConstraints { make in
            make.left.equalTo(voucherNum.snp.left)
            make.centerY.equalTo(voucherNum.snp.centerY)
            make.height.equalTo(0.5)
            make.right.equalTo(voucherNum.snp.right)
        }
        
        voucherImage.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalTo(goodImage.snp.bottom)
            make.width.height.equalTo(60)
        }
        
        codeImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(45)
        }
        
        useImage.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalTo(goodImage.snp.bottom)
            make.width.height.equalTo(60)
        }
        
        refundButton.snp.makeConstraints { make in
            make.top.equalTo(goodName.snp.top)
            make.right.equalToSuperview().offset(-10)
            make.width.equalTo(60)
            make.height.equalTo(20)
        }
        
    }
}
