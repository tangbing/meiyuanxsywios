//
//  CLGroupByWaitPayController.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/6.
//

import UIKit
import Presentr
import SwiftyJSON
import Moya

enum GroupByWaitPay{
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
}

class CLGroupByWaitPayController: XSBaseViewController {
    
    var cellModel:[GroupByWaitPay] = []
    var model:CLMyOrderListModel?

    let topView  = CLMyOrderDetailTopView()
    
    let payView = CLMyOrderDetailPayView().then{
        $0.backgroundColor = .white
    }
    
    var  merchantOrderSn:String = ""
    
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
                        self.cellModel.append(.goodInfo)
                        self.cellModel.append(.shopInfo)

                        if let model = self.model?.orderGoodsDetailVOList {

                            ///套餐数据
                            
                            let groupModel = CLGroupSnapshot(jsonData:JSON(parseJSON: model[0].groupSnapshot))!
                            
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

        topView.setting("待支付", "支付剩余时间:00:02:59","wallet")

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


extension CLGroupByWaitPayController:UITableViewDelegate,UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModel.count
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch cellModel[indexPath.row] {
        case .contact:
            let cell:CLMyOrderDetailContactCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderDetailContactCell.self)
            cell.model = [
                ["title":"取消订单","image":"close"],
                ["title":"联系商家","image":"right"]]
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
        case .buyKnownOne(let title):
            let cell:CLMyOrderDetailBuyknownOneCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderDetailBuyknownOneCell.self)
            cell.title.text = title
            return cell
        case .buyKnownTwo(let title):
            let cell:CLMyOrderDetailBuyKnownTwoCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderDetailBuyKnownTwoCell.self)
            cell.label.text = title
            return cell
        case .buyKnownThree(let text):
            let cell:CLMyOrderDetailBuyKnownThreeCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderDetailBuyKnownThreeCell.self)
            cell.label.text = text
            return cell
        case .orderInfo:
            let cell:CLGroupBuyWaitPayOrderInfoCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLGroupBuyWaitPayOrderInfoCell.self)
       
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
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
