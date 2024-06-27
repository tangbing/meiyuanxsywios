//
//  CLDeliverRefundInfoCell.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/3.
//

import UIKit

class CLDeliverRefundInfoCell: XSBaseTableViewCell {
    
    let baseView = UIView().then{
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10
    }
    
    let title = UILabel().then{
        $0.text = "退款信息"
        $0.textColor = .text
        $0.font = MYBlodFont(size: 16)
    }
    
    let refundNum    = CLMyOrderDetailReuseView()
    let refundMoney  = CLMyOrderDetailReuseView()
    let applyTime    = CLMyOrderDetailReuseView()
    let refundReason = CLMyOrderDetailReuseView()
    let foodReason   = CLMyOrderDetailReuseView()


    override func configUI() {
        self.contentView.backgroundColor = .lightBackground
        self.contentView.addSubview(baseView)
        baseView.addSubviews(views: [title,refundNum,refundMoney,applyTime,refundReason,foodReason])
        
        refundNum.setting("退款编号", "TK202020102932", false)
        refundMoney.setting("退款金额", "￥129", false)
        applyTime.setting("申请时间", "2010-01-01 17:12:55", false)
        refundReason.setting("退款原因", "食品问题", false)
        foodReason.setting("食品问题说明", "食品中出现异物", false)

        baseView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview()
        }
        
        title.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(15)
        }
        
        refundNum.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(title.snp.bottom).offset(15)
            make.height.equalTo(44)
        }
        
        refundMoney.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(refundNum.snp.bottom)
            make.height.equalTo(44)
        }
        applyTime.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(refundMoney.snp.bottom)
            make.height.equalTo(44)
        }
        refundReason.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(applyTime.snp.bottom)
            make.height.equalTo(44)
        }
        foodReason.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(refundReason.snp.bottom)
            make.height.equalTo(44)
        }
        
    }
}
