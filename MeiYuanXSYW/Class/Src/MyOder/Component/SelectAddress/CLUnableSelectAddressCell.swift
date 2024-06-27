//
//  CLUnableSelectAddressCell.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/11/29.
//

import UIKit

class CLUnableSelectAddressCell: XSBaseTableViewCell {
    
    var model:CLOrderSelectAddrModel?{
        didSet{
            guard let cellModel  = model else {return}
            title.text = cellModel.receiverDetailAddress
            personInfo.text = "\(cellModel.receiverName)  \(cellModel.receiverSex == 0 ? "男性":"女性")   \(cellModel.receiverPhone)"
        }
    }
    
    let title = UILabel().then{
        $0.text = "城市天地广场"
        $0.textColor = .fourText
        $0.font = MYBlodFont(size: 14)
    }
    
    let personInfo = UILabel().then{
        $0.text = "小黑   女士   131 1453 2587"
        $0.textColor = .fourText
        $0.font = MYFont(size: 12)
    }
    
    let editButton = UIButton().then{
        $0.setImage(UIImage(named: "payAddress_edit_icon"), for: .normal)
    }
    
    let line = UIView().then{
        $0.backgroundColor =  UIColor.qmui_color(withHexString: "#DCDEE0")!
    }

    override func configUI() {
        
        self.contentView.addSubviews(views: [title,personInfo,editButton,line])
 
        title.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(45)
            make.top.equalToSuperview().offset(10)
        }
        
        personInfo.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(45)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        editButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(20)
        }
        
        line.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(editButton.snp.bottom).offset(20)
            make.height.equalTo(0.5)
        }
    }


}
