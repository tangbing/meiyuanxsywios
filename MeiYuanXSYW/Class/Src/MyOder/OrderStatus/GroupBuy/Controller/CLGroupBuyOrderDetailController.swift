//
//  CLGroupBuyOrderDetailController.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/6.
//

import UIKit
import Moya
import SwiftyJSON
enum GroupBuyOrderDetail{
    case contact
    case goodInfo  //商品信息
    case shopInfo  //商家信息
    case headCell(title:String)  // head
    case topCorner
    case bottomCorner
    case titleCell(title:String)
    case goodPriceAndNumCell(name:String,num:String,price:String)
    case buyKnownOne(text:String)
    case buyKnownTwo(text:String)
    case buyKnownThree(text:String)
    case orderInfo
    case groupBuyVoucherHead
    case groupBuyVoucherInfo(model:CLOrderGoodsDetailVOList)
}

class CLGroupBuyOrderDetailController: XSBaseViewController {
    
    var cellModel:[GroupBuyOrderDetail] = []
    var model:CLMyOrderListModel?
    let topView  = CLMyOrderDetailTopView()
    var status:groupBuyOrderStatus = .waitPay
    var contactData:[[String:String]] = []
    var refundFlag:Bool = false //是否能售后
    var merchantOrderSn:String = ""
        
    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = .lightBackground
        $0.register(cellType: CLMyOrderDetailContactCell.self)
        $0.register(cellType: CLMyOrderDetailGoodInfoCell.self)
        $0.register(cellType: CLMyOrderDetailShopInfoCell.self)
        $0.register(cellType: CLMyOrderDetailHeadCell.self)
        $0.register(cellType: CLMyOrderDetailTitleCell.self)
        $0.register(cellType: CLMyOrderDetailGoodPriceAndNumCell.self)
        $0.register(cellType: CLMyOrderDetailBuyknownOneCell.self)
        $0.register(cellType: CLMyOrderDetailBuyKnownTwoCell.self)
        $0.register(cellType: CLMyOrderDetailBuyKnownThreeCell.self)
        $0.register(cellType: CLBottomCornerRadioCell.self)
        $0.register(cellType: CLTopCornerRadioCell.self)
        $0.register(cellType: CLGroupBuyWaitPayOrderInfoCell.self)
        
