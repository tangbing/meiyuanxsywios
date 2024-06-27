//
//  XSHomeHeaderSecondTableViewCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/9/24.
//

import UIKit
import QMUIKit
import SwiftUI

class XSHomeHeaderSecondTableViewCell: XSBaseXIBTableViewCell {
    
    var clickLeftMoreViewHandler: (() -> Void)?
    var clickRightMoreViewHandler: (() -> Void)?
    var killSecondStartHandler:(() -> Void)?
    
    
    var countDown: Int = 0
    
    var freeCouponVos: [FreeCouponVoData] = []  {
        didSet {
            if freeCouponVos.count <= 0 {
                return
            }
            
            if freeCouponVos.count == 1 {
                let free = freeCouponVos[0]
                rightView_requirLab.text = "满\(free.fullReductionAmount)元可用"
                rightView_reducePriceLab1.text = "¥\(free.discountAmount)"
                
            } else if(freeCouponVos.count == 2) {
                let free = freeCouponVos[0]
                rightView_requirLab.text = "满\(free.fullReductionAmount)元可用"
                rightView_reducePriceLab1.text = "¥\(free.discountAmount)"

                let free2 = freeCouponVos[1]
                rightView_requirLab2.text = "满\(free2.fullReductionAmount)元可用"
                rightView_reducePriceLab2.text = "¥\(free2.discountAmount)"

            } else {
                let free = freeCouponVos[0]
                rightView_requirLab.text = "满\(free.fullReductionAmount)元可用"
                rightView_reducePriceLab1.text = "¥\(free.discountAmount)"

                
                let free2 = freeCouponVos[1]
                rightView_requirLab2.text = "满\(free2.fullReductionAmount)元可用"
                rightView_reducePriceLab2.text = "¥\(free2.discountAmount)"

                
                let free3 = freeCouponVos[2]
                rightView_requirLab3.text = "满\(free3.fullReductionAmount)元可用"
                rightView_reducePriceLab3.text = "¥\(free3.discountAmount)"

            }
        }
    }
    
    var secondTicketModel: SecKillHomePageVo? {
        didSet {
            guard let secondTicket = secondTicketModel else { return }
            
            if secondTicket.countDown > 0 {
                
//                let hour = secondTicket.countDown / 3600
//                let minute = secondTicket.countDown / 60
//                let second = secondTicket.countDown % 60
                
                let tiemStr = Date.jk.getFormatPlayTime(seconds: secondTicket.countDown, type: .hour)
                let times = tiemStr.components(separatedBy: ":")

                leftView_hourLab.text = times[0]
                leftView_minuteLab.text = times[1]
                leftView_secondLab.text = times[2]
                
                
                // 开启定时器秒杀哦
                self.countDown = secondTicket.countDown
                startSecondKill(countDown: secondTicket.countDown)
            }
            
            secondKillGoodsModel = secondTicket.secKillGoodsVos

            
            
  
        }
    }
    
    var secondKillGoodsModel :[SecKillGoodsVos]? {
        didSet {
            guard let goods = secondKillGoodsModel else { return }
            
            if let goodsModel = goods.last {
                
                leftView_goodsIcon.xs_setImage(urlString: goodsModel.merchantLogo, placeholder: UIImage.bannerPlaceholder)
                leftView_goodsName.text = goodsModel.goodsName
                leftView_finalPrice.text = "¥\(goodsModel.seckillPrice)"
                leftView_originPrice.text = "¥\(goodsModel.originalPrice)"
                leftView_originPrice.jk.setSpecificTextDeleteLine("¥\(goodsModel.originalPrice)", color: UIColor.hex(hexString: "BBBBBB"))
                /// 0:外卖;1:团购;2:私厨
                var signal = "外卖"
                if goodsModel.goodsType == 1 {
                    signal = "团购"
                } else if(goodsModel.goodsType == 2) {
                    signal = "私厨"
                }
                leftView_signalLab.text = signal
            }

        }
    }
    
    
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var leftView_iconImageView: UIView!
    @IBOutlet weak var leftView_secondTypeSignalLael: UILabel!
    
    @IBOutlet weak var leftView_goodsIcon: UIImageView!
    @IBOutlet weak var leftView_goodsName: UILabel!
    @IBOutlet weak var leftView_finalPrice: UILabel!
    
    @IBOutlet weak var leftView_originPrice: UILabel!
    
    @IBOutlet weak var leftView_signalLab: UILabel!
    
    @IBOutlet weak var leftView_hourLab: QMUILabel!
    @IBOutlet weak var leftView_minuteLab: QMUILabel!
    @IBOutlet weak var leftView_secondLab: QMUILabel!
    

    @IBOutlet weak var rightView: UIView!
    
    
    @IBOutlet weak var rightView_reducePriceLab1: UILabel!
    @IBOutlet weak var rightView_reducePriceLab2: UILabel!
    @IBOutlet weak var rightView_reducePriceLab3: UILabel!
    
    @IBOutlet weak var rightView_requirLab: UILabel!
    @IBOutlet weak var rightView_requirLab2: UILabel!
    @IBOutlet weak var rightView_requirLab3: UILabel!

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        NotificationCenter.default.addObserver(self, selector: #selector(self.countDownNotification), name: .CLCountDownNotification, object: nil)
        
        leftView.jk.addGestureTap { TapGesture in
            if let sourceVc = topVC {
                let second = TBHomeSecondViewController(killSecondStyle: .homeDefault)
                sourceVc.navigationController?.pushViewController(second, animated: true)
                
            }
        }
        
        rightView.jk.addGestureTap { TapGesture in
            guard let rightViewMoreBlock = self.clickRightMoreViewHandler else {
                return
            }
            rightViewMoreBlock()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        leftView.hg_setAllCornerWithCornerRadius(radius: 10)
        rightView.hg_setAllCornerWithCornerRadius(radius: 10)
        leftView_secondTypeSignalLael.jk.addCorner(conrners: [.topRight], radius: 4)
    }
    
    @IBAction func leftViewMoreBtnClick(_ sender: UIButton) {
        guard let leftViewMoreBlock = clickLeftMoreViewHandler else {
            return
        }
        leftViewMoreBlock()
    }
    
    @IBAction func rightViewMoreBtnClick(_ sender: UIButton) {
        guard let rightViewMoreBlock = clickRightMoreViewHandler else {
            return
        }
        rightViewMoreBlock()
    }
    
    @objc private func countDownNotification() {
        // 计算倒计时
        let timeInterval: Int
        timeInterval = CLCountDownManager.sharedManager.timeIntervalWithIdentifier(identifier:"HomeStartSecondKill")
        let countDown = self.countDown - timeInterval
        // 当倒计时到了进行回调
        if (countDown <= 0) {
            
            // 活动开始
            guard let handler = killSecondStartHandler else {
                return
            }
            handler()
            uLog(" handler()")
            
        }else{
            // 重新赋值
            let tiemStr = Date.jk.getFormatPlayTime(seconds: countDown, type: .hour)
            let times = tiemStr.components(separatedBy: ":")

            leftView_hourLab.text = times[0]
            leftView_minuteLab.text = times[1]
            leftView_secondLab.text = times[2]
           
        }
    }
    
    
    func startSecondKill(countDown: Int) {
        
        if countDown < 0 { // 不启用定时器
            return
        }
        CLCountDownManager.sharedManager.start()
        CLCountDownManager.sharedManager.addSourceWithIdentifier(identifier: "HomeStartSecondKill")
        uLog(CLCountDownManager.sharedManager.timeIntervalDict)
        

    }

}
