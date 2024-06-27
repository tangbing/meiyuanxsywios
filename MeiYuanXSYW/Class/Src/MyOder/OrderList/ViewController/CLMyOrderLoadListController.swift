//
//  LoadDataListViewController.swift
//  JXSegmentedView
//
//  Created by jiaxin on 2019/1/7.
//  Copyright © 2019 jiaxin. All rights reserved.
//

import UIKit
import JXSegmentedView
import Kingfisher
import Presentr
import MJRefresh
import Moya
import SwiftyJSON
import QMUIKit

class CLMyOrderLoadListController: XSBaseViewController {
    var pageNumber = 0
    var index:Int = 0

    var cellModel:[CLMyOrderShopType] = []
    var model:[CLMyOrderListModel] = []
    
    var orderStatus:Int = 0
    var bizType:Int = 0


    lazy var addrPresenter: Presentr = {
        let width = ModalSize.full
        let height = ModalSize.fluid(percentage: 0.6)
        let center = ModalCenterPosition.customOrigin(origin: CGPoint(x: 0, y: screenHeight * 0.4))
        let customType = PresentationType.custom(width: width, height: height, center: center)
        let presenter = Presentr(presentationType: customType)
        presenter.transitionType = .coverVertical
        presenter.dismissTransitionType = .coverVertical
        presenter.backgroundOpacity = 0.7
        presenter.roundCorners = true
        presenter.cornerRadius = 10
        return presenter
      }()
    
    lazy var timePresenter: Presentr = {
        let width = ModalSize.full
        let height = ModalSize.fluid(percentage: 0.5)
        let center = ModalCenterPosition.customOrigin(origin: CGPoint(x: 0, y: screenHeight * 0.5))
        let customType = PresentationType.custom(width: width, height: height, center: center)
        let presenter = Presentr(presentationType: customType)
        presenter.transitionType = .coverVertical
        presenter.dismissTransitionType = .coverVertical
        presenter.backgroundOpacity = 0.7
        presenter.roundCorners = true
        presenter.cornerRadius = 10
        return presenter
      }()
         
    func holdUpModel(){
        cellModel.removeAll()
        cellModel.append(.privateKitchen(status: .waitPay, title: "待支付"))
        cellModel.append(.privateKitchen(status: .waitAppointment, title: "待预约"))
        cellModel.append(.privateKitchen(status: .DoorToDoorService, title: "待上门服务"))
        cellModel.append(.privateKitchen(status: .inservice, title: "服务中"))
        cellModel.append(.privateKitchen(status: .waitComment, title: "待评价"))
        cellModel.append(.privateKitchen(status: .orderFinish1, title: "已完成1"))
        cellModel.append(.privateKitchen(status: .orderFinish2, title: "已完成2"))
        cellModel.append(.privateKitchen(status: .refundReview, title: "退款审核中"))
        cellModel.append(.privateKitchen(status: .refunding, title: "退款中"))
        cellModel.append(.privateKitchen(status: .refundReject, title: "退款被驳回"))
        cellModel.append(.privateKitchen(status: .refundSuccess, title: "退款成功"))
        cellModel.append(.privateKitchen(status: .orderClose, title: "订单已关闭"))

        cellModel.append(.groupBuy(status: .waitPay, title: "待支付"))
        cellModel.append(.groupBuy(status: .orderFinish1, title: "已完成"))
        cellModel.append(.groupBuy(status: .orderFinish2, title: "已完成"))
        cellModel.append(.groupBuy(status: .orderClose, title: "订单已关闭"))
        cellModel.append(.groupBuy(status: .refundReview, title: "退款审核中"))
        cellModel.append(.groupBuy(status: .refunding, title: "退款中"))
        cellModel.append(.groupBuy(status: .refundSuccess, title: "退款成功"))
        cellModel.append(.groupBuy(status: .refundReject, title: "退款申请被驳回"))
        cellModel.append(.groupBuy(status: .waitUse, title: "待使用"))
        cellModel.append(.groupBuy(status: .waitComment, title: "待评论"))

        cellModel.append(.deliver(status: .waitPay,title: "待支付"))
        cellModel.append(.deliver(status:.waitMerchantReceiverOrder,title:"等待商家接单"))
        cellModel.append(.deliver(status:.waitRiderReceiverOrder,title:"等待骑手接单"))
        cellModel.append(.deliver(status:.merchentPrepareMeal,title: "商家备餐中"))
        cellModel.append(.deliver(status:.waitUserTakeMeal,title: "待取餐"))
        cellModel.append(.deliver(status:.riderDeliver,title:"骑手配送中"))
        cellModel.append(.deliver(status:.merchantDeliver,title:"商家配送中"))
        cellModel.append(.deliver(status:.waitComment,title:"待评价"))
        cellModel.append(.deliver(status:.orderFinish1,title:"已完成"))
        cellModel.append(.deliver(status:.orderFinish2,title:"已完成"))
        cellModel.append(.deliver(status:.refundReview,title:"退款审核中"))
        cellModel.append(.deliver(status:.refunding,title:"退款中"))
        cellModel.append(.deliver(status:.refundSuccess,title:"退款成功"))
        cellModel.append(.deliver(status:.refundReject,title:"退款被驳回"))
        cellModel.append(.deliver(status:.orderClose,title:"订单已关闭"))
        cellModel.append(.deliver(status:.waitTakeMeal,title:"等待自取"))

        cellModel.append(.member(type: "会员卡"))
        cellModel.append(.member(type: "会员卡"))

        cellModel.append(.allType(status: "待支付"))
        cellModel.append(.allType(status: "已关闭"))
    }
    
