//
//  CLOrderSubmitGroupBuyController.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/15.
//

import UIKit
import Presentr
import QMUIKit
import Moya
import SwiftyJSON

class CLSubmitGroupBuyResultModel:CLSwiftyJSONAble {

    var goodsName:String
    var payAmt:String
    var waitPayTime:Int

    required init?(jsonData: JSON) {
        goodsName = jsonData["goodsName"].stringValue
        payAmt = jsonData["payAmt"].stringValue
        waitPayTime = jsonData["waitPayTime"].intValue
    }
    
}

enum OrderSubmitGroupBuy {
    case head(name:String)
    case goodInfo(model:CLOrderGoodsDetailVOList)
    case totalPrice(goodNum:String,goodTotalPrice:String)
    case discountInfoHead
    case discountQesCell(price:String)
    case coupon(title:String,full:String,amt:String)
    case memberCoupon
    case couponNotice
    case discountTotal(price:String)
    case memberCard
    case remark
}


class CLOrderSubmitGroupBuyController: XSBaseViewController {

    var cellModel:[OrderSubmitGroupBuy] = []
    var model:CLOrderSubmitModel?

    var resultModel:CLSubmitGroupBuyResultModel?
    let payView = CLMyOrderDetailPayView().then{
        $0.backgroundColor = .white
    }
    var markCell:CLOrderSubmitDeliverMarkCell?
    var idList:[Int] = []
    var merchantId:String = ""
    var remark:String = ""
    var orderdistributionInfoList:[[String:String]] = []
//    lazy var exchangeView = CLUpgradeMemberExchangeView()
    
    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = .lightBackground
        $0.register(cellType: CLOrderSubmitGoodInfoHeadCell.self)
        $0.register(cellType: CLOrderSubmitDeliverGoodInfoGoodCell.self)
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
    var discount:Int = 4
    lazy var discountPresenter: Presentr = {
        let width = ModalSize.customOrientation(sizePortrait: 310, sizeLandscape: 310)
        let height = ModalSize.customOrientation(sizePortrait: Float(126 + discount * 22), sizeLandscape: Float(126 + discount * 22))
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
        presenter.cornerRadius = 10
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
    
    
    func loadUserInfo(){
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        receievNotify()  //接收通知
        loadData()
        self.navigationTitle = "订单确认"
//        cellModel.append(.head)
//        cellModel.append(.goodInfo)
//        cellModel.append(.totalPrice)
//        cellModel.append(.discountInfoHead)
//        cellModel.append(.discountQesCell)
//        cellModel.append(.coupon)
//        cellModel.append(.coupon)
//        cellModel.append(.coupon)
//        cellModel.append(.coupon)
//        cellModel.append(.memberCoupon)
//        cellModel.append(.couponNotice)
//        cellModel.append(.discountTotal)
//        cellModel.append(.memberCard)
//        cellModel.append(.remark)

        self.view.addSubview(tableView)
        self.view.addSubview(payView)
        
        payView.submitClock = {[unowned self] in
            
            self.saveOrder()

        }

        tableView.delegate = self
        tableView.dataSource = self

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
    
}


extension CLOrderSubmitGroupBuyController:UITableViewDelegate,UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModel.count
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch cellModel[indexPath.row] {
        case .head(let name):
            let cell:CLOrderSubmitGoodInfoHeadCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLOrderSubmitGoodInfoHeadCell.self)
            cell.shopTagLabel.text = "到店"
            cell.shopTagLabel.backgroundColor = UIColor.qmui_color(withHexString: "#F11F16")
            
            cell.shopLabel.text = name

            return cell
        case .goodInfo(let model):
            let cell:CLOrderSubmitDeliverGoodInfoGoodCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLOrderSubmitDeliverGoodInfoGoodCell.self)
            cell.des.isHidden = false
            cell.discountDes.isHidden = false
            cell.model = model
            return cell
        case .memberCard:
            let cell:CLOrderSubmitMemberCardCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLOrderSubmitMemberCardCell.self)
       
            return cell
        case .remark:
            let cell:CLOrderSubmitDeliverMarkCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLOrderSubmitDeliverMarkCell.self)
            self.markCell = cell
            return cell
        case .totalPrice(let num,let total):
            let cell:CLOrderTotalPriceCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLOrderTotalPriceCell.self)
            cell.num.text = "共\(num)件"
            cell.totalPrice.text = "￥\(total)"
            cell.totalPrice.jk.setsetSpecificTextFont("￥", font: MYBlodFont(size: 12))
            return cell
        case .discountInfoHead:
            let cell:CLOrderDiscountInfoHeadCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLOrderDiscountInfoHeadCell.self)
       
            return cell
        case .discountQesCell(let price):
            let cell:CLOrderDiscountQesCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLOrderDiscountQesCell.self)
            cell.priceLabel.text = "-￥" + price
            cell.priceLabel.jk.setsetSpecificTextFont("-¥", font: MYBlodFont(size: 12))
            cell.clickBlock = {[unowned self] in
                let vc = CLOrderMulityDiscountController()
                self.customPresentViewController(discountPresenter, viewController: vc, animated: true)
            }
            return cell
        case .coupon(let title,let full,let amt):
            let cell:CLOrderCouponCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLOrderCouponCell.self)
            cell.title.text = title
            cell.info.text = full
            cell.price.text = "-￥\(amt)"
            cell.price.jk.setsetSpecificTextFont("-￥", font: MYFont(size: 12))
            if title == "新客立减减" {
                cell.image.image = UIImage(named: "new")
            }else if title == "会员红包" {
                cell.image.image = UIImage(named: "wallet(1)")
            }else if title == "商家满减" {
                cell.image.image = UIImage(named: "coupon(1)")
            }
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
        case .discountTotal(let price):
            let cell:CLOrderDiscountTotalCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLOrderDiscountTotalCell.self)
            cell.priceLabel.text = "￥"  + price
            cell.priceLabel.jk.setsetSpecificTextFont("￥", font: MYBlodFont(size: 12))
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch cellModel[indexPath.row]{
        case .head:
            return 46
        case .goodInfo:
            return 100
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
            return 35
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch cellModel[indexPath.row] {
        case .remark:
            let vc = CLOrderAddNoteController()
            vc.valueBlock = {[weak self] text in
                uLog(text)
                if text == "" {
                    self?.markCell?.des.text = "推荐使用无接触配送"
                }else{
                    self?.markCell?.des.text = text
                    self?.remark = text
                }
            }
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            return
        }
    }
}
extension CLOrderSubmitGroupBuyController {
    
