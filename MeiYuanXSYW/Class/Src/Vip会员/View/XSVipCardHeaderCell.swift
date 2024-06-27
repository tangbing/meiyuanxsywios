//
//  XSVipCardHeaderCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/8/19.
//

import UIKit
import QMUIKit
/// 添加cell点击代理方法
protocol XSVipCardHeaderCellDelegate:NSObjectProtocol {
    func clickUserName()
}
class XSVipCardHeaderCell: XSBaseTableViewCell {
    weak var delegate : XSVipCardHeaderCellDelegate?
    
    var buyBlock:(()->())?

    var model:CLMemberCardInfoModel? {
        didSet {
            guard let newModel = model else { return }
            userView.userStackView.userName.text =  newModel.userMobile
            userView.userStackView.userNameTipLab.text = "有效期：\(newModel.memberBeginDate.components(separatedBy: " ").first ?? "")-\(newModel.timeoutDate.components(separatedBy: " ").first ?? "")"
//            topImgView.xs_setImage(urlString: newModel.headImg)
            userView.userImgView.xs_setImage(urlString: newModel.headImg)
            numLab.isHidden = true
            buyBtn.isHidden = true
        }
    }

    var myModel:CLMyMemberCardModel? {
        didSet {
            guard let newModel = myModel else { return }
            
            userView.userStackView.userName.text =  newModel.userMobile
            userView.userStackView.userNameTipLab.text = "有效期：\(newModel.memberBeginDate.components(separatedBy: " ").first ?? "")-\(newModel.timeoutDate.components(separatedBy: " ").first ?? "")"

            numLab.text = "本月已省\(newModel.monthDiscountAmt)元"
            numLab.jk.setsetSpecificTextFont(newModel.monthDiscountAmt, font:MYBlodFont(size: 22))
            numLab.jk.setsetSpecificTextFont("元", font:MYFont(size: 16))
            
            buyButton.isHidden = true
            
            if newModel.memberStatus == 1 {
                buyBtn.setTitle("生效中", for: .normal)
            }else{
                buyBtn.setTitle("非会员", for: .normal)
            }
        }
    }
    
    var backView : UIView={
        let backView = UIView()
        backView.backgroundColor = .vipHader
//        backView.hg_setAllCornerWithCornerRadius(radius: 6)
        return backView
    }()
    var topBackView : UIView={
        let topBackView = UIView()
        topBackView.hg_setCornerOnTopWithRadius(radius: 5)
        return topBackView
    }()
    var topImgView : UIImageView={
        let topImgView = UIImageView()
        topImgView.image = UIImage(named: "vip_member_bg")
        topImgView.contentMode = .scaleAspectFill
        topImgView.clipsToBounds = true
        return topImgView
    }()
    //用户头像加用户名
    var userView:XSUserView={
        let userView = XSUserView()
        userView.userStackView.userName.font = MYBlodFont(size: 18)
        userView.userStackView.userNameTipLab.font = MYFont(size: 10)
        return userView
    }()
    
    
    var buyButton = UIButton().then{
        $0.setTitle("购买记录", for: .normal)
        $0.setTitleColor(UIColor.qmui_color(withHexString: "#FFD0A1"), for: .normal)
        $0.titleLabel?.font = MYFont(size: 13)
    }
    
    
    var buyBtn : UIButton={
        let buyBtn = UIButton()
        buyBtn.titleLabel?.font = MYFont(size: 13)
        buyBtn.setTitle("生效中", for: UIControl.State.normal)
        buyBtn.setTitleColor(.tag, for: UIControl.State.normal)
        buyBtn.jk.addBorder(borderWidth: 1, borderColor: .tag)
        buyBtn.hg_setAllCornerWithCornerRadius(radius: 5)
        return buyBtn
    }()
        
    ///本月已省
    let numLab : UILabel={
        let numLab = UILabel()
        numLab.textColor = UIColor.hex(hexString: "#FFD0A1")
        numLab.font = MYFont(size: 12)
        return numLab
    }()


    
    var dataSource = [Any]()
    
    @objc func clickBuyLog(){
        guard let action = self.buyBlock else { return }
        action()
    }
    
    override func configUI() {

        contentView.backgroundColor = .background
        contentView.addSubview(backView)
        backView.snp.makeConstraints { make in
            make.bottom.equalTo(0)
            make.top.left.equalTo(10)
            make.right.equalTo(-10)
        }
        
        backView.addSubview(topBackView)
        topBackView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
        
        topBackView.addSubview(topImgView)
        topImgView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
        topBackView.addSubview(buyBtn)
        buyBtn.snp.makeConstraints { make in
            make.right.equalTo(-10)
            make.bottom.equalTo(-15)
            make.width.equalTo(60)
            make.height.equalTo(22)
        }
        
        topBackView.addSubview(userView)
        userView.userStackView.userName.jk.addGestureTap { gesture in
            self.delegate?.clickUserName()
        }

        userView.snp.makeConstraints { make in
            make.top.left.equalTo(10)
            make.height.equalTo(45)
            make.right.equalTo(buyBtn.snp_left).offset(-5)
        }
        

        topBackView.addSubview(numLab)
        numLab.snp.makeConstraints { make in
            make.bottom.equalTo(-10)
            make.left.equalTo(userView.snp.left)
        }
                
        backView.addSubview(buyButton)
        buyButton.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.centerY.equalTo(userView.userImgView.snp.centerY)
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
        
        buyButton.addTarget(self, action: #selector(clickBuyLog), for: .touchUpInside)
        

    }


    
}
