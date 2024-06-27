//
//  CLDeliverWaitPayDetailController.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/3.
//

import UIKit
import Presentr
import SwiftyJSON
import Moya

enum DeliverWaitPay{
    case contact   // 功能
    case goodInfo  //商品信息
    case addressInfo //地址信息
    case orderInfo // 订单信息
}

class CLDeliverWaitPayDetailController: XSBaseViewController {
    
    let deliverType = "到店自取" //配送方式 => 到店自取  骑手配送  商家配送
    //配送方式.0商家配送，1骑手配送，2自取
    var cellModel:[DeliverWaitPay] = []
    
    var model:CLMyOrderListModel?

    let topView  = CLMyOrderDetailTopView()
    
    let payView = CLMyOrderDetailPayView().then{
        $0.backgroundColor = .white
    }
    
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
        self.view.addSubview(payView)
        tableView.delegate = self
        tableView.dataSource = self
        
        topView.setting("待支付", "支付剩余时间:00:02:59","wallet")
        
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


extension CLDeliverWaitPayDetailController:UITableViewDelegate,UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModel.count
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch cellModel[indexPath.row] {
        case .contact:
            let cell:CLMyOrderDetailContactCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderDetailContactCell.self)
            cell.model = [
                ["title":"取消订单","image":"close"],
                ["title":"联系商家","image":"right"],
                ["title":"客服","image":"customer_service"]]
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
        case .goodInfo:
            let cell:CLMyOrderDetailGoodInfoCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderDetailGoodInfoCell.self)
            cell.model = self.model

            return cell
        case .addressInfo:
            
            switch self.model?.distributionWay {
            case "0","1":
                let cell:CLDeliverTypeDeliverCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLDeliverTypeDeliverCell.self)
                cell.model = self.model
                return cell
            case "2":
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
            switch self.model?.distributionWay {
            case "0","1":
                return 245 + 10
            case "2":
                return 180 + 10
            default:
                return 0
            }
        case .orderInfo:
            return 181 + 10
        case .goodInfo:
//            return 641
           
            let goodHeight = (self.model?.orderGoodsDetailVOList.count ?? 0) * 110
        
            let couponHeight = (self.model?.orderCheapInfoVOList.count ?? 0) * 36
            return CGFloat(40 + 120 + 77 + goodHeight + couponHeight + 10)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