    func saveOrder(){
        let dic:[String : Any] = [
            "orderdistributionInfoList":orderdistributionInfoList,
//            "receiverPhone": "string",
//            "userReceiverAddressId": 0
        ]
        myOrderProvider.request(MyOrderService.saveOrder(dic)) { result in
            switch result {
            case let .success(response):
                guard let jsonData = try? JSON(data: response.data) else {
                    return
                }
                if  jsonData["resp_code"].intValue == 0{
                    let jsonObj = jsonData["data"]
                    self.resultModel = CLSubmitGroupBuyResultModel(jsonData: jsonObj)
                    uLog(self.resultModel)

                    DispatchQueue.main.async {
                        let vc = CLSubmitPayController()
                        vc.model = self.resultModel
                        self.navigationController?.pushViewController(vc, animated: true)
                        
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
    
    func loadData(){
        let dic:[String : Any] = [
            "idList":idList,
            "isSettle":true,
            "lat":XSAuthManager.shared.latitude,
            "lng":XSAuthManager.shared.longitude
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
                        for item in self.model!.orderCarVOList {
                            
                            self.orderdistributionInfoList.append(["bizType":item.bizType,"merchantId":item.merchantId,"remark":self.remark])
                            
                            self.cellModel.append(.head(name: item.merchantName))
                            
                            for j in item.orderGoodsDetailVOList {
                                self.cellModel.append(.goodInfo(model: j))
                            }
                            self.cellModel.append(.totalPrice(goodNum:"2", goodTotalPrice: item.payAmt))
                            self.cellModel.append(.discountInfoHead)
                            if item.moreDiscountAmt > 0 {
                                self.cellModel.append(.discountQesCell(price:String(item.moreDiscountAmt)))
                            }
                            
                            if !item.merchantFullReduceVoList.isEmpty {
                                for c in item.merchantFullReduceVoList {
                                    self.cellModel.append(.coupon(title: "商家满减",full: item.merchantFullReduceVoListStr,amt: c.reducePrice))

                                }
                            }
                            
                            if item.newCustomerAmt != ""{
                                self.cellModel.append(.coupon(title: "新客立减",full: "新客立减减\(item.newCustomerAmt)",amt: item.newCustomerAmt))
                            }
                                                    
                            if self.model!.redPacketAmt != ""{
                                self.cellModel.append(.coupon(title: "会员红包",full: "无门槛",amt: self.model!.redPacketAmt))
                            }
                            
                            
                            self.cellModel.append(.couponNotice)
                            self.cellModel.append(.discountTotal(price:item.cheapAmt))
                        }
                        
                        if XKeyChain.get(XSYWMemberStatus) != "1"{
                            self.cellModel.append(.memberCard)
                        }
                        
                        self.cellModel.append(.remark)
                        
                        self.payView.payTotal.text = "￥" + self.model!.payAmt
                        self.payView.payTotal.jk.setsetSpecificTextFont("￥", font: MYBlodFont(size: 12))

                        self.payView.totalDiscount.text = "￥" + self.model!.cheapAmt
                        self.payView.totalDiscount.jk.setsetSpecificTextFont("￥", font: MYBlodFont(size: 12))
                        self.payView.payButton.setTitle("提交订单", for: .normal)
                        
                        
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
}
