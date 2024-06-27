//
//  CLPrivateKitchenOrderDetailController.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/9.
//

import UIKit
import Presentr
import SwiftyJSON
import Moya

class CLPrivateKitchenOrderDetailController: XSBaseViewController {
    
    let reverseType = "已预约" //是否预约 => 已预约  没预约
    //"待支付", "已完成1","已完成2","订单已关闭","待使用","待评价","服务中"
    var status:privateKitchenOrderStatus = .waitPay
    var afterStatus = "售后开启" //售后开启  售后关闭
    var cellModel:[PrivateKitchenWaitPay] = []
    var model:CLMyOrderListModel?
    var merchantOrderSn:String = ""

    let topView  = CLMyOrderDetailTopView().then{
        $0.backgroundColor = UIColor(patternImage: UIImage(named:"cartBackImg")!)
    }
    var contactData:[[String:String]] = []
    
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
        $0.register(cellType: CLMyOrderDetailDropInInfoCell.self)
        $0.register(cellType: CLMyOrderDetailOrderInfoCell.self)
        $0.separatorStyle = .none
    }
    
    func setDataForTopView(){
        if status == .waitAppointment{
            topView.setting("待预约", "","timeout_fill")
        }else if status == .DoorToDoorService{
            topView.setting("已经预约,待上门", "","timeout_fill")
        }else if status == .inservice{
            topView.setting("服务中", "","timeout_fill-1")
        }else if status == .orderClose{
            topView.setting("已关闭", "超时未支付","close-1")
        }else if status == .waitComment{
            topView.setting("待评论","","information")
        }else if status == .orderFinish1 || status == .orderFinish2 {
            topView.setting("已完成","","completed")
        }
        else if status == .refundReview {
            topView.setting("退款审核中", "退款申请正在审核中","timeout_fill")
            self.contactData = [
                ["title":"撤销申请","image":"application_canceled"],
                ["title":"修改申请","image":"application canceled"],
                ["title":"联系商家","image":"right"],
                ["title":"客服","image":"customer_service"]]
        }else if status == .refundReject{
            topView.setting("退款被驳回", "退款申请被平台驳回","close-1")
            self.contactData = [
                ["title":"再次申请","image":"notes-1"],
                ["title":"联系商家","image":"right"],
                ["title":"客服","image":"customer_service"]]
        }else if status == .refunding{
            topView.setting("退款中", "财务正在处理退款","timeout_fill")
            self.contactData = [
                ["title":"联系商家","image":"right"],
                ["title":"客服","image":"customer_service"]]
        }else if status == .refundSuccess{
            topView.setting("退款成功", "退款已经原路返回,请进入账户查看","completed")
            self.contactData = [
                ["title":"联系商家","image":"right"],
                ["title":"客服","image":"customer_service"]]
        }
    }
    
    func setContactData(){
        if status == .waitAppointment{
            self.contactData = [
                ["title":"立即预约","image":"notes"],
                ["title":"发红包","image":"red_envelope"],
                ["title":"取消订单","image":"close"],
                ["title":"联系商家","image":"right"],
                ["title":"客服","image":"customer_service"]
            ]
            
        }else if status == .DoorToDoorService{
            self.contactData = [
                ["title":"取消订单","image":"close"],
                ["title":"联系商家","image":"right"],
                ["title":"客服","image":"customer_service"]]
            
        }else if status == .inservice{
            self.contactData = [
                ["title":"联系商家","image":"right"],
                ["title":"客服","image":"customer_service"]]
            
        }else if status == .waitComment || status == .orderFinish1 || status == .orderFinish2{
            if afterStatus == "售后开启" {
                self.contactData = [
                    ["title":"订单评价","image":"comment"],
                    ["title":"发红包","image":"red_envelope"],
                    ["title":"申请售后","image":"money"],
                    ["title":"客服","image":"customer_service"]]
            }else if afterStatus == "售后关闭"{
                self.contactData = [
                    ["title":"订单评价","image":"comment"],
                    ["title":"发红包","image":"right"],
                    ["title":"客服","image":"customer_service"]]
            }
        }else if status == .orderClose{
            self.contactData = [
                ["title":"重新下单","image":"iphone"],
                ["title":"联系商家","image":"right"],
                ["title":"客服","image":"customer_service"]]
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
                        switch self.status {
                        case .orderFinish1,.orderFinish2,.orderClose,.waitAppointment,.waitComment,.DoorToDoorService,.inservice:
                            self.cellModel.append(.contact)
                            self.cellModel.append(.reserveInfo(time: self.model!.arriveTime, address: self.model!.receiverProvince + self.model!.receiverCity + self.model!.receiverDetailAddress, person:self.model!.receiverName + " " + self.model!.receiverPhone))
                            self.cellModel.append(.goodInfo(model: self.model!))
                            self.cellModel.append(.orderInfo)
                        case .refundReview,.refunding,.refundReject,.refundSuccess:
                            self.cellModel.append(.contact)
                            self.cellModel.append(.goodInfo(model: self.model!))
                            self.cellModel.append(.orderInfo)
                        case .waitPay:
                            break
                        }
                        
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
        self.loadData()
//        cellModel.append(.contact)
//        cellModel.append(.reserveInfo)
//        cellModel.append(.goodInfo)
//        cellModel.append(.orderInfo)
        setContactData()

        setDataForTopView()

        self.view.addSubview(topView)
        self.view.addSubview(tableView)
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


extension CLPrivateKitchenOrderDetailController:UITableViewDelegate,UITableViewDataSource{
    
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
                case "取消地址":
                    return
                case "联系商家":
                    return
                case "客服":
                    return
                default:
                    return
                }
                
            }
            
            return cell
        case .goodInfo(let model):
            let cell:CLMyOrderDetailGoodInfoCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderDetailGoodInfoCell.self)
            cell.model = model

            return cell
        case .orderInfo:
            let cell:CLMyOrderDetailOrderInfoCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderDetailOrderInfoCell.self)
            return cell
        case .reserveInfo(let time,let address,let person):
            let cell:CLMyOrderDetailDropInInfoCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderDetailDropInInfoCell.self)
            cell.inTime.setting("上门时间",time,false)
            cell.serviceAddress.setting("服务地点",address,false)
            cell.contactPhone.setting("联系人信息",person,false)
            return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch cellModel[indexPath.row]{
        case .contact:
            return 100
        case .reserveInfo:
            return 186
        case .orderInfo:
            return 181 + 10
        case .goodInfo:
            let goodHeight = (self.model?.orderGoodsDetailVOList.count ?? 0) * 110
        
            let couponHeight = (self.model?.orderCheapInfoVOList.count ?? 0) * 36
            
            let discountHeight = self.model?.bizType == "0" ? 120:90
            
            return CGFloat(40 + discountHeight + 77 + goodHeight + couponHeight)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
