//
//  CLMyOrderStatusSelectView.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/11/29.
//

import UIKit
import Kingfisher

enum CLMyOrderShopType {
    case deliver(status:deliverOrderStatus,title:String)
    case groupBuy(status:groupBuyOrderStatus,title:String)
    case privateKitchen(status:privateKitchenOrderStatus,title:String)
    case member(type:String)
    case allType(status:String)
}

class CLMyOrderStatusSelectView: UIView {

    var clickEvent:((_ title:String)->())?
    //status = 0
    var statusType:CLMyOrderShopType = .deliver(status:.waitPay,title:""){
        didSet {
            let titleArr =  getActionTitle(statusType)
            self.configUI(titleArr)
        }
    }
    
    func  getActionTitle(_ type:CLMyOrderShopType) -> [String]{
        switch type {
        case .deliver(let status,_):
            switch status {
            case .waitPay:
                return ["支付","取消订单","修改地址"]
            case .waitMerchantReceiverOrder:
                return ["催单","取消订单","修改地址"]
            case .waitRiderReceiverOrder:
                return ["催单","取消订单","修改地址"]
            case .merchentPrepareMeal:
                return ["催单","取消订单","修改地址"]
            case .waitUserTakeMeal:
                return ["取消订单","修改地址"]
            case .riderDeliver:
                return ["取消订单"]
            case .merchantDeliver:
                return ["取消订单"]
            case .waitComment:
                return ["评价","再来一单","申请售后"]
            case .orderFinish1:
                return ["评价","再来一单","删除订单"]
            case .orderFinish2:
                return ["再来一单","删除订单"]
            case .refundReview:
                return ["再来一单","退款进度"]
            case .refunding:
                return ["再来一单","退款进度"]
            case .refundSuccess:
                return ["再来一单","退款进度","删除订单"]
            case .refundReject:
                return ["重新申请","退款进度","删除订单"]
            case .orderClose:
                return ["再来一单","删除订单"]
            case .waitTakeMeal:
                return ["取餐码","取消订单"]
            }
        case .groupBuy(let status,_):
            switch status {
            case .waitPay:
                return ["支付","取消订单"]
            case .orderFinish1:
                return ["评价","再来一单","删除订单"]
            case .orderFinish2:
                return ["再来一单","删除订单"]
            case .refundReview:
                return ["退款进度","再来一单"]
            case .refunding:
                return ["再来一单","退款进度"]
            case .refundSuccess:
                return ["再来一单","退款进度","删除订单"]
            case .refundReject:
                return ["重新申请","退款进度","删除订单"]
            case .orderClose:
                return ["再来一单","删除订单"]
            case .waitUse:
                return ["查看券码","再来一单"]
            case .waitComment:
                return ["评价","再来一单","申请售后"]
            }
        case .privateKitchen(let status,_):
            if status == .waitPay {
                return ["支付","取消订单","修改预约信息"]
            }else if status == .waitAppointment{
                return ["预约","取消订单"]
            }else if status == .DoorToDoorService{
                return ["取消订单"]
            }else if status == .inservice{
                return ["再来一单"]
            }else if status == .waitComment{
                return ["评价","再来一单","申请售后"]
            }else if status == .orderFinish1{
                return ["评价","再来一单","删除订单"]
            }else if status == .orderFinish2{
                return ["再来一单","删除订单"]
            }else if status == .refundReview{
                return ["再来一单"]
            }else if status == .refunding{
                return ["再来一单"]
            }else if status == .refundSuccess{
                return ["再来一单","删除订单"]
            }else if status == .refundReject{
                return ["重新申请","删除订单"]
            }else if status == .orderClose{
                return ["再来一单","删除订单"]
            }
            uLog("私厨")
            return []

        case .member(let type):
            if type == "会员卡" {
                return ["再来一单","删除订单"]
            }else if type == "加量包"{
                return ["再来一单","删除订单"]
            }
            uLog("会员卡")

        case .allType(status: let status):
            if status == "待支付" {
                return ["合并支付","取消订单","删除订单"]
            }else if status == "已关闭"{
                return ["再来一单","删除订单"]
            }
        }
        return []
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

    }
    
    
    @objc func click(sender:UIButton){
        guard let action = self.clickEvent else { return }
        action(sender.currentTitle ?? "")
    }
    
    func configUI(_ titleArr:[String]){
        
        self.subviews.forEach {$0.removeFromSuperview()}

        for i in 0 ..< titleArr.count {
            let button = UIButton.init(type: .custom)
            button.setTitle(titleArr[i], for: .normal)
            button.titleLabel?.font = MYFont(size: 14)
            button.hg_setAllCornerWithCornerRadius(radius: 16)
            button.addTarget(self, action: #selector(click(sender:)), for: .touchUpInside)
            self.addSubview(button)
            
            button.snp.makeConstraints { make in
                make.right.equalToSuperview().offset(-(88 + 10)*i)
                make.top.equalToSuperview()
                make.width.equalTo(88 + (titleArr[i] == "修改预约信息" ? 25:0))
                make.height.equalTo(32)
            
            }
            
            if titleArr[i] == "支付" || titleArr[i] == "催单" || titleArr[i] == "再来一单" || titleArr[i] == "重新申请" || titleArr[i] == "取餐码" || titleArr[i] == "预约" || titleArr[i] == "合并支付"{
                button.setBackgroundImage(UIImage(named: "cartBackImg"), for: .normal)
                button.setTitleColor(.white, for: .normal)
            }else{
                button.setTitleColor(.twoText, for: .normal)
                button.layer.borderWidth = 0.5
                button.layer.borderColor = UIColor.twoText.cgColor
            }
            
            
        }
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
