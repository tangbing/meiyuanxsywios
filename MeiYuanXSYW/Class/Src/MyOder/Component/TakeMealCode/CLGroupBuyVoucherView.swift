//
//  CLGroupBuyVoucherView.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/7.
//

import UIKit
import Kingfisher

class CLGroupBuyVoucherView: XSBaseViewController {
    
    let voucherLabel = UILabel().then{
        $0.text = "卷码:"
        $0.textColor = .twoText
        $0.font = MYFont(size: 14)
    }
    
    let closeButton = UIButton().then{
        $0.setImage(UIImage(named: "merchinfo_ticket_closure"), for: .normal)
        $0.addTarget(self, action: #selector(close), for: .touchUpInside)
    }
    @objc func close(){
        self.dismiss(animated: true, completion: nil)
    }
    
    let voucherNum = UILabel().then{
        $0.text = "1709 0087 7657"
        $0.textColor = UIColor.qmui_color(withHexString: "#DDA877")
        $0.font = MYFont(size: 27)
    }
    
    let qrcodeView = UIImageView().then{
        $0.backgroundColor = .white
    }
    
    let codeView = UIImageView()
    
    override func initSubviews() {
        super.initSubviews()
        
        self.view.addSubviews(views: [voucherLabel,voucherNum,closeButton,qrcodeView,codeView])
        
        qrcodeView.image = UIImage.generateQRCode("这是一个二维码链接",160,nil,.text)
        
        codeView.image = UIImage.generateCode128("420182301823823", CGSize(width: 185 , height: 50 ), .text)
        
        closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        
        UIView.animate(withDuration: 0) {
            self.codeView.transform = CGAffineTransform(rotationAngle: CGFloat.pi/2).inverted()
        }

        
        voucherLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(27)
            make.top.equalToSuperview().offset(33)
        }
        
        closeButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-15)
            make.top.equalToSuperview().offset(15)
            make.width.height.equalTo(20)
        }
        
        voucherNum.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(27)
            make.top.equalTo(voucherLabel.snp.bottom).offset(5)
        }
        
        qrcodeView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(27)
            make.top.equalTo(voucherNum.snp.bottom).offset(10)
            make.height.width.equalTo(185)
        }
        
        codeView.snp.makeConstraints { make in
            make.centerY.equalTo(qrcodeView.snp.centerY)
            make.left.equalTo(qrcodeView.snp.right).offset(-(185/2 - 55 + 10))
            make.width.equalTo(185 + 20)
            make.height.equalTo(50 + 20)
        }
    }
}
