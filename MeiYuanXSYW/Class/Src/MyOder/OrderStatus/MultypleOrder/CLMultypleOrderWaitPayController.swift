//
//  CLMultypleOrderWaitPayController.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/17.
//

import UIKit
import Presentr

enum MultypleOrderWaitPay{
    case contact
    case head(_ type:CLMyOrderShopType)
    case goodInfo(_ type:CLMyOrderShopType)
    case pakageInfo
    case deliverInfo
    case dropInfo
    case discountInfoHead
    case discountQesCell
    case coupon
    case memberCoupon
    case totalPrice
}

class CLMultypleOrderWaitPayController: XSBaseViewController {
        
    var cellModel:[MultypleOrderWaitPay] = []

    let topView  = CLMyOrderDetailTopView()
    
    let payView = CLMyOrderDetailPayView().then{
        $0.backgroundColor = .white
    }
    
    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = .lightBackground
        $0.register(cellType: CLMyOrderDetailContactCell.self)
        $0.register(cellType: CLOrderSubmitDeliverGoodInfoGoodCell.self)
        $0.register(cellType: CLOrderSubmitGoodInfoHeadCell.self)
        $0.register(cellType: CLOrderPakageFeeCell.self)
        $0.register(cellType: CLMultyOrderDeliverInfoCell.self)
        $0.register(cellType: CLMultyOrderDropInCell.self)
        $0.register(cellType: CLOrderDiscountInfoHeadCell.self)
        $0.register(cellType: CLOrderDiscountQesCell.self)
        $0.register(cellType: CLOrderCouponCell.self)
        $0.register(cellType: CLOrderMemberCouponCell.self)
        $0.register(cellType: CLMultyOrderTotalPriceCell.self)


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
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        topView.hg_addGradientColor([UIColor.hex(hexString: "#F6094C"),
                                            UIColor.hex(hexString: "#FF724E")],
                                           size: CGSize(width: screenWidth, height: 145 + LL_StatusBarExtraHeight),
                                    startPoint: CGPoint(x:0.5, y: 0.5),
                                           endPoint: CGPoint(x:1 , y: 1))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cellModel.append(.contact)
        
        cellModel.append(.head(.deliver(status:.waitPay,title: "")))
        cellModel.append(.goodInfo(.deliver(status:.waitPay,title: "")))
        cellModel.append(.goodInfo(.deliver(status:.waitPay,title: "")))
        cellModel.append(.pakageInfo)
        cellModel.append(.deliverInfo)
        cellModel.append(.discountInfoHead)
        cellModel.append(.discountQesCell)
        cellModel.append(.coupon)
        cellModel.append(.coupon)
        cellModel.append(.coupon)
        cellModel.append(.coupon)
        cellModel.append(.memberCoupon)
        cellModel.append(.totalPrice)
        
        //到店
        cellModel.append(.head(.groupBuy(status: .waitPay, title: "")))
        cellModel.append(.goodInfo(.groupBuy(status: .waitPay, title: "")))
        cellModel.append(.goodInfo(.groupBuy(status: .waitPay, title: "")))
        cellModel.append(.discountInfoHead)
        cellModel.append(.discountQesCell)
        cellModel.append(.coupon)
        cellModel.append(.coupon)
        cellModel.append(.coupon)
        cellModel.append(.coupon)
        cellModel.append(.memberCoupon)
        cellModel.append(.totalPrice)
        
        //私厨
        cellModel.append(.head(.privateKitchen(status:.waitPay,title: "")))
        cellModel.append(.goodInfo(.privateKitchen(status:.waitPay,title:"")))
        cellModel.append(.goodInfo(.privateKitchen(status:.waitPay,title: "")))
        cellModel.append(.dropInfo)
        cellModel.append(.discountInfoHead)
        cellModel.append(.discountQesCell)
        cellModel.append(.coupon)
        cellModel.append(.coupon)
        cellModel.append(.coupon)
        cellModel.append(.coupon)
        cellModel.append(.memberCoupon)
        cellModel.append(.totalPrice)
        
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


extension CLMultypleOrderWaitPayController:UITableViewDelegate,UITableViewDataSource{

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
 

        case .head(let type):
            let cell:CLOrderSubmitGoodInfoHeadCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLOrderSubmitGoodInfoHeadCell.self)
            cell.type = type
            return cell
        case .goodInfo(let type):
            let cell:CLOrderSubmitDeliverGoodInfoGoodCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLOrderSubmitDeliverGoodInfoGoodCell.self)
            cell.des.isHidden = true
            cell.discountDes.isHidden = true
            return cell
        case .pakageInfo:
            let cell:CLOrderPakageFeeCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLOrderPakageFeeCell.self)
       
            return cell
        case .deliverInfo:
            let cell:CLMultyOrderDeliverInfoCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMultyOrderDeliverInfoCell.self)
       
            return cell
        case .dropInfo:
            let cell:CLMultyOrderDropInCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMultyOrderDropInCell.self)
            
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
        case .totalPrice:
            let cell:CLMultyOrderTotalPriceCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMultyOrderTotalPriceCell.self)
       
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch cellModel[indexPath.row]{
        case .contact:
            return 100

        case .head(_):
            return 46
        case .goodInfo:
            return 100
        case .pakageInfo:
            return 77
        case .deliverInfo:
            return 180
        case .dropInfo:
            return 180
        case .discountInfoHead:
            return 40
        case .discountQesCell:
            return 46
        case .coupon:
            return 40
        case .memberCoupon:
            return 40
        case .totalPrice:
            return 48
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
