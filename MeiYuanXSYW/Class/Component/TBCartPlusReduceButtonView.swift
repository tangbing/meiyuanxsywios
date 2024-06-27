//
//  TBCartPlusReduceButtonView.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/24.
//

import UIKit

class TBCartPlusReduceButtonView: UIView {
    
    /// 购买数量等于0的回调
    var buyNumZeroBlock: ((_ bottom: TBCartPlusReduceButtonView) -> Void)?
    /// ++的回调
    var plusBtnClickHandler: ((_ bottom: TBCartPlusReduceButtonView) -> Void)?
    /// --的回调
    var reduceBtnClickHandler: ((_ bottom: TBCartPlusReduceButtonView) -> Void)?
    
    var buyNum : UInt = 1 {
        didSet {
            buyNumLabel.text = "\(buyNum)"
        }
    }
    
    lazy var plusButton: UIButton = {
        let plus = UIButton(type: .custom)
        plus.setImage(UIImage(named: "cart_icon_plus"), for: .normal)
        plus.setImage(UIImage(named: "cart_icon_reduce_disab"), for: .disabled)
        plus.addTarget(self, action: #selector(plusBtnClick), for: .touchUpInside)
        return plus
    }()
    
    lazy var reduceButton: UIButton = {
        let reduce = UIButton(type: .custom)
        reduce.setImage(UIImage(named: "cart_icon_reduce"), for: .normal)
        //reduce.setImage(UIImage(named: "cart_icon_reduce_disab"), for: .disabled)
        reduce.addTarget(self, action: #selector(reduceBtnClick(reduceButton:)), for: .touchUpInside)
        return reduce
    }()
    
    lazy var buyNumLabel: UILabel = {
        let labl = UILabel()
        labl.textColor = .black
        labl.font = MYFont(size: 17)
        labl.text = "1"
        return labl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        self.addSubview(plusButton)
        plusButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.top.bottom.equalToSuperview()
            make.size.equalTo(CGSize(width: 22, height: 22))
        }
        
        self.addSubview(buyNumLabel)
        buyNumLabel.snp.makeConstraints { make in
            make.right.equalTo(plusButton.snp_left).offset(-10)
            make.centerY.equalToSuperview()
        }
        
        self.addSubview(reduceButton)
        reduceButton.snp.makeConstraints { make in
            make.right.equalTo(buyNumLabel.snp_left).offset(-10)
            make.top.bottom.equalToSuperview()
            make.size.equalTo(CGSize(width: 22, height: 22))
            make.left.equalToSuperview().offset(10)
        }
    }
    
    @objc func plusBtnClick(plusButton: UIButton) {
//        buyNum += 1
//        buyNumLabel.text = "\(buyNum)"
        
        guard let clickHandler = plusBtnClickHandler else {
            uLog("plusBtnClickHandler nil")
            return
        }
        clickHandler(self)
        
    }
    
    @objc func reduceBtnClick(reduceButton: UIButton) {
        guard let clickHandler = reduceBtnClickHandler else {
            uLog("reduceBtnClickHandler nil")
           return
        }
        clickHandler(self)

        
//        if buyNum > 0 {
//            buyNumLabel.text = "\(buyNum)"
//
//        } else { // 购买数量为0的情况，弹出删除确认弹框，
//            buyNum += 1
//            self.buyNumZeroBlock?(self)
//        }
    }
}
