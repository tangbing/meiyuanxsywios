//
//  XSShopCartInfoTopTableViewCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/24.
//

import UIKit
import QMUIKit


class XSScrollTicketView: UIScrollView {
    
   
    lazy var container: UIView = {
        let iv = UIView()
        iv.backgroundColor = .white
        return iv
    }()
    
    var lastHotBtn: QMUIButton?
    //let tests = ["满30减15","满40减17","生煎包包子","馒头包子","包子","馒头","生煎包包子","馒头包子","馒头","生煎包包子","馒头包子"]
    
    var reduceVoListStr: String = "" {
        didSet {
            let list = reduceVoListStr.components(separatedBy: " ")
            setupScrollView(reduceVolist: list)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.bounces = false
        self.isPagingEnabled = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupScrollView(reduceVolist: [String]){
        
        lastHotBtn = nil
        
        let containerView = UIView()
        self.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        for i in 0..<reduceVolist.count {
            let hotBtn = QMUIButton(type: .custom)
            hotBtn.setTitle(reduceVolist[i], for: .normal)
            hotBtn.backgroundColor = UIColor.white
            hotBtn.setTitleColor(UIColor.hex(hexString: "#F11F16"), for: .normal)
            hotBtn.titleLabel?.font = MYFont(size: 10)
            containerView.addSubview(hotBtn)
            hotBtn.sizeToFit()
            hotBtn.contentEdgeInsets = UIEdgeInsets(top: 2, left: 4, bottom: 2, right: 4)
            hotBtn.addTarget(self, action: #selector(hotBtnClick(hotBtn:)), for: .touchUpInside)
            hotBtn.hg_setAllCornerWithCornerRadius(radius: 2)
            hotBtn.jk.addBorder(borderWidth: 1, borderColor: UIColor.hex(hexString: "#F11F16"))
            hotBtn.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.left.equalTo(lastHotBtn != nil ? lastHotBtn!.snp_right : containerView.snp_left).offset(4)
            }
            lastHotBtn = hotBtn
        }
    
        lastHotBtn!.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(0)
        }
    
    }
    
    @objc func hotBtnClick(hotBtn: QMUIButton) {
        print(hotBtn.currentTitle ?? "")
    }
    
}

class XSShopCartInfoTopTableViewCell: XSBaseTableViewCell {

    var btnSelectBlock: ((_ cell : XSShopCartInfoTopTableViewCell )-> Void)?
    var applyTicketBlock: ((_ merchantId: String) -> Void)?
    
