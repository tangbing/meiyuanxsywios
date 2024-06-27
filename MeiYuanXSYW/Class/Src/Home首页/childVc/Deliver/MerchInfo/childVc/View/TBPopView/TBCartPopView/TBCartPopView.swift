//
//  TBCartPopView.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/12.
//

import UIKit
import QMUIKit

class TBCartPopView: UIView {

    var merchantId: String = ""
    var bottomSpace: CGFloat = 0.0
    
    var cartClarAllHandler: ((_ popView: TBCartPopView) -> Void)?
    var cartGoodInfoModel: TBMerchInfoCartGoodInfoModel?

    lazy var overlayView: UIControl = {
        let control = UIControl(frame: UIScreen.main.bounds)
        control.backgroundColor = UIColor(r: 0, g: 0, b: 0, a: 0.6)
        control.addTarget(self, action: #selector(fadeOut), for: .touchUpInside)
        control.isHidden = true
        return control
    }()
    
    lazy var TitleLabel: UILabel = {
        let label = UILabel()
        label.text = "打包费"
        label.textColor = .twoText
        label.font = MYBlodFont(size: 16)
        return label
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.text = "¥3.5"
        label.textColor = UIColor.hex(hexString: "#E61016")
        label.font = MYBlodFont(size: 16)
        return label
    }()
    
    lazy var cartClearButton: QMUIButton = {
        let arrowBtn = QMUIButton()
        arrowBtn.imagePosition = QMUIButtonImagePosition.left
        arrowBtn.setTitle("清空购物车", for: UIControl.State.normal)
        arrowBtn.setImage(UIImage(named: "home_search_delete"), for: UIControl.State.normal)
        arrowBtn.setTitleColor(.twoText, for: UIControl.State.normal)
        arrowBtn.titleLabel?.font = MYFont(size: 16)
        arrowBtn.spacingBetweenImageAndTitle = 5
        arrowBtn.addTarget(self, action: #selector(cartClarAll), for: .touchUpInside)
        return arrowBtn
    }()
    
    lazy var cartTableView: TBBaseTableView = {
        let cartTable = TBBaseTableView(frame: .zero, style: .plain)
        cartTable.register(cellType: TBCartMerchInfoPopCell.self)
        cartTable.backgroundColor = .white
        cartTable.rowHeight = 75
        cartTable.dataSource = self
        cartTable.delegate = self
        cartTable.tableFooterView = UIView()
        return cartTable
    }()
    


    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        
    }

    func getCartOrderInfo(merchantId: String) {
        
        self.merchantId = merchantId
        fetchOrderInfo()
    }
    
    func fetchOrderInfo() {
        MerchantInfoProvider.request(.getOrderMerchantInCarVO(merchantId), model: TBMerchInfoCartGoodInfoModel.self) { [weak self] returnData in
            //uLog(returnData)
            if let cartGoodsInfoModel = returnData {
                
                self?.priceLabel.text = "￥\(cartGoodsInfoModel.totalPacketAmt)"
                
                self?.cartGoodInfoModel = cartGoodsInfoModel
                
                self?.cartTableView.reloadData()
            }

        } errorResult: { errorMsg in
            uLog(errorMsg)
            XSTipsHUD.showText(errorMsg)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.backgroundColor = .white
        self.hg_setCornerOnTopWithRadius(radius: 10)
        
        self.addSubview(TitleLabel)
        TitleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(15)
            make.height.equalTo(24)
        }
        
        self.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { make in
            make.left.equalTo(TitleLabel.snp_right).offset(4)
            make.top.equalToSuperview().offset(15)
            make.height.equalTo(24)
        }
        
        self.addSubview(cartClearButton)
        cartClearButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.centerY.equalTo(TitleLabel)
        }
        
        self.addSubview(cartTableView)
        cartTableView.snp.makeConstraints { make in
            make.top.equalTo(TitleLabel.snp_bottom).offset(25)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview()
        }
        
    }
    
    func getPopViewHeight() -> CGFloat {
        return 360
    }
    
    
    func show(showSuperView: UIView? = nil, bottomSpace: CGFloat = 0.0){
        let container = showSuperView == nil ? UIApplication.shared.keyWindow : showSuperView
        container!.addSubview(overlayView)
        container!.addSubview(self)
        self.bottomSpace = bottomSpace
        self.hg_setCornerOnTopWithRadius(radius: 20)
        self.frame = CGRect(x: 0, y: screenHeight - bottomInset, width: screenWidth, height: getPopViewHeight())
        fadeIn()
    }
    
    func fadeIn() {
     
        UIView.animate(withDuration: 0.25, delay: 0, options: UIView.AnimationOptions.curveEaseOut) {
            self.overlayView.isHidden = false
            self.frame = CGRect(x: 0, y: screenHeight - bottomInset - bottomCartViewH - self.bottomSpace - self.getPopViewHeight(), width: screenWidth, height: self.getPopViewHeight())
        }
    }
    
    @objc func fadeOut() {
        UIView.animate(withDuration: 0.25, delay: 0, options: UIView.AnimationOptions.curveEaseOut) {
            self.overlayView.isHidden = true
            self.frame = CGRect(x: 0, y: screenHeight - bottomInset, width: screenWidth, height: self.getPopViewHeight())
        } completion: { (finish) in
            self.overlayView.removeFromSuperview()
            self.removeFromSuperview()
        }
    }
    
    @objc func cartClarAll() {
        MerchantInfoProvider.request(.delTrolleyOrNoEfficacy(merchantId, status: nil), model: XSMerchInfoHandlerModel.self) { [weak self] returnData in
            //uLog("cartClarAll:\(returnData)")
            guard let self = self else {
                return
            }
            
            if (returnData?.trueOrFalse ?? 0) == 0 {
                self.cartClarAllHandler?(self)
                self.fadeOut()
                
            }
            
        } errorResult: { errorMsg in
            uLog(errorMsg)
            XSTipsHUD.showText(errorMsg)
        }
    }

}

extension TBCartPopView: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartGoodInfoModel?.orderShoppingTrolleyVOList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TBCartMerchInfoPopCell.self)
        cell.cartModel = cartGoodInfoModel?.orderShoppingTrolleyVOList?[indexPath.row]
        cell.reduceBtnZeroHandler = { [weak self] cell in
            self?.fetchOrderInfo()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let iv = UIView()
        iv.backgroundColor = UIColor.white
        return iv
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let iv = UIView()
        iv.backgroundColor = UIColor.white
        return iv
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
}
