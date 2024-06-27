//
//  CLGroupBuyRefundDetailController.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/6.
//

import UIKit

enum GroupBuyRefundDetail {
    case contact
    case goodInfo
    case rejectReason
    case refundInfo
    case addReasonInfo
    case orderInfo
    
    case topCorner
    case bottomCorner
    case groupBuyVoucherHead
    case groupBuyVoucherInfo
}
class CLGroupBuyRefundDetailController: XSBaseViewController {
    
    var cellModel:[GroupBuyRefundDetail] = []
    var status:groupBuyOrderStatus =  .refundReview // 退款审核中,退款申请被驳回,退款中,退款成功
    let topView  = CLMyOrderDetailTopView()
    var contactData:[[String:String]] = []
    
    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = .lightBackground
        $0.register(cellType: CLMyOrderDetailContactCell.self)
        $0.register(cellType: CLDeliverRefundGoodInfoCell.self)
        $0.register(cellType: CLDeliverRefundReasonRejectCell.self)
        $0.register(cellType: CLDeliverRefundInfoCell.self)
        $0.register(cellType: CLDeliverRefundAddReasonCell.self)
        $0.register(cellType: CLMyOrderDetailOrderInfoCell.self)
        $0.register(cellType: CLMyOrderDetailShopName2Cell.self)
        $0.register(cellType: CLGroupBuyRefundGoodInfoCell.self)
        $0.register(cellType: CLTopCornerRadioCell.self)
        $0.register(cellType: CLBottomCornerRadioCell.self)
        $0.separatorStyle = .none
    }
    func setDataForTopAndContact(){
        if status == .refundReview {
            topView.setting("退款审核中", "退款申请正在审核中","timeout_fill")
            self.contactData = [
                ["title":"取消退款","image":"close"],
                ["title":"客服","image":"customer_service"]]
        }else if status == .refundReject{
            topView.setting("退款申请被驳回", "退款申请被平台驳回","close-1")
            self.contactData = [
                ["title":"再次申请","image":"notes-1"],
                ["title":"退款进度","image":"arrow_right"],
                ["title":"客服","image":"customer_service"]]
        }else if status == .refunding{
            topView.setting("退款中", "财务正在处理退款","timeout_fill")
            self.contactData = [
                ["title":"联系商家","image":"right"],
                ["title":"客服","image":"customer_service"]]
        }else if status == .refundSuccess{
            topView.setting("退款成功", "退款已经原路返回,请进入账户查看","completed")
            self.contactData = [["title":"联系商家","image":"right"],
                                ["title":"客服","image":"customer_service"]]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cellModel.append(.contact)
        
        cellModel.append(.topCorner)
        cellModel.append(.groupBuyVoucherHead)
        cellModel.append(.groupBuyVoucherInfo)
        cellModel.append(.groupBuyVoucherInfo)
        cellModel.append(.bottomCorner)
        
        cellModel.append(.rejectReason)
        cellModel.append(.refundInfo)
        cellModel.append(.addReasonInfo)
        cellModel.append(.orderInfo)
        setDataForTopAndContact()
        
        self.view.addSubview(tableView)
        self.view.addSubview(topView)
        
        topView.hg_addGradientColor([UIColor.hex(hexString: "#F6094C"),
                                            UIColor.hex(hexString: "#FF724E")],
                                           size: CGSize(width: screenWidth, height: 145 + LL_StatusBarExtraHeight),
                                    startPoint: CGPoint(x:0.5, y: 0.5),
                                           endPoint: CGPoint(x:1 , y: 1))
        
        tableView.delegate = self
        tableView.dataSource = self
        
        topView.clickBlock = {[unowned self] in
            self.navigationController?.popViewController(animated: true)
        }
        
        topView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(145 + LL_StatusBarExtraHeight)
        }


        tableView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(topView.snp.bottom)
            make.bottom.equalTo(self.view.usnp.bottom).offset(-10)
        }

    }
    
    override func preferredNavigationBarHidden() -> Bool {
        return true
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}


extension CLGroupBuyRefundDetailController:UITableViewDelegate,UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModel.count
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch cellModel[indexPath.row] {
        case .contact:
            let cell:CLMyOrderDetailContactCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderDetailContactCell.self)
            cell.model = self.contactData
            return cell
        case .goodInfo:
            let cell:CLDeliverRefundGoodInfoCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLDeliverRefundGoodInfoCell.self)
            return cell
        case .rejectReason:
            let cell: CLDeliverRefundReasonRejectCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLDeliverRefundReasonRejectCell.self)
            return cell
        case .refundInfo:
            let cell: CLDeliverRefundInfoCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLDeliverRefundInfoCell.self)
            return cell
        case .addReasonInfo:
            let cell:CLDeliverRefundAddReasonCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLDeliverRefundAddReasonCell.self)
            return cell
        case .orderInfo:
            let cell:CLMyOrderDetailOrderInfoCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderDetailOrderInfoCell.self)
            return cell
        case .groupBuyVoucherHead:
            let cell:CLMyOrderDetailShopName2Cell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderDetailShopName2Cell.self)
       
            return cell
        case .groupBuyVoucherInfo:
            let cell:CLGroupBuyRefundGoodInfoCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLGroupBuyRefundGoodInfoCell.self)
            return cell
        case .topCorner:
            let cell:CLTopCornerRadioCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLTopCornerRadioCell.self)
       
            return cell
        case .bottomCorner:
            let cell:CLBottomCornerRadioCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLBottomCornerRadioCell.self)
       
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch cellModel[indexPath.row]{
        case .contact:
            return 100
        case .goodInfo:
            return 164
        case .refundInfo:
            return 270 + 10
        case .addReasonInfo:
            return 320
        case .orderInfo:
            return 180 + 10
        case .rejectReason:
            return 143
            

        case .groupBuyVoucherHead:
            return 27
        case .groupBuyVoucherInfo:
            return 130
        case .topCorner:
            return 10
        case .bottomCorner:
            return 10
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}
