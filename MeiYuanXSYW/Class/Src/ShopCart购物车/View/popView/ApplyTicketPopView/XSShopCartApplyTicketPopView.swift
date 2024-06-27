//
//  XSShopCartApplyTicketPopView.swift
//  MeiYuanXSYW
//
//  Created by admin on 2022/2/10.
//

import UIKit

class XSShopCartApplyTicketPopView: UIView {
    
    var merchantId: String = "" {
        didSet {
            loadCouponData()
        }
    }
    
    var couponModels = [FreeCouponList]() {
        didSet {
            tableView.reloadData()
        }
    }

    lazy var overlayView: UIControl = {
        let control = UIControl(frame: UIScreen.main.bounds)
        control.backgroundColor = UIColor(r: 0, g: 0, b: 0, a: 0.6)
        control.addTarget(self, action: #selector(fadeOut), for: .touchUpInside)
        control.isHidden = true
        return control
    }()
    
    lazy var tableView : UITableView = {
        let tableV = UITableView.init(frame: CGRect.zero, style: UITableView.Style.grouped)
        tableV.backgroundColor = .lightBackground
        tableV.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0.1))
        tableV.tableFooterView = UIView(frame: CGRect.zero)
        tableV.separatorStyle = .none
        tableV.dataSource = self
        tableV.delegate = self
        tableV.register(cellType: XSVipTicketCell.self)
        return tableV
    }()
    
    lazy var backButton: UIButton = {
        let back = UIButton()
        back.setImage(UIImage(named: "merchinfo_ticket_closure"), for: .normal)
        back.addTarget(self, action: #selector(backBtnDismiss), for: .touchUpInside)
        return back
    }()
    
    lazy var ticketTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "优惠券"
        label.textColor = .text
        label.font = MYFont(size: 16)
        return label
    }()
    
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUILayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadCouponData() {
        MerchantInfoProvider.request(.getMerchantCoupon(merchantId), model: [FreeCouponList].self) { returnData in
            
            if let coupons = returnData {
                self.couponModels = coupons
            }
            
        } errorResult: { errorMsg in
            print(errorMsg)
            XSTipsHUD.showText(errorMsg)
        }

    }

    
    private func setupUILayout(){
        self.backgroundColor = UIColor.lightBackground
        
        self.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 40, height: 20))
            make.top.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        
        self.addSubview(ticketTitleLabel)
        ticketTitleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(backButton)
            make.centerX.equalToSuperview()
        }
        
        self.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 60, left: 0, bottom: 0, right: 0))
        }
        
    }
    
    func receiver(model: FreeCouponList) {
        MerchantInfoProvider.request(.receiveCoupon(couponId: model.couponId), model: XSMerchInfoHandlerModel.self) { [weak self] returnData in
            guard let self = self else { return  }
            
            
            if returnData?.trueOrFalse ?? 0 == 0 {
                XSTipsHUD.showSucceed("领取成功")
            } else {
                XSTipsHUD.showSucceed("领取失败")
            }
            
        } errorResult: { errorMsg in
            print(errorMsg)
            XSTipsHUD.showText(errorMsg)
        }
    }
    
    
    // MARK: - public event
    
    @objc func backBtnDismiss() {
        fadeOut()
    }
    
    func getPopViewHeight() -> CGFloat {
        return 491
    }
    
    func show(){
       
        let window = UIApplication.shared.keyWindow
        window?.addSubview(overlayView)
        window?.addSubview(self)
        self.layer.cornerRadius = 20
        self.layer.masksToBounds = true
        self.frame = CGRect(x: 0, y: screenHeight, width: screenWidth, height: getPopViewHeight())
        fadeIn()
        
    }
    
    func fadeIn() {
     
        UIView.animate(withDuration: 0.25, delay: 0, options: UIView.AnimationOptions.curveEaseOut) {
            self.overlayView.isHidden = false
            self.frame = CGRect(x: 0, y: screenHeight - self.getPopViewHeight(), width: screenWidth, height: self.getPopViewHeight())
        }
    }
    
    @objc func fadeOut() {
        UIView.animate(withDuration: 0.25, delay: 0, options: UIView.AnimationOptions.curveEaseOut) {
            self.overlayView.isHidden = true
            self.frame = CGRect(x: 0, y: screenHeight, width: screenWidth, height: self.getPopViewHeight())
        } completion: { (finish) in
            self.overlayView.removeFromSuperview()
            self.removeFromSuperview()
        }
    }
    
}

extension XSShopCartApplyTicketPopView: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return couponModels.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:XSVipTicketCell = tableView.dequeueReusableCell(for: indexPath, cellType: XSVipTicketCell.self)
        
        let model = couponModels[indexPath.section]
        model.btnTitle = "立即领取"
        
        cell.dataModel = model
       
        cell.expandBlock = {
            model.ruleExpand = !model.ruleExpand
            tableView.reloadData()
        }
        
        cell.useBtnClickHandler = {[weak self] model in
            if model.btnTitle == "立即领取" {
               self?.receiver(model: model)
            } else { // 立即使用
                //self?.delegate?.dismissTicketPopView()
            }
           
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0001
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = .background
     
        return header
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let iv = UIView()
        iv.backgroundColor = .background
        return iv
    }
    
    
}