    lazy var takeMealPresenter: Presentr = {
        let width = ModalSize.customOrientation(sizePortrait: 325, sizeLandscape: 325)
        let height = ModalSize.customOrientation(sizePortrait: 325, sizeLandscape: 325)
        let center = ModalCenterPosition.center
        let customType = PresentationType.custom(width: width, height: height, center: center)
        let presenter = Presentr(presentationType: customType)
        presenter.transitionType = .custom(CLCustomAnimation.init(options: AnimationOptions.normal(duration: 0.25)))
        presenter.dismissTransitionType = .custom(CLCustomAnimation.init(options: AnimationOptions.normal(duration: 0.25)))
        presenter.backgroundOpacity = 0.7
        presenter.roundCorners = true
        presenter.cornerRadius = 10
        return presenter
      }()
    
    lazy var groupBuyVoucherPresenter: Presentr = {
        let width = ModalSize.customOrientation(sizePortrait: 325, sizeLandscape: 325)
        let height = ModalSize.customOrientation(sizePortrait: 325, sizeLandscape: 325)
        let center = ModalCenterPosition.center
        let customType = PresentationType.custom(width: width, height: height, center: center)
        let presenter = Presentr(presentationType: customType)
        presenter.transitionType = .custom(CLCustomAnimation.init(options: AnimationOptions.normal(duration: 0.25)))
        presenter.dismissTransitionType = .custom(CLCustomAnimation.init(options: AnimationOptions.normal(duration: 0.25)))
        presenter.backgroundOpacity = 0.7
        presenter.roundCorners = true
        presenter.cornerRadius = 10
        return presenter
      }()
    
    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = UIColor.lightBackground
        $0.register(cellType: CLMyOrderCell.self)
        $0.register(cellType: CLMyOrderGroupBuyCell.self)
        $0.register(cellType: CLMyOrderMemberCell.self)
        $0.separatorStyle = .none
    }

    
    // 顶部刷新
    @objc func headerRefresh(){
        print("下拉刷新")
        self.tableView.uHead.endRefreshing()
    }
    @objc func footerRefresh(){
        print("上拉刷新")
        pageNumber += 1
        cellModel.append(.deliver(status:.orderFinish1,title:"已完成"))
        CLCountDownManager.sharedManager.reloadSourceWithIdentifier(identifier: "CLPagingSource\(index)\(pageNumber)")
        self.tableView.reloadData()
        self.tableView.uHead.endRefreshing()
    }
    func loadData(dic:[String:Any]){
        XSTipsHUD.showLoading("", inView: self.view)
                  
        tableView.uempty = UEmptyView(description: "暂无数据")
        tableView.uempty?.emptyState = .noDataState
        tableView.uempty?.allowShow = true
        
        uLog(dic)
        myOrderProvider.request(.getOrderMerchantByStatus(dic)) { result in
            switch result {
            case let .success(response):
                guard let jsonData = try? JSON(data: response.data) else {
                    return
                }
                if  jsonData["resp_code"].intValue == 0{
                    let jsonObj = jsonData["data"]["data"]
                    self.model.removeAll()
                    self.cellModel.removeAll()
                    self.model = jsonObj.arrayValue.compactMap { CLMyOrderListModel(jsonData: $0) }
//                    XSTipsHUD.showSucceed("加载成功")

                    XSTipsHUD.hideAllTips()

                    self.dealModel()
                }else{
                    XSTipsHUD.showText(jsonData["resp_msg"].stringValue)
                }


             case let .failure(error):
                //网络连接失败，提示用户
                print("网络连接失败\(error)")
            }
        }
    }
    
    
    func getOrderAgain(){
        
        let dic = ["merchantOrderSn":"SJ685577236970995713"]
        
        myOrderProvider.request(.getOrderAgain(dic)) { result in
            switch result {
            case let .success(response):
                guard let jsonData = try? JSON(data: response.data) else {
                    return
                }
                if  jsonData["resp_code"].intValue == 0{
                    let bool = jsonData["data"]["trueOrFalse"].intValue
                    if bool == 0 {
                        XSTipsHUD.showText("操作成功")
                    }else{
                        XSTipsHUD.showText("操作失败")
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
    
    
    func pushOrder(){
        
        let dic = ["merchantOrderSn":"SJ685577236970995713"]
        
        myOrderProvider.request(.pushOrder(dic)) { result in
            switch result {
            case let .success(response):
                guard let jsonData = try? JSON(data: response.data) else {
                    return
                }
                if  jsonData["resp_code"].intValue == 0{
                    let bool = jsonData["data"]["trueOrFalse"].intValue
                    if bool == 0 {
                        XSTipsHUD.showText("操作成功")
                    }else{
                        XSTipsHUD.showText("操作失败")
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
    
    
    func dealModel(){

        for item in self.model {
            if item.bizType == "0" { //外卖
                switch item.orderStatus {
                case "0":
                    self.cellModel.append(.deliver(status:.waitPay,title:"待支付"))
                case "1":
                    self.cellModel.append(.deliver(status:.waitComment,title: "待评价"))
                case "2":
                    self.cellModel.append(.deliver(status:.orderFinish1,title:"已完成"))
                case "3":
//                    item.orderReturnVOList
                    break
                case "4":
                    self.cellModel.append(.deliver(status:.orderClose,title:"订单已关闭"))
                case "5":
                    self.cellModel.append(.deliver(status:.waitMerchantReceiverOrder,title: "等待商家接单"))
                case "6":
                    self.cellModel.append(.deliver(status:.waitRiderReceiverOrder,title: "等待骑手接单"))
                case "7":
                    self.cellModel.append(.deliver(status:.merchentPrepareMeal,title: "商家备餐中"))
                case "8":
                    if item.distributionWay == "1"{
                        self.cellModel.append(.deliver(status:.merchantDeliver,title: "商家配送中"))
                    }else{
                        self.cellModel.append(.deliver(status:.riderDeliver,title: "骑手配送中"))
                    }
                case "9":
                    self.cellModel.append(.deliver(status:.waitUserTakeMeal,title: "待取餐"))
                case "10":
                    self.cellModel.append(.deliver(status:.waitTakeMeal,title: "等待自取"))
                case "20":
                    cellModel.append(.deliver(status: .refundReview, title: "退款审核中"))
                case "21":
                    cellModel.append(.deliver(status: .refunding, title: "退款中"))
                case "22":
                    cellModel.append(.deliver(status: .refundSuccess, title: "退款成功"))
                case "23":
                    cellModel.append(.deliver(status: .refundReject, title: "退款被驳回"))
                case "98":
                    cellModel.append(.deliver(status: .orderClose, title: "订单已关闭"))

                default:
                    break
                }
            }else if item.bizType == "1"{ //团购
                switch item.orderStatus {
                case "0":
                    self.cellModel.append(.groupBuy(status: .waitPay, title: "待支付"))
                case "1":
                    self.cellModel.append(.groupBuy(status: .waitComment, title: "待评论"))
                case "2":
                    self.cellModel.append(.groupBuy(status: .orderFinish1, title: "已完成"))
                case "3":
                    break
                case "4":
                    self.cellModel.append(.groupBuy(status: .orderClose, title: "订单已关闭"))
                case "5":
                    self.cellModel.append(.groupBuy(status: .waitUse, title: "待使用"))
                case "11":
                    self.cellModel.append(.groupBuy(status: .waitUse, title: "待使用"))
                case "20":
                    cellModel.append(.groupBuy(status: .refundReview, title: "退款审核中"))
                case "21":
                    cellModel.append(.groupBuy(status: .refunding, title: "退款中"))
                case "22":
                    cellModel.append(.groupBuy(status: .refundSuccess, title: "退款成功"))
                case "23":
                    cellModel.append(.groupBuy(status: .refundReject, title: "退款被驳回"))
                case "98":
                    self.cellModel.append(.groupBuy(status: .orderClose, title: "订单已关闭"))
                default:
                    break
                }
                
            }else if item.bizType == "2"{ //私厨
                switch item.orderStatus {
                case "0":
                    self.cellModel.append(.privateKitchen(status: .waitPay, title: "待支付"))
                case "11":
                    self.cellModel.append(.privateKitchen(status: .waitAppointment, title: "待预约"))
                case "12":
                    self.cellModel.append(.privateKitchen(status: .DoorToDoorService, title: "待上门服务"))
                case "13":
                    self.cellModel.append(.privateKitchen(status: .inservice, title: "服务中"))
                case "1":
                    self.cellModel.append(.privateKitchen(status: .waitComment, title: "待评价"))
                case "2":
                    self.cellModel.append(.privateKitchen(status: .orderFinish1, title: "已完成1"))
                case "3":
                    break
                case "4":
                    self.cellModel.append(.privateKitchen(status: .orderClose, title: "订单已关闭"))
                case "5":
                    self.cellModel.append(.privateKitchen(status: .DoorToDoorService, title: "待上门服务"))
                case "20":
                    cellModel.append(.privateKitchen(status: .refundReview, title: "退款审核中"))
                case "21":
                    cellModel.append(.privateKitchen(status: .refunding, title: "退款中"))
                case "22":
                    cellModel.append(.privateKitchen(status: .refundSuccess, title: "退款成功"))
                case "23":
                    cellModel.append(.privateKitchen(status: .refundReject, title: "退款被驳回"))
                case "98":
                    cellModel.append(.privateKitchen(status: .orderClose, title: "订单已关闭"))

                default :
                    break
                }
            }else if item.bizType == "4"{ //会员
                cellModel.append(.member(type: "会员卡"))
            }else if item.bizType == "5"{
                cellModel.append(.allType(status: "待支付"))
            }
        }

        DispatchQueue.main.async {
//            self.holdUpModel()
            self.tableView.reloadData()
        }
    }
    func loadData(index:Int){
        var dic:[String:Any] = [:]
        if index == 0 { //全部
            dic = ["userId":0]
        }else if index == 1{ //待支付
            dic = ["orderStatus":0,"userId":0]
            self.orderStatus = 0
        }else if index == 2{ //待使用
            dic = ["orderStatus":11,"userId":0]
            self.orderStatus = 11
        }else if index == 3 { //待评价
            dic = ["orderStatus":1,"userId":0]
            self.orderStatus = 1
        }else if index == 4 { //退款/售后
            dic = ["orderStatus":3,"userId":0]
            self.orderStatus = 3
            
        }else if index == 5 {
            dic = ["orderStatus":self.orderStatus,"userId":0]
            
        }else if index == 6 {
            dic = ["orderStatus":self.orderStatus,"bizType":0,"userId":0]
            self.bizType = 0
        }else if index == 7 {
            dic = ["orderStatus":self.orderStatus,"bizType":1,"userId":0]
            self.bizType = 1
        }else if index == 8 {
            dic = ["orderStatus":self.orderStatus,"bizType":2,"userId":0]
            self.bizType = 2
        }else if index == 9 {
            dic = ["orderStatus":self.orderStatus,"bizType":4,"userId":0]
            self.bizType = 4
        }
        self.loadData(dic: dic)
    }
    
    
    deinit{
        CLCountDownManager.sharedManager.removeAllSource()
        CLCountDownManager.sharedManager.invalidate()
    }
        
    override func viewDidLoad() {
        CLCountDownManager.sharedManager.start()
        CLCountDownManager.sharedManager.addSourceWithIdentifier(identifier: "CLPagingSource\(index)\(pageNumber)")
        uLog(CLCountDownManager.sharedManager.timeIntervalDict)
        loadData(index: self.index)
        
        self.view.addSubview(tableView)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        

        
        tableView.uHead = URefreshAutoHeader(refreshingBlock: { [weak self] in
             guard let self = self else { return }
            self.tableView.uHead.endRefreshing()
         })

        tableView.uFoot = URefreshAutoFooter(refreshingBlock: { [weak self] in
             guard let self = self else { return }
            self.tableView.uFoot.endRefreshing()

         })

        
        tableView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
    
    func removeCell(_ title:String,_ message:String,tableView:UITableView,indexPath:IndexPath){
        self.showAlert(title: title, message: message, alertType: .alert, sureBlock: {[unowned self] in
            self.cellModel.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            self.tableView.reloadData()
        }, cancelBlock: nil)
    }
}



extension CLMyOrderLoadListController {
    func enterCommentVC(bizType:String){
        let vc = CLMyOrderCommentController()
        vc.bizType = bizType
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func enterRefundProgressVC(){
        let vc = CLMyOrderRefundProgressDetailController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension CLMyOrderLoadListController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch cellModel[indexPath.row] {
        case .deliver(let status,let title):
        
            uLog(status)
            let cell:CLMyOrderCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderCell.self)
            cell.type = .deliver(status:status,title:title)
            cell.model = self.model[indexPath.row]
            if self.model[indexPath.row].orderStatus == "0" {
                cell.source = "CLPagingSource\(index)\(pageNumber)"
            }
            cell.selectView.clickEvent = {[unowned self] title in
                uLog(title)
                switch title {
                case "修改地址":
                    let vc  = CLMyOrderAddressSelectController()
                    self.customPresentViewController(self.addrPresenter, viewController: vc, animated: true)
                case "退款进度":
                    self.enterRefundProgressVC()
                case "评价":
                    self.enterCommentVC(bizType:self.model[indexPath.row].bizType)
                case "申请售后":
                    let vc = CLDeliverRequestRefundController()
                    vc.goodModel = self.model[indexPath.row].orderGoodsDetailVOList
                    self.navigationController?.pushViewController(vc, animated: true)
                case "取消订单":
                    self.removeCell("取消订单", "是否取消订单?", tableView: tableView, indexPath: indexPath)
                case "催单":
                    self.pushOrder()
                case "删除订单":
                    self.removeCell("删除订单", "是否删除订单?", tableView: tableView, indexPath: indexPath)
                case "再来一单":
                    self.getOrderAgain()
                case "支付":
                    let vc = CLOrderSubmitDeliverController()
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                case "取餐码":
                    let vc  = CLTakeMealCodeView()
                    self.customPresentViewController(self.takeMealPresenter, viewController: vc, animated: true)
                    return
                default:
                    return
                }

            }
            return cell
            
        case .groupBuy(let status,let title):
            let cell:CLMyOrderGroupBuyCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderGroupBuyCell.self)
            cell.type = .groupBuy(status: status,title:title)
            cell.model = self.model[indexPath.row]
            if self.model[indexPath.row].orderStatus == "0" {
                cell.source = "CLPagingSource\(index)\(pageNumber)"
            }
            cell.selectView.clickEvent = {[unowned self] title in
                switch title {
                case  "评价":
                    self.enterCommentVC(bizType:self.model[indexPath.row].bizType)
                case  "退款进度":
                    self.enterRefundProgressVC()
                case "申请售后":
                    let vc = CLGroupBuyRequestRefundController()
                    self.navigationController?.pushViewController(vc, animated: true)
                case "重新申请":
                    return
                case "查看券码":
                    let vc  = CLGroupBuyVoucherView()
                    self.customPresentViewController(self.groupBuyVoucherPresenter, viewController: vc, animated: true)
                case "支付":
                    let vc = CLOrderSubmitGroupBuyController()
                    self.navigationController?.pushViewController(vc, animated: true)
                case "取消订单":
                    self.removeCell("取消订单", "是否取消订单?", tableView: tableView, indexPath: indexPath)
                case "再来一单":
                    self.getOrderAgain()
                case "删除订单":
                    self.removeCell("删除订单", "是否删除订单?", tableView: tableView, indexPath: indexPath)
                default :
                    return
                }
            }

            return cell
        case .privateKitchen(let status,let title):
            let cell:CLMyOrderCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderCell.self)
            cell.type = .privateKitchen(status: status,title: title)
            cell.model = self.model[indexPath.row]
            if self.model[indexPath.row].orderStatus == "0" {
                cell.source = "CLPagingSource\(index)\(pageNumber)"
            }
            cell.selectView.clickEvent = {[unowned self] title in
                switch title {
                case  "评价":
                    self.enterCommentVC(bizType:self.model[indexPath.row].bizType)
                case  "预约": break
                case "修改预约信息":
                    let vc = CLMyOrderTimeSelectController()
                    self.customPresentViewController(self.timePresenter, viewController: vc, animated: true)
                case "支付":
                    let vc = CLOrderSubmitPrivateKitchenController()
                    self.navigationController?.pushViewController(vc, animated: true)
                case "取消订单":
                    self.removeCell("取消订单", "是否取消订单?", tableView: tableView, indexPath: indexPath)
                case "再来一单":
                    self.getOrderAgain()
                case "删除订单":
                    self.removeCell("删除订单", "是否删除订单?", tableView: tableView, indexPath: indexPath)
                case "申请售后":
                    let vc = CLDeliverRequestRefundController()
                    vc.goodModel = self.model[indexPath.row].orderGoodsDetailVOList
                    self.navigationController?.pushViewController(vc, animated: true)
                case "重新申请":
                    return
                default :
                    return
                }
            }
            return cell
        case .member(type: let type):
            let cell:CLMyOrderMemberCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderMemberCell.self)
            cell.type = .member(type:type)
//            cell.model = self.model[indexPath.row]
            cell.selectView.clickEvent = {[unowned self] title in
                uLog(title)
                switch title {
                case "再来一单":
                    self.getOrderAgain()
                case "删除订单":
                    self.removeCell("删除订单", "是否删除订单?", tableView: tableView, indexPath: indexPath)
                default:
                    return
                }

            }
            return cell
        case .allType(status: let status):
            let cell:CLMyOrderCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderCell.self)
            cell.type = .allType(status:status)
            cell.model = self.model[indexPath.row]
            cell.selectView.clickEvent = {[unowned self] title in
                uLog(title)
                switch title {
                case "删除订单":
                    self.removeCell("删除订单", "是否删除订单?", tableView: tableView, indexPath: indexPath)
                case "再来一单":
                    self.getOrderAgain()
                case "合并支付":
                    let vc = CLOrderSubmitAllTypeController()
                    self.navigationController?.pushViewController(vc, animated: true)
                default:
                    return
                }

            }
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch cellModel[indexPath.row] {
        case .deliver:
            return 228
        case .groupBuy:
            return 206
        case .privateKitchen:
            return 228
        case .member:
            return 206
        case .allType:
            return 228
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch cellModel[indexPath.row] {
        case .deliver(let status,_):
            switch status {
            case .waitPay:
                let vc = CLDeliverWaitPayDetailController()
                vc.merchantOrderSn = self.model[indexPath.row].merchantOrderSn
//                vc.model = self.model[indexPath.row]
                self.navigationController?.pushViewController(vc, animated: true)
            case .waitMerchantReceiverOrder,.waitRiderReceiverOrder,.merchentPrepareMeal,.merchantDeliver,.riderDeliver,.waitUserTakeMeal,.waitComment,.orderFinish1,.orderFinish2,.orderClose,.refundReview,.refunding,.refundReject,.refundSuccess:
               let vc =  CLDeliverDetailController()
                vc.merchantOrderSn = self.model[indexPath.row].merchantOrderSn
                vc.status = status
                self.navigationController?.pushViewController(vc, animated: true)
//            case .refundReview,.refunding,.refundReject,.refundSuccess:
//                let vc =  CLDeliverRefundDetailController()
//                 vc.status = status
//                 self.navigationController?.pushViewController(vc, animated: true)
            default:
                return
            }
        case .groupBuy(status: let status,_):
            switch status {
            case .waitPay:
                let vc  = CLGroupByWaitPayController()
                vc.merchantOrderSn = self.model[indexPath.row].merchantOrderSn
                self.navigationController?.pushViewController(vc, animated: true)
                
            case .orderFinish1,.orderFinish2,.orderClose,.waitUse,.waitComment:
                 let vc = CLGroupBuyOrderDetailController()
                vc.merchantOrderSn = self.model[indexPath.row].merchantOrderSn

                vc.status = status
                self.navigationController?.pushViewController(vc,animated: true)
                
            case .refundReview,.refunding,.refundReject,.refundSuccess:
                let vc =  CLGroupBuyRefundDetailController()
//                vc.merchantOrderSn = self.model[indexPath.row].merchantOrderSn

                 vc.status = status
                 self.navigationController?.pushViewController(vc, animated: true)
            default:
                return
            }
            
        case .privateKitchen(status: let status,_):
            switch status {
            case .waitPay:
                let vc = CLPrivateKitchenWaitPayController()
                vc.merchantOrderSn = self.model[indexPath.row].merchantOrderSn
                self.navigationController?.pushViewController(vc, animated: true)
            case .orderFinish1,.orderFinish2,.orderClose,.waitAppointment,.waitComment,.DoorToDoorService,.inservice,.refundReview,.refunding,.refundReject,.refundSuccess:
                let vc = CLPrivateKitchenOrderDetailController()
                 vc.merchantOrderSn = self.model[indexPath.row].merchantOrderSn

                vc.status = status
                self.navigationController?.pushViewController(vc, animated: true)
//            case .refundReview,.refunding,.refundReject,.refundSuccess:
//                let vc =  CLPrivateKitchenRefundDetailController()
//                 vc.status = status
//                 self.navigationController?.pushViewController(vc, animated: true)
            default:
                return
            }
        case .member(type: let type):
            self.navigationController?.pushViewController(CLMyOrderMemberDetailController(), animated: true)
        case .allType(status: let status):
            self.navigationController?.pushViewController(CLMultypleOrderWaitPayController(), animated: true)
            
        }
    }
}

extension CLMyOrderLoadListController: JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return view
    }

    func listDidAppear() {
        //因为`JXSegmentedListContainerView`内部通过`UICollectionView`的cell加载列表。当切换tab的时候，之前的列表所在的cell就被回收到缓存池，就会从视图层级树里面被剔除掉，即没有显示出来且不在视图层级里面。这个时候MJRefreshHeader所持有的UIActivityIndicatorView就会被设置hidden。所以需要在列表显示的时候，且isRefreshing==YES的时候，再让UIActivityIndicatorView重新开启动画。
//        if (self.tableView.mj_header.isRefreshing) {
//            UIActivityIndicatorView *activity = [self.tableView.mj_header valueForKey:@"loadingView"];
//            [activity startAnimating];
//        }

//        print("listDidAppear")
    }

    func listDidDisappear() {
//        print("listDidDisappear")
    }
}
