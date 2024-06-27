//
//  CLTakeMealCodeView.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/11/26.
//

import UIKit

class CLTakeMealCodeView: XSBaseViewController {
    
    let takeCode = UILabel().then{
        $0.text = "4950"
        $0.textColor = .king
        $0.font = MYFont(size: 30)
    }
    
    let closeButton = UIButton().then{
        $0.setImage(UIImage(named: "merchinfo_ticket_closure"), for: .normal)
        $0.addTarget(self, action: #selector(close), for: .touchUpInside)
    }
    @objc func close(){
        self.dismiss(animated: true, completion: nil)
    }
    
    let takeCodeLabel = UILabel().then{
        $0.text = "取餐码"
        $0.textColor = .fourText
        $0.font = MYFont(size: 14)
    }
    
    let codeView = UIImageView().then{
        $0.backgroundColor = .lightBackground
    }
    
    let desLabel = UILabel().then{
        $0.text = "凭此取餐码取餐"
        $0.textColor = .fourText
        $0.font = MYFont(size: 12)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configUI()
    }
    
    func configUI() {
        self.view.backgroundColor = .white
        self.view.addSubviews(views: [takeCode,closeButton,takeCodeLabel,codeView,desLabel])
        
        codeView.image = UIImage.generateQRCode("这是一个二维码链接",160,nil,.text)

        takeCode.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.centerX.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-15)
            make.top.equalToSuperview().offset(15)
        }
        
        takeCodeLabel.snp.makeConstraints { make in
            make.top.equalTo(takeCode.snp.bottom)
            make.centerX.equalToSuperview()
        }
        
        codeView.snp.makeConstraints { make in
            make.top.equalTo(takeCodeLabel.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(160)
        }
        
        desLabel.snp.makeConstraints { make in
            make.top.equalTo(codeView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
    }

}
