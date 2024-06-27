//
//  TBMerchInfoTicketDiscountPopView.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/3.
//

import UIKit

protocol TBMerchInfoPopViewDelegate: NSObjectProtocol {
    func refreshTicket()
    func dismissTicketPopView()
}

class TBMerchInfoTicketDiscountPopView: UIView {
    
    weak var delegate: TBMerchInfoPopViewDelegate?
    
    var discountModels = [[FreeCouponList]]()
    private var sectionTitles = [String]()
    
    var dataModel: TBMerchantCouponListModel? {
        didSet {
            guard let model = dataModel else { return }
            
            discountModels.removeAll()
            
            if let myCouponVoListModel = model.myCouponVoList {
                
                myCouponVoListModel.forEach {
                    $0.btnTitle = "立即使用"
                }
                discountModels.append(myCouponVoListModel)
                sectionTitles.append("您有\(myCouponVoListModel.count)张优惠券")
            }
            
            if let freeCouponListModel = model.freeCouponList {
                freeCouponListModel.forEach {
                    $0.btnTitle = "立即领取"
                }
                discountModels.append(freeCouponListModel)
                sectionTitles.append("免费领券")
            }
            
            tableView.reloadData()
            
        }
      
    }
    
    
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
    
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUILayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    private func setupUILayout(){
        self.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}

// MARK: - httpRequest
extension TBMerchInfoTicketDiscountPopView {
    func receiverCoupon(model: FreeCouponList) {
        MerchantInfoProvider.request(.receiveCoupon(couponId: model.couponId), model: XSMerchInfoHandlerModel.self) { [weak self] returnData in
            
            if returnData?.trueOrFalse ?? 0 == 0 {
                XSTipsHUD.showSucceed("领取成功")
                self?.delegate?.refreshTicket()
                // 重新刷新店铺详情的头接口获取数据
                NotificationCenter.default.post(name: NSNotification.Name.XSUpdateMerchHeadrInfoNotification, object: nil)

                
            } else {
                XSTipsHUD.showSucceed("领取失败")
            }
            
        } errorResult: { errorMsg in
            print(errorMsg)
            XSTipsHUD.showText(errorMsg)
        }
    }
}


extension TBMerchInfoTicketDiscountPopView: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return discountModels.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let discount = discountModels[section]
        return discount.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:XSVipTicketCell = tableView.dequeueReusableCell(for: indexPath, cellType: XSVipTicketCell.self)
        
        let discount = discountModels[indexPath.section]
        let model = discount[indexPath.row]
        cell.dataModel = model
        
        cell.expandBlock = {
            model.ruleExpand = !model.ruleExpand
            tableView.reloadData()
        }
        
        cell.useBtnClickHandler = {[weak self] model in
            if model.btnTitle == "立即领取" {
                self?.receiverCoupon(model: model)
            } else { // 立即使用
                self?.delegate?.dismissTicketPopView()
            }
           
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        let titleLabel = UILabel()
        titleLabel.text = sectionTitles[section]
        titleLabel.font = MYFont(size: 14)
        titleLabel.textColor = .text
        
        header.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(header).offset(10)
            make.centerY.equalTo(header)
        }
        return header
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let iv = UIView()
        iv.backgroundColor = .background
        return iv
    }
    
    
}
