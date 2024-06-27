//
//  CLOrderRefundAddReduceView.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/29.
//

import UIKit

class CLOrderRefundAddReduceView: UIView {
    
    var clickBlock:((_ num:Int)->())?
    var addBlock:(()->())?
    var reduceBlock:(()->())?
    
    @objc func calculate(sender:UIButton){
        if sender.tag == 1002 {
            if self.num < self.maxNum {
                self.num += 1
                self.numLabel.text = "\(self.num)"
                
                reduce.setImage(UIImage(named: "cart_icon_reduce"), for: .normal)
                
                guard let action = addBlock else { return }
                action()
                
            }else{
                guard let action = clickBlock else { return }
                action(self.maxNum)
            }
        }else{
            if self.num > 1{
                self.num -= 1
                self.numLabel.text = "\(self.num)"
                guard let action = reduceBlock else { return }
                action()
                if self.num == 1 {
                    reduce.setImage(UIImage(named: "cart_icon_reduce_disab"), for: .normal)
                }
            }
        }
    }
    
    var num:Int = 1
    var maxNum  = 0
    
    let reduce = UIButton().then{
        $0.setImage(UIImage(named: "cart_icon_reduce_disab"), for: .normal)
        $0.addTarget(self, action: #selector(calculate(sender:)), for: .touchUpInside)
        $0.tag = 1001
    }
    let add = UIButton().then{
        $0.setImage(UIImage(named: "cart_icon_plus"), for: .normal)
        $0.addTarget(self, action: #selector(calculate(sender:)), for: .touchUpInside)
        $0.tag = 1002
    }
    let numLabel = UILabel().then{
        $0.textColor = .black
        $0.font = MYFont(size: 17)
        $0.text = "1"
    }
    
    init(maxNumber:Int) {
        super.init(frame: .zero)
        self.maxNum = maxNumber
        self.configUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI() {
        self.addSubviews(views: [reduce,add,numLabel])
        
        reduce.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.height.equalTo(22)
        }
        numLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        add.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}
