//
//  CLDeliverRefundDetailController.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/3.
//

import UIKit
import Presentr

enum DeliverRefundDetail {
    case contact
    case goodInfo
    case rejectReason
    case refundInfo
    case addReasonInfo
    case orderInfo
}

class CLDeliverRefundDetailController: XSBaseViewController {
    
    var cellModel:[DeliverRefundDetail] = []
    var status:deliverOrderStatus = .refundReview // 退款审核中,退款申请被驳回,退款中,退款成功
    let topView  = CLMyOrderDetailTopView()
    var contactData:[[String:String]] = []
    var model:CLMyOrderListModel?
    
    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = .lightBackground
        $0.register(cellType: CLMyOrderDetailContactCell.self)
        $0.register(cellType: CLDeliverRefundGoodInfoCell.self)
        $0.register(cellType: CLDeliverRefundReasonRejectCell.self)
        $0.register(cellType: CLDeliverRefundInfoCell.self)
        $0.register(cellType: CLDeliverRefundAddReasonCell.self)
        $0.register(cellType: CLMyOrderDetailOrderInfoCell.self)
        $0.separatorStyle = .none
    }
    
    
    lazy var cancelPresenter: Presentr = {
        let width = ModalSize.customOrientation(sizePortrait: 310, sizeLandscape: 310)
        let height = ModalSize.customOrientation(sizePortrait: 158 - 10, sizeLandscape: 158 - 10)
        let center = ModalCenterPosition.center
        let customType = PresentationType.custom(width: width, height: height, center: center)
        let presenter = Presentr(presentationType: customType)
        presenter.transitionType = .custom(CLCustomAnimation(options: .normal(duration: 0.25)))
        presenter.dismissTransitionType = .custom(CLCustomAnimation(options: .normal(duration: 0.25)))
        presenter.backgroundOpacity = 0.7
        presenter.roundCorners = true
        presenter.cornerRadius = 10
        return presenter
      }()
    
    func setDataForTopAndContact(){
        if status == .refundReview {
            topView.setting("退款审核中", "退款申请正在审核中","timeout_fill")
            self.contactData = [
                ["title":"撤销申请","image":"application_canceled"],
                ["title":"修改申请","image":"application canceled"],
                ["title":"联系商家","image":"right"],
                ["title":"客服","image":"customer_service"],
                ["title":"退款进度","image":"arrow_right"]]
        }else if status == .refundReject{
            topView.setting("退款被驳回", "退款申请被平台驳回","close-1")
            self.contactData = [
                ["title":"撤销申请","image":"application_canceled"],
                ["title":"修改申请","image":"application canceled"],
                ["title":"联系商家","image":"right"],
                ["title":"客服","image":"customer_service"],
                ["title":"退款进度","image":"arrow_right"]]
        }else if status == .refunding{
            topView.setting("退款中", "退款已经原路返回，请进入账户查看","timeout_fill")
            self.contactData = [
                ["title":"联系商家","image":"right"],
                ["title":"客服","image":"customer_service"]]
        }else if status == .refundSuccess{
            topView.setting("退款成功", "退款已经原路返回，请进入账户查看","completed")
            self.contactData = [
                ["title":"联系商家","image":"right"],
                ["title":"客服","image":"customer_service"]]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cellModel.append(.contact)
        cellModel.append(.goodInfo)
        cellModel.append(.rejectReason)
        cellModel.append(.refundInfo)
        cellModel.append(.addReasonInfo)
        cellModel.append(.orderInfo)

        self.view.addSubview(tableView)
        self.view.addSubview(topView)
        
        setDataForTopAndContact()
        
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


extension CLDeliverRefundDetailController:UITableViewDelegate,UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModel.count
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch cellModel[indexPath.row] {
        case .contact:
            let cell:CLMyOrderDetailContactCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderDetailContactCell.self)
            cell.model  = self.contactData
            cell.clickBlock = {[unowned self] para in
                switch para {
                case "修改地址":break
                case "取消订单":break
                case "联系商家":break
                case "客服":break
                case "发红包":break
                case "申请售后":
                    let vc = CLDeliverRequestRefundController()
                    vc.goodModel = self.model!.orderGoodsDetailVOList
                    self.navigationController?.pushViewController(vc, animated: true)
                case "订单评价":
                    let vc = CLMyOrderCommentController()
                    vc.bizType = self.model!.bizType
                    self.navigationController?.pushViewController(vc, animated: true)
                case "重新下单":break
                case "取餐码":
                    return
                case "撤销申请":
                    let vc = CLOrderRefundAlertController()
                    vc.isHasDesLabel = false
                    self.customPresentViewController(cancelPresenter, viewController: vc, animated: true, completion: nil)
                case "修改申请":
                    return
                case "退款进度":
                    return
                default:
                    return
                }

            }
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
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch cellModel[indexPath.row]{
        //外卖
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
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}
