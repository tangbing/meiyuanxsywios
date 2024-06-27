//
//  CLPrivateKitchenWaitPayController.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/9.
//

import UIKit
import Presentr
import JKSwiftExtension
import SwiftyJSON
import Moya

enum PrivateKitchenWaitPay{
    case contact   // 功能
    case reserveInfo(time:String,address:String,person:String) //有预约
    case goodInfo(model:CLMyOrderListModel)  //商品信息
    case orderInfo // 订单信息
}

class CLPrivateKitchenWaitPayController:  XSBaseViewController {
    
    let reverseType = "已预约" //是否有预约 => 已预约 没预约
    
    var cellModel:[PrivateKitchenWaitPay] = []
    var model:CLMyOrderListModel?

    let topView  = CLMyOrderDetailTopView().then{
        $0.backgroundColor = UIColor(patternImage: UIImage(named:"cartBackImg")!)
    }
    
    let payView = CLMyOrderDetailPayView().then{
        $0.backgroundColor = .white
    }
    
    var merchantOrderSn:String = ""
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
    
    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = .lightBackground
        $0.register(cellType: CLMyOrderDetailContactCell.self)
        $0.register(cellType: CLMyOrderDetailGoodInfoCell.self)
        $0.register(cellType: CLMyOrderDetailDropInInfoCell.self)
        $0.register(cellType: CLMyOrderDetailOrderInfoCell.self)
        $0.separatorStyle = .none
    }
    
    
    @objc func countDown(){
    
    }
    
    
    func loadData(){
        self.cellModel.removeAll()
        
        let dic = ["merchantOrderSn":merchantOrderSn]
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
                        self.cellModel.append(.reserveInfo(time: self.model!.arriveTime, address: self.model!.receiverProvince + self.model!.receiverCity + self.model!.receiverDetailAddress, person:self.model!.receiverName + " " + self.model!.receiverPhone))
                        self.cellModel.append(.goodInfo(model: self.model!))
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
        self.view.addSubview(payView)
        tableView.delegate = self
        tableView.dataSource = self

        topView.clickBlock = {[unowned self] in
            self.navigationController?.popViewController(animated: true)
        }
        
        topView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(145 + LL_StatusBarExtraHeight)
        }

        
        payView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(65)
        }
        
        tableView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(topView.snp.bottom)
            make.bottom.equalTo(payView.snp.top).offset(-10)
        }

    }
    
    override func preferredNavigationBarHidden() -> Bool {
        return true
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}


extension CLPrivateKitchenWaitPayController:UITableViewDelegate,UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModel.count
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch cellModel[indexPath.row] {
        case .contact:
            let cell:CLMyOrderDetailContactCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderDetailContactCell.self)
            cell.model = [
                ["title":"修改地址","image":"close"],
                ["title":"取消订单","image":"close"],
                ["title":"联系商家","image":"right"],
                ["title":"客服","image":"customer_service"]]
            cell.clickBlock = {[unowned self] para in
                switch para {
                case "修改地址":
                    let vc  = CLMyOrderAddressSelectController()
                    self.customPresentViewController(self.addrPresenter, viewController: vc, animated: true)
                case "取消订单":
                    self.showAlert(title: "取消订单", message: "是否取消订单?", alertType: .alert, sureBlock: {
                        uLog("取消订单")
                    }, cancelBlock: nil)
                case "联系商家":
                    JKGlobalTools.callPhone(phoneNumber: "17603078066") { bool in
                        uLog(bool)
                    }
                case "客服":
                    break
                default:
                    break
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

