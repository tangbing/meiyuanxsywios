//
//  CLDeliverDetailController.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/3.
//

import UIKit
import Presentr
import SwiftyJSON
import Moya
import CoreMIDI

class CLDeliverDetailController:XSBaseViewController {
    
    let deliverType = "到店自取" //配送方式 => 到店自取  骑手配送  商家配送
    //待商家接单 待骑手接单 ,商家备餐中,商家配送中,骑手配送中,待取餐,待评价,已完成,已关闭
    var status:deliverOrderStatus = .waitPay
    var afterStatus = "售后开启" //售后开启  售后关闭
    var missOrderReason = "超时未支付" //超时未支付  商家未接单
    var cellModel:[DeliverWaitPay] = []
    var model:CLMyOrderListModel?
    let topView  = CLMyOrderDetailTopView()
    var contactData:[[String:String]] = []
    var merchantOrderSn:String = ""
    
    lazy var addrPresenter: Presentr = {
        let width = ModalSize.full
        let height = ModalSize.fluid(percentage: 0.7)
        let center = ModalCenterPosition.customOrigin(origin: CGPoint(x: 0, y: screenHeight * 0.3))
        let customType = PresentationType.custom(width: width, height: height, center: center)
        let presenter = Presentr(presentationType: customType)
        presenter.transitionType = .coverVertical
        presenter.dismissTransitionType = .coverVertical
        presenter.backgroundOpacity = 0.4
        presenter.roundCorners = true
        presenter.cornerRadius = 10
        return presenter
     }()
    
    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = .lightBackground
        $0.register(cellType: CLMyOrderDetailContactCell.self)
        $0.register(cellType: CLMyOrderDetailGoodInfoCell.self)
        $0.register(cellType: CLDeliverTypeDeliverCell.self)
        $0.register(cellType: CLDeliverTypeInterShopCell.self)
        $0.register(cellType: CLMyOrderDetailOrderInfoCell.self)
        $0.separatorStyle = .none
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        topView.hg_addGradientColor([UIColor.hex(hexString: "#F6094C"),
                                            UIColor.hex(hexString: "#FF724E")],
                                           size: CGSize(width: screenWidth, height: 145 + LL_StatusBarExtraHeight),
                                    startPoint: CGPoint(x:0.5, y: 0.5),
                                           endPoint: CGPoint(x:1 , y: 1))
    }
    
    
    func setDataForTopView(){
        if status == .waitMerchantReceiverOrder{
            topView.setting("等待商家接单", "接单剩余时间:00:02:59","orders")
        }else if status == .merchentPrepareMeal{
            topView.setting("商家备餐中", "已经备餐 29分59秒","meal_preparation")
        }else if status == .waitRiderReceiverOrder{
            topView.setting("等待骑手接单","","rider")
        }else if status == .merchantDeliver{
            topView.setting("商家配送中", "已经备餐 29分59秒","rider")
        }else if status == .riderDeliver {
            topView.setting("骑手配送中", "已经备餐 29分59秒","rider")
        }else if status == .waitTakeMeal{
            topView.setting("待取餐", "","meal_preparation")
        }else if status == .waitUserTakeMeal{
            topView.setting("待取餐", "","meal_preparation")
        }else if status == .waitComment{
            topView.setting("待评论", "","information")
        }else if status == .orderFinish1 || status == .orderFinish2 {
            topView.setting("已完成", "","completed")
        }else if status == .orderClose{
            topView.setting("订单已关闭", "根据关闭类型判断","close-1")
        }
        
        else if status == .refundReview {
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
    
    func setContactData(){
        if status == .waitMerchantReceiverOrder{
            if deliverType == "骑手配送"{
                self.contactData = [
                    ["title":"取消订单","image":"close"],
                    ["title":"联系商家","image":"right"],
                    ["title":"客服","image":"customer_service"],
                    ["title":"发红包","image":"red_envelope"]]
            }else if deliverType == "到店自取"{
                self.contactData = [
                    ["title":"取消订单","image":"close"],
                    ["title":"联系商家","image":"right"],
                    ["title":"客服","image":"customer_service"]]
            }

        }else if status == .merchentPrepareMeal || status == .waitUserTakeMeal {
            if deliverType == "到店自取"{
                self.contactData = [
                    ["title":"取消订单","image":"close"],
                    ["title":"联系商家","image":"right"],
                    ["title":"客服","image":"customer_service"],
                    ["title":"取餐码","image":"take_meal"]]
            }else if deliverType == "骑手配送"{
                self.contactData = [
                    ["title":"取消订单","image":"close"],
                    ["title":"联系商家","image":"right"],
                    ["title":"客服","image":"customer_service"]]
            }
            
        }else if status == .waitComment || status == .orderFinish1 || status == .orderFinish2{
            if afterStatus == "售后开启" {
                self.contactData = [
                    ["title":"订单评价","image":"close"],
                    ["title":"发红包","image":"red_envelope"],
                    ["title":"申请售后","image":"money"],
                    ["title":"客服","image":"customer_service"]]
            }else if afterStatus == "售后关闭"{
                self.contactData = [
                    ["title":"订单评价","image":"comment"],
                    ["title":"发红包","image":"red_envelope"],
                    ["title":"客服","image":"customer_service"]]
            }
        }else if status == .orderClose{
            if missOrderReason == "超时未支付" {
                self.contactData = [
                    ["title":"重新下单","image":"close"]]
            }else if missOrderReason == "商家未接单"{
                self.contactData = [
                    ["title":"重新下单","image":"iphone"],
                    ["title":"联系商家","image":"right"],
                    ["title":"客服","image":"customer_service"]]
            }
        }else{
            self.contactData = [
                ["title":"取消订单","image":"close"],
                ["title":"联系商家","image":"right"],
                ["title":"客服","image":"customer_service"]]
        }
    }
    
    func loadData(){
        self.cellModel.removeAll()
        
        let dic = ["merchantOrderSn":self.merchantOrderSn]
        myOrderProvider.request(MyOrderService.getOrderMerchantDetailByMerchantOrderSn(dic)) { result in
            switch result {
            case let .success(response):
                guard let jsonData = try? JSON(data: response.data) else {
                    return
                }
                if  jsonData["resp_code"].intValue == 0{
                    let jsonObj = jsonData["data"]
                    self.model = CLMyOrderListModel(jsonData: jsonObj)
                    uLog(self.model)
                    DispatchQueue.main.async {
                        
                        self.cellModel.append(.contact)
                        self.cellModel.append(.goodInfo)
                        self.cellModel.append(.addressInfo)
                        self.cellModel.append(.orderInfo)
                        
                        self.tableView.reloadData()
                        
                    }
                }else{
                    XSTipsHUD.showText(jsonData["resp_msg"].stringValue)
                }

             case let .failure(error):
                //网络连接失败，提示用户
                print("网络连接失败\(error)")
            }
        }

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
            
        self.view.addSubview(topView)
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self

        setDataForTopView()
        setContactData()
        
        
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


extension CLDeliverDetailController:UITableViewDelegate,UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModel.count
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch cellModel[indexPath.row] {
        case .contact:
            let cell:CLMyOrderDetailContactCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderDetailContactCell.self)
            cell.model = self.contactData
            cell.clickBlock = {[unowned self] para in
                switch para {
                case "修改地址":
                    let vc  = CLMyOrderAddressSelectController()
                    self.customPresentViewController(self.addrPresenter, viewController: vc, animated: true)
                case "取消订单":
                    return
                case "联系商家":
                    return
                case "客服":
                    return
                case "发红包":
                    return
                case "申请售后":
                    let vc = CLDeliverRequestRefundController()
                    vc.goodModel = self.model!.orderGoodsDetailVOList
                    self.navigationController?.pushViewController(vc, animated: true)
                case "订单评价":
                    let vc = CLMyOrderCommentController()
                    vc.bizType = self.model!.bizType
                    self.navigationController?.pushViewController(vc, animated: true)
                case "重新下单":
                    return
                case "取餐码":
                    return
                case "撤销申请":break
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
            let cell:CLMyOrderDetailGoodInfoCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderDetailGoodInfoCell.self)
            cell.model = self.model

            return cell
        case .addressInfo:
            
            switch deliverType {
            case "骑手配送","商家配送":
                let cell:CLDeliverTypeDeliverCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLDeliverTypeDeliverCell.self)
                cell.model = self.model

                return cell
            case "到店自取":
                let cell:CLDeliverTypeInterShopCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLDeliverTypeInterShopCell.self)
                cell.model = self.model
                return cell
            default:
                return UITableViewCell()
            }
       
        case .orderInfo:
            let cell:CLMyOrderDetailOrderInfoCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderDetailOrderInfoCell.self)
            cell.model = self.model
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch cellModel[indexPath.row]{
        case .contact:
            return 100
        case .addressInfo:
            switch deliverType {
            case "骑手配送","商家配送":
                return 245 + 10
            case "到店自取":
                return 180 + 10
            default:
                return 0
            }
        case .orderInfo:
            return 181 + 10
        case .goodInfo:
            
             let goodHeight = (self.model?.orderGoodsDetailVOList.count ?? 0) * 110
             let couponHeight = (self.model?.orderCheapInfoVOList.count ?? 0) * 36
             return CGFloat(40 + 120 + 77 + goodHeight + couponHeight + 10) 
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
