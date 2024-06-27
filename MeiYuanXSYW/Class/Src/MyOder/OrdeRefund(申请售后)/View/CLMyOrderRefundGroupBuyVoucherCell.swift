//
//  CLMyOrderRefundGroupBuyVoucherCell.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/2.
//

import UIKit

class CLMyOrderRefundGroupBuyVoucherCell: XSBaseTableViewCell {

    var select: Bool = false{
        didSet{
            if select == true {
                selectedView.setImage(UIImage(named: "mine_tick_selected"), for: .normal)
            }else{
                selectedView.setImage(UIImage(named: "mine_tick_normal"), for: .normal)
            }
        }
    }
    
    let baseview = UIView().then{
        $0.backgroundColor = .white
        $0.isUserInteractionEnabled = true

    }
    
    let selectedView = UIButton().then{
        $0.setImage(UIImage(named:"mine_tick_normal"), for: .normal)
        $0.isUserInteractionEnabled = false
    }
    
    
    let voucherImage = UIImageView().then{
        $0.image = UIImage(named: "test")
        $0.layer.cornerRadius = 5
    }
    
    let voucherName = UILabel().then{
        $0.text = "劵1"
        $0.textColor = .text
        $0.font = MYBlodFont(size: 16)
    }
    
    let voucherNum = UILabel().then{
        $0.textColor = .twoText
        $0.text = "0987 6543 4345"
        $0.font = MYFont(size: 16)
    }
    
    let line = UIView().then{
        $0.backgroundColor = .twoText
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: true)
    }
    

    
    override func configUI() {
        contentView.backgroundColor = .lightBackground
        self.selectionStyle = .none
        
        contentView.addSubview(baseview)
        baseview.addSubviews(views: [selectedView,voucherImage,voucherName,voucherNum,line])
        
        baseview.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.bottom.equalToSuperview()
        }
        
        voucherImage.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(41)
            make.bottom.equalToSuperview()
            make.width.height.equalTo(65)
        }
        
        selectedView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(9)
            make.centerY.equalTo(voucherImage.snp.centerY)
            make.height.width.equalTo(22)
        }
        
        voucherName.snp.makeConstraints { make in
            make.left.equalTo(voucherImage.snp.right).offset(15)
            make.centerY.equalTo(voucherImage.snp.centerY)
        }
        
        voucherNum.snp.makeConstraints { make in
            make.left.equalTo(voucherName.snp.right).offset(10)
            make.centerY.equalTo(voucherName.snp.centerY)
        }
        
    }
    
}