    lazy var selectBtn: UIButton = {
        let all = UIButton(type: .custom)
        all.setImage(UIImage(named: "mine_tick_normal"), for: .normal)
        all.setImage(UIImage(named: "mine_tick_selected"), for: .selected)
        all.setImage(UIImage(named: "mine_tick_disable"), for: .disabled)
        all.setTitleColor(.text, for: .normal)
        all.titleLabel?.font = MYBlodFont(size: 18)
        all.addTarget(self, action: #selector(selectAllAction(button:)), for: .touchUpInside)
        return all
    }()
    
    lazy var singLabel: QMUILabel = {
        let sign = QMUILabel()
        sign.backgroundColor = UIColor.hex(hexString: "#518DFF")
        sign.textColor = .white
        sign.text = "外卖"
        sign.font = MYFont(size: 9)
        sign.contentEdgeInsets = UIEdgeInsets(top: 2, left: 4, bottom: 2, right: 4)
        sign.hg_setAllCornerWithCornerRadius(radius: 2)
        return sign
    }()
    
    lazy var arrowBtn : QMUIButton = {
        let arrowBtn = QMUIButton()
        arrowBtn.contentHorizontalAlignment = .left
        arrowBtn.imagePosition = QMUIButtonImagePosition.right
        arrowBtn.setTitle("BBBB商家（商家名称）", for: UIControl.State.normal)
        arrowBtn.setImage(UIImage(named: "merchInfo_detail_down"), for: UIControl.State.normal)
        arrowBtn.setTitleColor(.twoText, for: UIControl.State.normal)
        arrowBtn.titleLabel?.font = MYBlodFont(size: 16)
        arrowBtn.spacingBetweenImageAndTitle = 0
        arrowBtn.addTarget(self, action: #selector(showShopInfo), for: .touchUpInside)
        return arrowBtn
    }()
    
    lazy var applyTicketBtn : QMUIButton = {
        let arrowBtn = QMUIButton()
        arrowBtn.imagePosition = QMUIButtonImagePosition.right
        arrowBtn.setTitle("领券", for: UIControl.State.normal)
        arrowBtn.setTitleColor(.king, for: UIControl.State.normal)
        arrowBtn.titleLabel?.font = MYFont(size: 14)
        arrowBtn.addTarget(self, action: #selector(showShopInfo), for: .touchUpInside)
        return arrowBtn
    }()
    
    let line = lineView(bgColor: UIColor.hex(hexString: "#E5E5E5"))
    
    lazy var ticketScroll: XSScrollTicketView = {
        
        return XSScrollTicketView()
    }()
    
    
    var infoTopModel: XSShopCartInfoTopModel? {
        didSet {
            guard let model = infoTopModel else {
                return
            }

            singLabel.text = model.signalTitle
            
            arrowBtn.setTitle(model.dataModel.merchantName, for: .normal)

            applyTicketBtn.isHidden = model.cellState == .loseTime

            
            /// 已失效没有选中按钮
            if model.cellState == .normal { // 有效
                selectBtn.snp.remakeConstraints { make in
                    make.top.equalToSuperview().offset(10)
                    make.left.equalToSuperview().offset(8)
                    make.size.equalTo(CGSize(width: 22, height: 22))
                }
                selectBtn.isEnabled = true

            } else if model.cellState == .outBounds {
                selectBtn.snp.remakeConstraints { make in
                    make.top.equalToSuperview().offset(10)
                    make.left.equalToSuperview().offset(8)
                    make.size.equalTo(CGSize(width: 22, height: 22))
                }
                selectBtn.isEnabled = false
            }
            else {// 失效
                selectBtn.snp.remakeConstraints { make in
                    make.top.equalToSuperview().offset(10)
                    make.left.equalToSuperview().offset(0)
                    make.width.equalTo(0)
                }
                selectBtn.isEnabled = true

            }
            
            if model.hasTopRadius {
                self.contentView.hg_setCornerOnTopWithRadius(radius: 10)
            }
        
            if model.signalTitle == "私厨" {
                singLabel.backgroundColor = UIColor.hex(hexString: "#FF6E02")
            } else if(model.signalTitle == "到店") {
                singLabel.backgroundColor = UIColor.hex(hexString: "#F11F16")
            } else {
                singLabel.backgroundColor = UIColor.hex(hexString: "#518DFF")
            }
            
            ticketScroll.reduceVoListStr = model.dataModel.merchantFullReduceVoListStr
            
        }
    }
    
    override func configUI() {
        super.configUI()
        setupInfoTop()
    }
    
    func setupInfoTop(){
        self.contentView.addSubview(selectBtn)
        selectBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(8)
            make.size.equalTo(CGSize(width: 22, height: 22))
        }
        
        self.contentView.addSubview(singLabel)
        singLabel.snp.makeConstraints { make in
            make.centerY.equalTo(selectBtn)
            make.left.equalTo(selectBtn.snp_right).offset(10)
            make.size.equalTo(CGSize(width: 30, height: 15))
        }
        
        self.contentView.addSubview(applyTicketBtn)
        applyTicketBtn.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.centerY.equalTo(selectBtn)
            make.width.equalTo(32)
            make.height.equalTo(22)
        }
        
        self.contentView.addSubview(arrowBtn)
        arrowBtn.snp.makeConstraints { make in
            make.centerY.equalTo(selectBtn)
            make.left.equalTo(singLabel.snp_right).offset(10)
            make.height.equalTo(23)
            make.right.equalTo(applyTicketBtn.snp_left).offset(-10)
            //make.size.equalTo(CGSize(width: 30, height: 15))
        }
        
        self.contentView.addSubview(line)
        line.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(arrowBtn.snp_bottom).offset(8)
        }
        
        self.contentView.addSubview(ticketScroll)
        ticketScroll.snp.makeConstraints { make in
            make.left.equalTo(singLabel)
            make.right.equalTo(line)
            make.height.equalTo(18)
            make.top.equalTo(line.snp_bottom).offset(10)
        }
        
    }
    
    @objc func selectAllAction( button: UIButton) {
        self.btnSelectBlock?(self)
        button.isSelected = !button.isSelected
        infoTopModel?.isSelect = button.isSelected
       

    }
    
    @objc func showShopInfo() {
        if let model = infoTopModel?.dataModel {
            
            if let applyTicket = applyTicketBlock {
                applyTicket(model.merchantId)
            }
            
        }
    }
    
    
    
}
