//
//  CLOrderDetailTopView.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/11/23.
//

import UIKit
import Kingfisher

class CLMyOrderDetailTopView: TBBaseView {
    
    var clickBlock:(()->())?
    
    let baseView  = UIView()
    
    let back = UIButton().then{
        $0.setImage(UIImage(named: "return_white"), for: .normal)
        $0.addTarget(self, action: #selector(click), for: .touchUpInside)
    }

    let backLabel = UILabel().then{
        $0.text = "订单详情"
        $0.textColor = .white
        $0.font = MYFont(size: 18)
    }
    
    let statusLabel = UILabel().then{
        $0.text = "待支付"
        $0.textColor  = .white
        $0.font = MYFont(size: 16)
    }
    
    let desLabel = UILabel().then{
        $0.text = "支付剩余时间29分59秒"
        $0.textColor = .white
        $0.font = MYFont(size: 12)
    }
    
    let image = UIImageView().then{
        $0.image = UIImage(named: "wallet")
    }
    
    func setting(_ status:String,_ des:String,_ image:String = "wallet"){
        self.statusLabel.text = status
        self.desLabel.text = des
        self.image.image = UIImage(named: image)
    }
    
    @objc func click(){
        guard let action = clickBlock else {return}
        action()
    }

 
    override func configUI() {
        self.addSubview(baseView)
        baseView.addSubviews(views: [back,backLabel,image,statusLabel,desLabel])
        baseView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(145 + LL_StatusBarExtraHeight)
        }
        
        back.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(30 + LL_StatusBarExtraHeight)
            make.width.height.equalTo(24)
        }
        
        backLabel.snp.makeConstraints { make in
            make.left.equalTo(back.snp.right)
            make.centerY.equalTo(back.snp.centerY)
        }
        
        image.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-25)
            make.bottom.equalToSuperview().offset(-25)
            make.width.height.equalTo(45)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.left.equalTo(backLabel.snp.left)
            make.top.equalTo(image.snp.top)
        }
        
        desLabel.snp.makeConstraints { make in
            make.left.equalTo(statusLabel.snp.left)
            make.bottom.equalTo(image.snp.bottom)
        }
    }
}
