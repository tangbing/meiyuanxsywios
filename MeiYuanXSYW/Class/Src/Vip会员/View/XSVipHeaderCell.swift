//
//  XSVipHeaderCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/8/19.
//

import UIKit
import QMUIKit
/// 添加cell点击代理方法
protocol XSVipHeaderCellDelegate:NSObjectProtocol {
    func clickUserName()//点击我的会员卡
    func clickBuyVip()///点击购买会员卡
    func clickTicket()///点击可用红包


}
///用户头像加用户名
class XSUserView:UIView{
    let userImgView : UIImageView={
        let userImgView = UIImageView()
        userImgView.image = UIImage(named: "mine_user")
//        userImgView.contentMode = .scaleAspectFill
        userImgView.layer.cornerRadius = 22.5
        userImgView.clipsToBounds = true
        return userImgView
    }()
    var userStackView : XSUserNameStackView = {
        let userStackView = XSUserNameStackView()
        return userStackView
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(userImgView)
        userImgView.snp.makeConstraints { make in
            make.left.top.equalTo(0)
            make.width.height.equalTo(45)
        }
        
        self.addSubview(userStackView)
        userStackView.snp.makeConstraints { make in
            make.left.equalTo(userImgView.snp_right).offset(10)
            make.top.equalTo(userImgView.snp_top)
            make.bottom.equalTo(userImgView.snp_bottom)
        }

    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
class XSUserNameStackView:UIStackView  {
    let userName : UILabel={
        let userName = UILabel()
        userName.textColor = .vipHader
        userName.font = MYBlodFont(size: 18)
        userName.isUserInteractionEnabled = true

        return userName
    }()
    let userNameTipView : UIView={
        let userNameTipView = UIView()
        userNameTipView.isUserInteractionEnabled = false

        return userNameTipView
    }()
    let userNameTipLab : UILabel={
        let userNameTipLab = UILabel()
        userNameTipLab.textColor = UIColor.hex(hexString: "#AC9E8B")
        userNameTipLab.font = MYBlodFont(size: 12)

        return userNameTipLab
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        axis = .vertical
        alignment = .fill
        distribution = .fillEqually
        
        addArrangedSubview(userName)
        
        addArrangedSubview(userNameTipView)
        
        userNameTipView.addSubview(userNameTipLab)
        userNameTipLab.snp.makeConstraints { make in
            make.left.equalTo(0)
            make.top.equalTo(4)
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
class XSVipHeaderCell: XSBaseTableViewCell {
    weak var delegate : XSVipHeaderCellDelegate?
    
    var model:CLMemberUserInfoModel?{
        didSet{
            guard let newModel = model else {
                
                userView.userStackView.userName.text = "请登录"
                bottomLab.text = "快来登录开通会员吧"
                numLab.isHidden = true
//                bottomLab.isHidden = true
                buyBtn.isHidden = true
                userView.userStackView.userNameTipLab.isHidden = true
                headerTipView.userNameTipLab.isHidden = true
                headerTipView.userName.isHidden = true
                
                userView.userStackView.userNameTipLab.removeFromSuperview()
                userView.userStackView.userName.snp.remakeConstraints { make in
                    make.center.equalToSuperview()
                }
                
                return
            }
            
            if XSAuthManager.shared.isLoginEd {
                
                numLab.isHidden = false
                bottomLab.isHidden = false
                buyBtn.isHidden = false
                userView.userStackView.userNameTipLab.isHidden = false
                headerTipView.userNameTipLab.isHidden = false
                headerTipView.userName.isHidden = false

                userView.userStackView.userName.text = newModel.mobile
                headerTipView.userName.text = "可用红包"
                userView.userImgView.xs_setImage(urlString: newModel.headImg)

                if newModel.memberStatus == "1" {
                    userView.userStackView.userNameTipLab.text = "\(newModel.timeoutDate.components(separatedBy: " ").first ?? "")到期>"
                    headerTipView.userNameTipLab.text = "有\(newModel.nearTimeoutNum)张红包在\(newModel.nearTimeoutDay)天后过期"

                    buyBtn.setTitle("立即续费", for: .normal)
                    bottomLab.text = "2021.06.22下期会员生效，发送6张5元会员红包"

                }else {
                    
                    userView.userStackView.userNameTipLab.removeFromSuperview()
                    userView.userStackView.userName.snp.remakeConstraints { make in
                        make.center.equalToSuperview()
                    }
                    
                    headerTipView.snp.remakeConstraints { make in
                        make.bottom.equalTo(-10)
                        make.left.equalTo(15)
                        make.height.equalTo(30)
                    }
                    headerTipView.userName.text = "可用红包"
                    headerTipView.userNameTipLab.removeFromSuperview()

                    buyBtn.setTitle("立即购买", for: .normal)
                    bottomLab.text = "快来开通会员吧"
                }
                numLab.text = "¥ \(newModel.amount)   X   \(newModel.giveNum)张"
                numLab.jk.setsetSpecificTextFont("¥", font:MYFont(size: 17))
                numLab.jk.setsetSpecificTextFont("X", font:MYFont(size: 19))
                numLab.jk.setsetSpecificTextFont("张", font:MYFont(size: 16))

            }else{
                userView.userStackView.userName.text = "请登录"
                bottomLab.text = "快来登录开通会员吧"
                numLab.isHidden = true
//                bottomLab.isHidden = true
                buyBtn.isHidden = true
                userView.userStackView.userNameTipLab.isHidden = true
                headerTipView.userNameTipLab.isHidden = true
                headerTipView.userName.isHidden = true
            }
        }
    }

    var backView : UIView={
        let backView = UIView()
        backView.backgroundColor = .vipHader
        backView.hg_setAllCornerWithCornerRadius(radius: 10)
        return backView
    }()
    var topBackView : UIView={
        let topBackView = UIView()
        topBackView.hg_setAllCornerWithCornerRadius(radius: 10)
        return topBackView
    }()
    var topImgView : UIImageView={
        let topImgView = UIImageView()
        topImgView.image = UIImage(named: "vip_member_bg")
        return topImgView
    }()
    //用户头像加用户名
    var userView:XSUserView={
        let userView = XSUserView()
        return userView
    }()
    
    var buyBtn : UIButton={
        let buyBtn = UIButton()
        buyBtn.titleLabel?.font = MYFont(size: 13)
        buyBtn.setTitle("立即购买", for: UIControl.State.normal)
        buyBtn.setTitleColor(.white, for: UIControl.State.normal)
        buyBtn.setTitleColor(.tag, for: UIControl.State.selected)
        buyBtn.setBackgroundImage(UIImage(named: "btnBackImg"), for: UIControl.State.normal)
        buyBtn.setBackgroundImage(UIColor.clear.image(), for: UIControl.State.selected)
        buyBtn.hg_setAllCornerWithCornerRadius(radius: 15)
        return buyBtn
    }()
    
    //可用红包
    var headerTipView:XSUserNameStackView={
        let headerTipView = XSUserNameStackView()
        headerTipView.userName.font = MYFont(size: 14)
        headerTipView.userName.textColor = UIColor.hex(hexString: "#AC9E8B")

        
        headerTipView.userNameTipLab.font = MYFont(size: 12)
        headerTipView.userNameTipLab.textColor = .red
        return headerTipView
    }()
    
    ///券
    let numLab : UILabel={
        let numLab = UILabel()
        numLab.textColor = UIColor.hex(hexString: "#FFD0A1")
        numLab.font = MYFont(size: 30)
        return numLab
    }()

    ///底部提示
    let bottomLab : UILabel={
        let bottomLab = UILabel()
        bottomLab.textColor = .kingText
        bottomLab.font = MYFont(size: 13)
        return bottomLab
    }()

    @objc func clickBuyVipAction() {
        delegate?.clickBuyVip()
    }
    
    var dataSource = [Any]()
    
    override func configUI() {

        contentView.backgroundColor = .background
        contentView.addSubview(backView)
        backView.snp.makeConstraints { make in
            make.bottom.equalTo(-6)
            make.top.left.equalTo(10)
            make.right.equalTo(-10)
        }
        
        backView.addSubview(topBackView)
        topBackView.snp.makeConstraints { make in
            make.left.top.right.equalTo(0)
            make.height.equalTo(116)
        }
        
        topBackView.addSubview(topImgView)
        topImgView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
        topBackView.addSubview(buyBtn)
        buyBtn.add(self, action: #selector(clickBuyVipAction))
        buyBtn.snp.makeConstraints { make in
            make.right.equalTo(-10)
            make.top.equalTo(23)
            make.width.equalTo(90)
            make.height.equalTo(30)
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
        
        topBackView.addSubview(headerTipView)
        headerTipView.userName.jk.addGestureTap { gesture in
            self.delegate?.clickTicket()
        }
        headerTipView.snp.makeConstraints { make in
            make.bottom.equalTo(-15)
            make.left.equalTo(10)
            make.height.equalTo(40)
        }
        topBackView.addSubview(numLab)
        numLab.snp.makeConstraints { make in
            make.bottom.equalTo(-10)
            make.right.equalTo(-10)
        }
        
        backView.addSubview(bottomLab)
        bottomLab.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.top.equalTo(topBackView.snp_bottom)
            make.bottom.equalTo(0)
        }


    }


    
}