        $0.register(cellType: CLMyOrderDetailShopName2Cell.self)
        $0.register(cellType: CLMyOrderGroupBuyVoucherInfoCell.self)
        $0.register(cellType: CLTopCornerRadioCell.self)
        $0.register(cellType: CLBottomCornerRadioCell.self)
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
        if status == .orderFinish1 || status == .orderFinish2{
            topView.setting("已完成", "","completed")
            if refundFlag == true {
                self.contactData = [["title":"订单评价","image":"comment"],
                                    ["title":"申请售后","image":"money"],
                                    ["title":"客服","image":"customer_service"]]
            }else{
                self.contactData = [["title":"订单评价","image":"comment"],
                                    ["title":"客服","image":"customer_service"]]
            }
            
        }else if status == .orderClose{
            topView.setting("订单关闭","","close-1")
            self.contactData = [["title":"重新下单","image":"iphone"],
                                ["title":"联系商家","image":"right"],
                                ["title":"客服","image":"customer_service"]]
        }else if status == .waitUse {
            topView.setting("待使用", "","orders")
            self.contactData = [["title":"联系商家","image":"right"],
                                ["title":"客服","image":"customer_service"],
                                ["title":"发红包","image":"red_envelope"]]
        }else if status == .waitComment{
            topView.setting("待评价", "","information")
            self.contactData = [["title":"订单评价","image":"comment"],
                                ["title":"客服","image":"customer_service"]]
        }else if status == .refundReview {
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
                        
                        self.cellModel.append(.groupBuyVoucherHead)
                        
                        if let model = self.model?.orderGoodsDetailVOList {
                            for item in model {
                                self.cellModel.append(.groupBuyVoucherInfo(model: item))
                            }
                            
                            ///套餐数据
                            
                            let groupModel = CLGroupSnapshot(jsonData:JSON(parseJSON: model[0].groupSnapshot))!
                            
                            self.cellModel.append(.shopInfo)
                            self.cellModel.append(.headCell(title: "套餐详情"))
                            self.cellModel.append(.topCorner)

                            for item in groupModel.goodsPackageVos {
                                self.cellModel.append(.titleCell(title:item.packageName))
                                
                                for i in item.goodsPackageItemVos {
                                    self.cellModel.append(.goodPriceAndNumCell(name: i.itemName, num: i.itemNum, price: i.showPrice))
                                }
                            }
                            self.cellModel.append(.bottomCorner)
                            
                            ///购买须知
                            self.cellModel.append(.headCell(title: "购买须知"))
                            self.cellModel.append(.topCorner)
                            self.cellModel.append(.buyKnownOne(text: "有效期"))
                            self.cellModel.append(.buyKnownTwo(text:"\(groupModel.saleBeginDate)至\(groupModel.saleEndDate)(周末法定节假日通用)"))
                            self.cellModel.append(.buyKnownOne(text:"使用时间"))
                            self.cellModel.append(.buyKnownTwo(text: groupModel.useTime))
                            self.cellModel.append(.buyKnownOne(text: "使用规则"))
                            self.cellModel.append(.buyKnownThree(text: groupModel.sideLetter))
                            self.cellModel.append(.bottomCorner)
                        }
                        
                    
                        self.cellModel.append(.goodInfo)
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
        self.loadData()
        
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


extension CLGroupBuyOrderDetailController:UITableViewDelegate,UITableViewDataSource{

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
            let cell:CLMyOrderDetailGoodInfoCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderDetailGoodInfoCell.self)
            cell.model = self.model

            return cell

        case .shopInfo:
            let cell:CLMyOrderDetailShopInfoCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderDetailShopInfoCell.self)
            return cell
        case .headCell(let title):
            let cell:CLMyOrderDetailHeadCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderDetailHeadCell.self)
            cell.title.text = title
            return cell
        case .topCorner:
            let cell:CLTopCornerRadioCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLTopCornerRadioCell.self)
       
            return cell
        case .bottomCorner:
            let cell:CLBottomCornerRadioCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLBottomCornerRadioCell.self)
       
            return cell
        case .titleCell(let title):
            let cell:CLMyOrderDetailTitleCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderDetailTitleCell.self)
            cell.title.text = title
            return cell
        case .goodPriceAndNumCell(let name,let num,let price):
            let cell:CLMyOrderDetailGoodPriceAndNumCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderDetailGoodPriceAndNumCell.self)
            cell.goodName.text = name
            cell.num.text = num
            cell.price.text = price
            return cell
        case .buyKnownOne(let text):
            let cell:CLMyOrderDetailBuyknownOneCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderDetailBuyknownOneCell.self)
            cell.title.text = text
            return cell
        case .buyKnownTwo(let text):
            let cell:CLMyOrderDetailBuyKnownTwoCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderDetailBuyKnownTwoCell.self)
            cell.label.text = text
            return cell
        case .buyKnownThree(let text):
            let cell:CLMyOrderDetailBuyKnownThreeCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderDetailBuyKnownThreeCell.self)
            cell.label.text = text
            return cell
        case .orderInfo:
            let cell:CLGroupBuyWaitPayOrderInfoCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLGroupBuyWaitPayOrderInfoCell.self)
//            cell.model = self.model

            return cell
        case .groupBuyVoucherHead:
            let cell:CLMyOrderDetailShopName2Cell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderDetailShopName2Cell.self)
            cell.shopName.text = self.model?.merchantName
       
            return cell
        case .groupBuyVoucherInfo(let item):
            let cell:CLMyOrderGroupBuyVoucherInfoCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderGroupBuyVoucherInfoCell.self)
            cell.model = item
            return cell
        }
        

        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch cellModel[indexPath.row]{
        case .contact:
            return 100
        case .goodInfo:
            let goodHeight = (self.model?.orderGoodsDetailVOList.count ?? 0) * 110
        
            let couponHeight = (self.model?.orderCheapInfoVOList.count ?? 0) * 36
            
            let discountHeight = self.model?.bizType == "0" ? 120:90
            
            return CGFloat(40 + discountHeight + 77 + goodHeight + couponHeight)
        case .shopInfo:
            return 86
        case .headCell:
            return 40
        case .topCorner:
            return 10
        case .bottomCorner:
            return 10
        case .titleCell:
            return 25
        case .goodPriceAndNumCell:
            return 21.5
        case .buyKnownOne:
            return 27
        case .buyKnownTwo:
            return 26.5
        case .buyKnownThree(let text):
            let height = text.boundingRect(with:CGSize(width: screenWidth - 75, height:CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [.font: MYFont(size: 12)], context:nil).size.height
            return height + 5
        case .orderInfo:
            return 148
            
        case .groupBuyVoucherHead:
            return 49
        case .groupBuyVoucherInfo:
            return 110
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
