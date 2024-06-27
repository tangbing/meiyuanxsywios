//
//  CLOrderRefundGoodCell.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/28.
//

import UIKit
import Kingfisher

class CLOrderRefundGoodCell: XSBaseTableViewCell {
    
    
    var model : CLOrderGoodsDetailVOList?{
        didSet {
            guard let newModel = model else { return }
            goodImage.xs_setImage(urlString: newModel.topPic)
            goodName.text = newModel.goodsName
            goodPrice.text = "￥" +  String(newModel.salePrice)
            addView.maxNum = Int(newModel.account)!
        }
    }
    
    var select: Bool = false{
        didSet{
            if select == true {
                selectedView.setImage(UIImage(named: "mine_tick_selected"), for: .normal)
            }else{
                selectedView.setImage(UIImage(named: "mine_tick_normal"), for: .normal)
            }
        }
    }
    
    
    var setCornerRatio:Bool = false {
        didSet{
            self.baseView.hg_setCornerOnBottomWithRadius(radius: 10)
        }
    }
    
    let selectedView = UIButton().then{
        $0.setImage(UIImage(named:"mine_tick_normal"), for: .normal)
        $0.isUserInteractionEnabled = false
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
        $0.text = "商品名称"
        $0.textColor = .text
        $0.font = MYBlodFont(size: 14)
    }
    
    let noticeLabel = UILabel().then{
        $0.text = "加入英特尔社区提交报名表单，表示您确认您已年满18岁"
        $0.textColor = .twoText
        $0.numberOfLines = 2
        $0.backgroundColor = .lightBackground
        $0.font = MYFont(size: 12)
        $0.layer.cornerRadius = 2

    }
    
    let goodPrice = UILabel().then{
        $0.text = "￥28.5"
        $0.textColor =  UIColor.hex(hexString: "#E61016")
        $0.font = MYBlodFont(size: 16)
    }
    
    let addView = CLOrderRefundAddReduceView.init(maxNumber:1)
    
    let goodNum = UILabel().then{
        $0.text = "x1"
        $0.textColor = .twoText
        $0.font = MYFont(size: 16)
    }
    
    override func configUI() {
        self.contentView.backgroundColor = .lightBackground
        self.selectionStyle = .none
        
        contentView.addSubview(baseView)
        self.baseView.addSubviews(views: [selectedView,goodImage,goodName,noticeLabel,goodPrice,addView])
        
        
        baseView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        goodImage.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(40)
            make.top.equalToSuperview().offset(10)
            make.width.height.equalTo(90)
        }
        
        selectedView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.centerY.equalTo(goodImage.snp.centerY)
            make.height.width.equalTo(22)
        }
        
        goodName.snp.makeConstraints { make in
            make.left.equalTo(goodImage.snp.right).offset(10)
            make.top.equalTo(goodImage.snp.top)
        }
        
        noticeLabel.snp.makeConstraints { make in
            make.left.equalTo(goodImage.snp.right).offset(10)
            make.top.equalTo(goodName.snp.bottom).offset(10)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(37)
        }
        
        goodPrice.snp.makeConstraints { make in
            make.left.equalTo(goodImage.snp.right).offset(10)
            make.bottom.equalTo(goodImage.snp.bottom)
        }
        
        addView.snp.makeConstraints { make in
            make.width.equalTo(80)
            make.height.equalTo(22)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalTo(goodImage.snp.bottom)
        }
        
    }
}
