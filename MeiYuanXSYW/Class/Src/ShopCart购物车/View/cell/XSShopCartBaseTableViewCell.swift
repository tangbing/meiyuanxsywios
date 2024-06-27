//
//  XSShopCartInfoBaseTableViewCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/25.
//

import UIKit

enum XSShopCartUpdateCountStyle: Int {
    case plus
    case reduce
}

protocol XSShopCartDelieveTableViewCellDelegate: NSObjectProtocol {
    func plusReduceViewZero(viewModel: XSShopCartModelProtocol)
    func showSelectStandard(_ delieveTableCell: XSShopCartDelieveTableViewCell)
}


class XSShopCartBaseTableViewCell: XSBaseTableViewCell {

    weak var delegate: XSShopCartDelieveTableViewCellDelegate?

    var selectBtnBlock: ((_ tableCell: XSShopCartBaseTableViewCell) -> Void)?
    var viewModel: XSShopCartModelProtocol?

    func bindingViewModel(viewModel: XSShopCartModelProtocol) {
        self.viewModel = viewModel

        selectBtn.isSelected = viewModel.isSelect
        if viewModel.cellState == .loseTime {
            loseSignLabel.isHidden = false
            selectBtn.isHidden = true
            selectBtn.isEnabled = true
        } else if(viewModel.cellState == .outBounds) {
            loseSignLabel.isHidden = true
            selectBtn.isHidden = false
            selectBtn.isEnabled = false
        } else {
            loseSignLabel.isHidden = true
            selectBtn.isHidden = false
            selectBtn.isEnabled = true
        }
       

        
        if let delieve = viewModel as? XSShopCartDelieveModel {
            merchIcon.xs_setImage(urlString: delieve.orderShoppingTrolleyVOList.topPic)
            merchNameLabel.text = delieve.orderShoppingTrolleyVOList.goodsName

        }
        
        if let group = viewModel as? XSShopCartGroupBuyModel {
            merchIcon.xs_setImage(urlString: group.orderShoppingTrolleyVOList.topPic)
            merchNameLabel.text = group.orderShoppingTrolleyVOList.goodsName

        }
        
        if let privateKitchen = viewModel as? XSShopCartPrivateKitchenModel {
            merchIcon.xs_setImage(urlString: privateKitchen.orderShoppingTrolleyVOList.topPic)
            merchNameLabel.text = privateKitchen.orderShoppingTrolleyVOList.goodsName

        }
        
    }
    
    lazy var selectBtn: UIButton = {
        let all = UIButton(type: .custom)
        all.setImage(UIImage(named: "mine_tick_normal"), for: .normal)
        all.setImage(UIImage(named: "mine_tick_selected"), for: .selected)
        all.setImage(UIImage(named: "mine_tick_disable"), for: .disabled)
        all.setTitleColor(.text, for: .normal)
        all.titleLabel?.font = MYBlodFont(size: 18)
        all.addTarget(self, action: #selector(selectBtnAction(select:)), for: .touchUpInside)
        return all
    }()
    
    lazy var loseSignLabel: UILabel = {
        let singLabel = UILabel()
        singLabel.backgroundColor = UIColor.hex(hexString: "#E5E5E5")
        singLabel.text = "已失效"
        singLabel.textColor = .white
        singLabel.textAlignment = .center
        singLabel.hg_setAllCornerWithCornerRadius(radius: 8.5)
        singLabel.font = MYFont(size: 9)
        singLabel.isHidden = true
        return singLabel
    }()
    
    lazy var merchIcon: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        iv.clipsToBounds = true
        iv.hg_setAllCornerWithCornerRadius(radius: 5)
        iv.image = UIImage(named: "group buy_picture4")
        return iv
    }()
    
    lazy var merchNameLabel: UILabel = {
        let label = UILabel()
        label.text = "康美甄营养餐菜品名称"
        label.textColor = .twoText
        label.font = MYBlodFont(size: 16)
        return label
    }()
    
    override func configUI() {
        super.configUI()

        self.contentView.addSubview(selectBtn)
        selectBtn.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 22, height: 22))
            make.left.equalToSuperview().offset(8)
            make.centerY.equalToSuperview()
        }
        
        self.contentView.addSubview(loseSignLabel)
        loseSignLabel.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 35, height: 17))
            make.left.equalToSuperview().offset(8)
            make.centerY.equalToSuperview()
        }
        
        self.contentView.addSubview(merchIcon)
        merchIcon.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 90, height: 90))
            make.left.equalTo(loseSignLabel.snp_right).offset(8)
            make.top.equalToSuperview().offset(10)
        }
        
        self.contentView.addSubview(merchNameLabel)
        merchNameLabel.snp.makeConstraints { make in
            make.left.equalTo(merchIcon.snp_right).offset(10)
            make.top.equalTo(merchIcon)
        }
        
    }
    
    @objc func selectBtnAction(select button: UIButton) {
        button.isSelected = !button.isSelected
        viewModel?.isSelect = button.isSelected
    
        selectBtnBlock?(self)

    }
    
    func shopCartUpdateCount(style:XSShopCartUpdateCountStyle, model: XSShopCartTrolleyVOList, merchantId: String) {
        
        var count = model.account + 1
        if style == .reduce {
            if model.account == 1 { // 当account等于1，点击减号，要弹出提示，是否要删除数据
                self.delegate?.plusReduceViewZero(viewModel: viewModel!)
                return
            }
           count = model.account - 1
        }
        
        let Id = model.id
        
        MerchantInfoProvider.request(.updateShoppingTrolleyCountById(count, id: Id, merchantId: merchantId), model: XSMerchInfoHandlerModel.self) {  [weak self] returnData in
            
            guard let self = self else { return }
            
            if (returnData?.trueOrFalse ?? 0) == 0 {
               
                if style == .plus {
                    model.account += 1
                } else {
                    model.account -= 1
                }
                
                NotificationCenter.default.post(name: NSNotification.Name.XSCartMerchInfoPopCellReduceBtnClickNotification, object: self, userInfo: ["OrderShoppingTrolleyVOList" : model])

            }
        } errorResult: { errorMsg in
            uLog(errorMsg)
            XSTipsHUD.showText(errorMsg)
        }
    }
    
    
}
