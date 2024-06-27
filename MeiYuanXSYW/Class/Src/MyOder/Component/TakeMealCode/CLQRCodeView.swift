//
//  CLQRCodeView.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/11/26.
//

import UIKit

class CLQRCodeView: TBBaseView {
    var icon :UIImage?
    func creatErcode(_ url:String){
        let img = CLQRCodeTool.creatQRCodeImage(text: url, size: 160, icon: nil)
        ercodeBtn.setImage(img, for: UIControl.State.normal)
    }
    
    func creatErcodeWithIcon(_ url:String,_ icon:UIImage){
         let img = CLQRCodeTool.creatQRCodeImage(text: url, size: 160, icon: icon)
         ercodeBtn.setImage(img, for: UIControl.State.normal)
     }
    
    func creatReceiveErcode(_ shopId:String ,_ icon:UIImage){
        let url = "UITOKEN://" + shopId
        let img = CLQRCodeTool.creatQRCodeImage(text: url, size: 160, icon: icon)
        ercodeBtn.setImage(img, for: .normal)
    }
    
    let ercodeBtn = UIButton()
    
    override func configUI() {
        
        addSubview(ercodeBtn)
        
        ercodeBtn.snp.makeConstraints { (make) in
            make.left.right.bottom.top.equalToSuperview()
        }
    }
    
}
