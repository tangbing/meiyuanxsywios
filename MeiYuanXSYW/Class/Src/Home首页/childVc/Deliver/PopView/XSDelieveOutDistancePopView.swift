//
//  XSDelieveOutDistancePopView.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/12/13.
//

import UIKit
import QMUIKit

class XSDelieveOutDistancePopView: TBBaseView {
    
    var changeLocationDidSelectHandler: ((_ popView: XSDelieveOutDistancePopView) -> Void)?
    
    lazy var overlayView: UIControl = {
        let control = UIControl(frame: UIScreen.main.bounds)
        control.backgroundColor = UIColor(r: 0, g: 0, b: 0, a: 0.6)
        //control.addTarget(self, action: #selector(fadeOut), for: .touchUpInside)
        control.isHidden = true
        return control
    }()
    
    var titleLab = UILabel().then {
        $0.textColor = UIColor.hex(hexString: "#B3B3B3")
        $0.text = "超出配送范围"
        $0.textAlignment = .center
        $0.font = MYFont(size: 16)
    }
   
    lazy var addressBtn: QMUIButton = {
        let btn = QMUIButton(type: .custom)
        btn.setImage(UIImage(named: "delieve_out_location"), for: .normal)
        btn.setTitle("深圳市罗湖区城市天地广场", for: .normal)
        btn.titleLabel?.font = MYFont(size: 12)
        btn.contentHorizontalAlignment = .left
        btn.setTitleColor(.twoText, for: .normal)
        btn.spacingBetweenImageAndTitle = 1
        btn.isUserInteractionEnabled = false
        btn.imagePosition = .left
        //btn.addTarget(self, action: #selector(callPhone), for: .touchUpInside)
        return btn
    }()
    
    lazy var changeAddressBtn: QMUIButton = {
        let btn = QMUIButton(type: .custom)
        btn.setImage(UIImage(named: "home_hot_arow_right"), for: .normal)
        btn.setTitle("更换收货地址", for: .normal)
        btn.titleLabel?.font = MYFont(size: 12)
        btn.setTitleColor(UIColor.hex(hexString: "#B3B3B3"), for: .normal)
        btn.spacingBetweenImageAndTitle = 0
        btn.contentHorizontalAlignment = .right
        btn.imagePosition = .right
        btn.addTarget(self, action: #selector(changeLocation), for: .touchUpInside)
        return btn
    }()
    
    let closeBtn = UIButton(type: .custom).then {
        $0.setTitle("收起", for: .normal)
        $0.setTitleColor(UIColor.hex(hexString: "#B3B3B3"), for: .normal)
        $0.addTarget(self, action: #selector(fadeOut), for: .touchUpInside)
        $0.titleLabel?.font = MYFont(size: 12)
    }
    
    // MARK: - public event
    func show(){
       
        let window = UIApplication.shared.keyWindow
        window?.addSubview(overlayView)
        window?.addSubview(self)
        self.layer.cornerRadius = 12
        self.layer.masksToBounds = true
        self.frame = CGRect(x: 0, y: screenHeight, width: screenWidth, height: intrinsicContentSize.height)
        fadeIn()
    }
    
    func fadeIn() {
     
        UIView.animate(withDuration: 0.25, delay: 0, options: UIView.AnimationOptions.curveEaseOut) {
            self.overlayView.isHidden = false
            self.frame = CGRect(x: 0, y: screenHeight - self.intrinsicContentSize.height - bottomInset, width: screenWidth, height: self.intrinsicContentSize.height)
        }
    }
    
    @objc func fadeOut() {
        UIView.animate(withDuration: 0.25, delay: 0, options: UIView.AnimationOptions.curveEaseOut) {
            self.overlayView.isHidden = true
            self.frame = CGRect(x: 0, y: screenHeight, width: screenWidth, height: self.intrinsicContentSize.height)
        } completion: { (finish) in
            self.overlayView.removeFromSuperview()
            self.removeFromSuperview()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: screenWidth, height: 80 + 52)
    }
    
    override func configUI() {
        super.configUI()
        self.backgroundColor = .white
        
        self.addSubview(titleLab)
        titleLab.snp.makeConstraints { make in
            make.height.equalTo(52)
            make.left.top.right.equalToSuperview()
        }
        
        addSubview(changeAddressBtn)
        changeAddressBtn.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(titleLab.snp_bottom).offset(15)
            make.width.equalTo(120)
        }
        
        addSubview(addressBtn)
        addressBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.centerY.equalTo(changeAddressBtn)
            make.right.equalTo(changeAddressBtn.snp_left).offset(-10)
        }
        
        addSubview(closeBtn)
        closeBtn.snp.makeConstraints { make in
            make.right.equalTo(changeAddressBtn)
            make.top.equalTo(changeAddressBtn.snp_bottom).offset(10)
        }
  
    }
    
    @objc func changeLocation() {
        self.changeLocationDidSelectHandler?(self)
    }
    
}
