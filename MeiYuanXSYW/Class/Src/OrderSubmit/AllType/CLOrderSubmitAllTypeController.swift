//
//  CLOrderSubmitAllTypeController.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/15.
//

import UIKit
import Presentr
import QMUIKit
import SwiftyJSON
import Moya

enum OrderSubmitAllType {
    case addrSelect
    case timeSelect
    case head(_ type:CLMyOrderShopType)
    case goodInfo
    case pakageInfo
    case totalPrice
    case discountInfoHead
    case discountQesCell
    case coupon
    case memberCoupon
    case couponNotice
    case discountTotal
    case memberCard
    case remark
}

class CLOrderSubmitAllTypeController: XSBaseViewController {
    var cellModel:[OrderSubmitAllType] = []

    let payView = CLMyOrderDetailPayView().then{
        $0.backgroundColor = .white
    }
    var idList:[Int] = []
    
    var model:CLOrderSubmitModel?

//    lazy var exchangeView = CLUpgradeMemberExchangeView()
    
    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = .lightBackground
        $0.register(cellType: CLAllTypeAddrSelectCell.self)
        $0.register(cellType: CLAllTypeTimeSelectCell.self)
        $0.register(cellType: CLOrderSubmitGoodInfoHeadCell.self)
        $0.register(cellType: CLOrderSubmitDeliverGoodInfoGoodCell.self)
        $0.register(cellType: CLOrderPakageFeeCell.self)
        $0.register(cellType: CLOrderTotalPriceCell.self)
        $0.register(cellType: CLOrderDiscountInfoHeadCell.self)
        $0.register(cellType: CLOrderDiscountQesCell.self)
        $0.register(cellType: CLOrderCouponCell.self)
        $0.register(cellType: CLOrderMemberCouponCell.self)
        $0.register(cellType: CLOrderCouponNoticeCell.self)
        $0.register(cellType: CLOrderDiscountTotalCell.self)

        $0.register(cellType: CLOrderSubmitMemberCardCell.self)
        $0.register(cellType: CLOrderSubmitDeliverMarkCell.self)
    
