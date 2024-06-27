//
//  CLMyOrderLikeCell.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/11/25.
//

import UIKit
import QMUIKit

class CLMyOrderLikeCell: XSBaseTableViewCell {
   
    var clickBlock:((_ bool1:Bool,_ boo2:Bool)->())?
    
    let goodImage = UIImageView().then{
        $0.image = UIImage(named: "test")
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 2
        $0.clipsToBounds = true
    }
    
    let goodName = UILabel().then{
        $0.text = "商品名称商品名称商品名称商品名称商品名称商品名称商品名称"
        $0.textColor = .text
        $0.font = MYFont(size: 12)
    }
    
    let dissImage = QMUIButton().then{
        $0.imagePosition = .left
        $0.setImage(UIImage(named: "down2"), for: .normal)
        $0.setTitle("踩", for: .normal)
        $0.setTitleColor(.text, for: .normal)
        $0.titleLabel?.font = MYFont(size: 12)
        $0.spacingBetweenImageAndTitle = 6
        $0.addTarget(self, action: #selector(diss), for: .touchUpInside)
        $0.setImage(UIImage(named: "down2"), for: .normal)
        $0.setImage(UIImage(named: "down"), for: .selected)
        $0.isSelected = false
    }

    let likeImage = QMUIButton().then{
        $0.imagePosition = .left
        $0.setImage(UIImage(named: "like"), for: .normal)
        $0.setTitle("赞", for: .normal)
        $0.setTitleColor(.text, for: .normal)
        $0.titleLabel?.font = MYFont(size: 12)
        $0.spacingBetweenImageAndTitle = 6
        $0.addTarget(self, action: #selector(like), for: .touchUpInside)
        $0.setImage(UIImage(named: "like"), for: .normal)
        $0.setImage(UIImage(named: "clickon_like"), for: .selected)
        $0.isSelected = false
    }
    
    @objc func diss(){
        if likeImage.isSelected == true {
            likeImage.isSelected = false
        }
 
        dissImage.isSelected = !dissImage.isSelected
        
        guard let action = clickBlock else {
            return
        }
        action(likeImage.isSelected,dissImage.isSelected)
    }
    
    @objc func like(){
        if dissImage.isSelected == true {
            dissImage.isSelected = false
        }
        
        likeImage.isSelected = !likeImage.isSelected
        
        guard let action = clickBlock else {
            return
        }
        action(likeImage.isSelected,dissImage.isSelected)
    }
    override func configUI() {
        contentView.backgroundColor = .lightBackground
        contentView.addSubviews(views: [goodImage,goodName,dissImage,likeImage])
        
        goodImage.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(15)
            make.width.equalTo(30)
            make.height.equalTo(23)
        }

        likeImage.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20)
            make.centerY.equalTo(goodImage.snp.centerY)
            make.width.equalTo(40)
            make.height.equalTo(20)
        }
        dissImage.snp.makeConstraints { make in
            make.right.equalTo(likeImage.snp.left).offset(-20)
            make.centerY.equalTo(goodImage.snp.centerY)
            make.width.equalTo(40)
            make.height.equalTo(20)
        }
        
        goodName.snp.makeConstraints { make in
            make.left.equalTo(goodImage.snp.right).offset(10)
            make.centerY.equalTo(goodImage.snp.centerY)
            make.right.equalTo(dissImage.snp.left).offset(-10)
        }
        
    }
}