        $0.separatorStyle = .none
    }
    lazy var upgradePresenter: Presentr = {
        let width = ModalSize.full
        let height = ModalSize.fluid(percentage: 0.7)
        let center = ModalCenterPosition.customOrigin(origin: CGPoint(x: 0, y: screenHeight * 0.3))
        let customType = PresentationType.custom(width: width, height: height, center: center)
        let presenter = Presentr(presentationType: customType)
        presenter.transitionType = .coverVertical
        presenter.dismissTransitionType = .coverVertical
        presenter.backgroundOpacity = 0.4
        presenter.roundCorners = true
        presenter.cornerRadius = 12
        return presenter
      }()
    
    
    lazy var myCouponPresenter: Presentr = {
        let width = ModalSize.full
        let height = ModalSize.fluid(percentage: 0.6)
        let center = ModalCenterPosition.customOrigin(origin: CGPoint(x: 0, y: screenHeight * 0.4))
        let customType = PresentationType.custom(width: width, height: height, center: center)
        let presenter = Presentr(presentationType: customType)
        presenter.transitionType = .coverVertical
        presenter.dismissTransitionType = .coverVertical
        presenter.backgroundOpacity = 0.4
        presenter.roundCorners = true
        presenter.cornerRadius = 12
        return presenter
      }()
    
    private func receievNotify(){
        let red = NSNotification.Name(rawValue:"red")
        NotificationCenter.default.addObserver(self, selector: #selector(exchangeRed), name: red, object: nil)
    }
    @objc func exchangeRed(){
        let width:Int = Int(screenWidth - 64);
        let modalViewController = QMUIModalPresentationViewController()
        let contentView = XSVipCardExchangeView()
        contentView.frame = CGRect(x: 32, y: 0, width: width, height: 350)
        modalViewController.contentView = contentView;
        present(modalViewController, animated: false, completion: nil)
    }
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("red"), object: nil)
    }
    
    override func initSubviews() {
        self.navigationTitle = "订单确认"
        self.view.addSubview(tableView)
        self.view.addSubview(payView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        payView.submitClock = {[unowned self] in
            self.navigationController?.pushViewController(CLSubmitPayController(), animated: true)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        payView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(65)
        }
        
        tableView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.view.usnp.top)
            make.bottom.equalTo(payView.snp.top).offset(-10)
        }
    }

    override func initData() {
        cellModel.append(.addrSelect)

        // 私厨
        cellModel.append(.head(.privateKitchen(status:.waitPay,title: "")))
        cellModel.append(.timeSelect)
        cellModel.append(.goodInfo)
        cellModel.append(.totalPrice)
        cellModel.append(.discountInfoHead)
        cellModel.append(.discountQesCell)
        cellModel.append(.coupon)
        cellModel.append(.coupon)
        cellModel.append(.coupon)
        cellModel.append(.coupon)
        cellModel.append(.memberCoupon)
        cellModel.append(.couponNotice)
        cellModel.append(.discountTotal)
        //外卖
        cellModel.append(.head(.deliver(status:.waitPay,title: "")))
        cellModel.append(.timeSelect)
        cellModel.append(.goodInfo)
        cellModel.append(.pakageInfo)
        cellModel.append(.totalPrice)
        cellModel.append(.discountInfoHead)
        cellModel.append(.discountQesCell)
        cellModel.append(.coupon)
        cellModel.append(.coupon)
        cellModel.append(.coupon)
        cellModel.append(.coupon)
        cellModel.append(.memberCoupon)
        cellModel.append(.couponNotice)
        cellModel.append(.discountTotal)
        //团购
        cellModel.append(.head(.groupBuy(status:.waitPay,title:"")))
        cellModel.append(.goodInfo)
        cellModel.append(.totalPrice)
        cellModel.append(.discountInfoHead)
        cellModel.append(.discountQesCell)
        cellModel.append(.coupon)
        cellModel.append(.coupon)
        cellModel.append(.coupon)
        cellModel.append(.coupon)
        cellModel.append(.memberCoupon)
        cellModel.append(.couponNotice)
        cellModel.append(.discountTotal)
        
        cellModel.append(.memberCard)
        cellModel.append(.remark)
        self.tableView.reloadData()
    }

}
extension CLOrderSubmitAllTypeController:UITableViewDelegate,UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModel.count
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch cellModel[indexPath.row] {
        case .addrSelect:
            let cell:CLAllTypeAddrSelectCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLAllTypeAddrSelectCell.self)
            return cell
        case .timeSelect:
            let cell:CLAllTypeTimeSelectCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLAllTypeTimeSelectCell.self)
            return cell
        case .head(let type):
            let cell:CLOrderSubmitGoodInfoHeadCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLOrderSubmitGoodInfoHeadCell.self)
            cell.line.isHidden = true
            cell.type = type
            return cell
        case .goodInfo:
            let cell:CLOrderSubmitDeliverGoodInfoGoodCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLOrderSubmitDeliverGoodInfoGoodCell.self)
            cell.des.isHidden = false
            cell.discountDes.isHidden = false
            return cell
        case .memberCard:
            let cell:CLOrderSubmitMemberCardCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLOrderSubmitMemberCardCell.self)
       
            return cell
        case .remark:
            let cell:CLOrderSubmitDeliverMarkCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLOrderSubmitDeliverMarkCell.self)
       
            return cell
        case .pakageInfo:
            let cell:CLOrderPakageFeeCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLOrderPakageFeeCell.self)
       
            return cell
        case .totalPrice:
            let cell:CLOrderTotalPriceCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLOrderTotalPriceCell.self)
       
            return cell
        case .discountInfoHead:
            let cell:CLOrderDiscountInfoHeadCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLOrderDiscountInfoHeadCell.self)
       
            return cell
        case .discountQesCell:
            let cell:CLOrderDiscountQesCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLOrderDiscountQesCell.self)
       
            return cell
        case .coupon:
            let cell:CLOrderCouponCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLOrderCouponCell.self)
       
            return cell
        case .memberCoupon:
            let cell:CLOrderMemberCouponCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLOrderMemberCouponCell.self)
            cell.upgradBlock  = {[unowned self] in
                let vc  = CLUpgradeMemberController()
                self.customPresentViewController(self.upgradePresenter, viewController: vc, animated: true)
            }
       
            return cell
        case .couponNotice:
            let cell:CLOrderCouponNoticeCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLOrderCouponNoticeCell.self)
       
            return cell
        case .discountTotal:
            let cell:CLOrderDiscountTotalCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLOrderDiscountTotalCell.self)
       
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch cellModel[indexPath.row]{
        case .addrSelect:
            return 70
        case .timeSelect:
            return 90
        case .head:
            return 46
        case .goodInfo:
            return 100
        case .pakageInfo:
            return 77
        case .memberCard:
            return 160
        case .remark:
            return 62
        case .totalPrice:
            return 37
        case .discountInfoHead:
            return 40
        case .discountQesCell:
            return 46
        case .coupon:
            return 40
        case .memberCoupon:
            return 40
        case .couponNotice:
            return 26
        case .discountTotal:
            return 48
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch cellModel[indexPath.row] {
        case .coupon:
            let vc  = CLMyCouponController()
            self.customPresentViewController(self.myCouponPresenter, viewController: vc, animated: true)
        default:
            return
        }
    }
}
extension CLOrderSubmitAllTypeController {
    
    func loadData(){
        let dic:[String : Any] = [
            "idList":idList,
            "isSettle":true,
            "lat":22.539461,
            "lng":114.113775
        ]
        myOrderProvider.request(MyOrderService.calculateMoreCarAmt2(dic)) { result in
            switch result {
            case let .success(response):
                guard let jsonData = try? JSON(data: response.data) else {
                    return
                }
                if  jsonData["resp_code"].intValue == 0{
                    let jsonObj = jsonData["data"]
                    self.model = CLOrderSubmitModel(jsonData: jsonObj)
                    uLog(self.model)
                    
                    DispatchQueue.main.async {
                        
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
}
