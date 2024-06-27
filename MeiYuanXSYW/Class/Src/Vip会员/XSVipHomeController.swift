//
//  XSVipHomeController.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/8/6.
//

import UIKit
import QMUIKit
import SwiftyJSON
import Moya
import HandyJSON

class XSVipHomeController: XSBaseTableViewController  {
    
    var memberModel:CLMemberUserInfoModel?
    var addPackageModel:[CLAddPackageModel] = []
    var merchantModel:[CLMerchantSimpleVoModel] = []
    var isExtend:Bool = false

    var moreCell:XSVipMoreCell = XSVipMoreCell()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func setupNavigationItems() {
        super.setupNavigationItems()
        navigationTitle = "我的会员"
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        navigationController?.navigationBar.shadowImage = UIImage()
        self.request()

    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        navigationController?.navigationBar.shadowImage = UIColor.black.image()

    }
    
    func request() {
        let dic :[String:Any] = [:]
        
        myOrderProvider.request(MyOrderService.getMemberUser(dic)) { result in
            switch result {
            case let .success(response):

                guard let jsonData = try? JSON(data: response.data) else {
                    self.dataSource.removeAll()

                    let vModel = XSVipViewModel()
                    vModel.style = .ViewModeStyleHeader
                    vModel.height = 170
                    self.dataSource.append(vModel)
                    
                    self.tableView.reloadData()
                    
                    return
                }

                if  jsonData["resp_code"].intValue == 0{
                    
                    self.memberModel =  CLMemberUserInfoModel.init(jsonData:jsonData["data"])
                    self.loadAddPackage()
                    
                }else{

//                    XSTipsHUD.showText(jsonData["resp_msg"].stringValue)
                    
                    if jsonData["resp_msg"].stringValue == "Not Authenticated"{
                        self.dataSource.removeAll()

                        let vModel = XSVipViewModel()
                        vModel.style = .ViewModeStyleHeader
                        vModel.height = 170
                        self.dataSource.append(vModel)
                        
                        self.tableView.reloadData()
                    }
                    
                }

             case let .failure(error):
                //网络连接失败，提示用户
                XSTipsHUD.showText("网络连接失败")
            }
        }
    }
    
    func loadAddPackage(){
        let dic :[String:Any] = [:]
        myOrderProvider.request(MyOrderService.getAddPackageList(dic)) { result in
            switch result {
            case let .success(response):
                guard let jsonData = try? JSON(data: response.data) else {
                    return
                }
                if  jsonData["resp_code"].intValue == 0{
                    
                    self.addPackageModel =  jsonData["data"].arrayValue.compactMap{
                        return  CLAddPackageModel.init(jsonData: $0)
                    }
                    
                    self.getNearByMerchantUpAmt()
                
                    
                }else{
                    XSTipsHUD.showText(jsonData["resp_msg"].stringValue)
                }

             case let .failure(error):
                //网络连接失败，提示用户
                XSTipsHUD.showText("网络连接失败")
            }
        }
    }
    
    func getNearByMerchantUpAmt(){
        let dic :[String:Any] = ["lat":"114.132285",
                                 "lng":"22.547562",]
        myOrderProvider.request(MyOrderService.getNearByMerchantUpAmt(dic)) { result in
            switch result {
            case let .success(response):
                guard let jsonData = try? JSON(data: response.data) else {
                    return
                }
                if  jsonData["resp_code"].intValue == 0{
                    
                    self.merchantModel =  jsonData["data"].arrayValue.compactMap{
                        return  CLMerchantSimpleVoModel.init(jsonData: $0)
                    }
                    
                    DispatchQueue.main.async {
                        self.loadModel()
                    }
                    
                }else{
                    XSTipsHUD.showText(jsonData["resp_msg"].stringValue)
                }

             case let .failure(error):
                //网络连接失败，提示用户
                XSTipsHUD.showText("网络连接失败")
            }
        }
    }
    
    
    override func initSubviews() {
        super.initSubviews()
        tableView.delegate = self
        tableView.dataSource = self

        tableView.contentInset(top: 0, left: 0, bottom: 10, right: 0)
        
        tableView.register(cellType: XSVipHeaderCell.self)
        tableView.register(cellType: XSVipBuyCell.self)
        
        tableView.register(cellType: XSVipSectionCell.self)
        tableView.register(cellType: XSVipMerchantCell.self)
        tableView.register(cellType: XSVipMoreCell.self)
        tableView.register(cellType: XSVipCollectCell.self)
        
        tableView.register(cellType: XSBaseTableViewCell.self)

//        tableView.register(cellType: XSMineHeaderCollectCell.self)

    }
    var dataSource = [XSVipViewModel]()

    private lazy var merchantData: Array = {
        return [
            ["icon":"mine_order_pay", "title": "待付款","num":"99"],
            ["icon":"mine_order_time", "title": "待使用"],
            ["icon":"mine_order_comment", "title": "待评价"],
            ["icon":"mine_order_refund", "title": "退款/售后","num":"2"]
        ]
    }()
    private lazy var toolData: Array = {
        return [
            ["icon":"mine_tool_kefu", "title": "客服"],
            ["icon":"mine_tool_address", "title": "收货地址"],
            ["icon":"mine_tool_comment", "title": "我的评价"],
            ["icon":"mine_tool_set", "title": "设置"]
        ]
    }()


    func loadModel(){
        self.dataSource.removeAll()

        let vModel = XSVipViewModel()
        vModel.style = .ViewModeStyleHeader
        vModel.height = 170
        self.dataSource.append(vModel)
        
        let vModel2 = XSVipViewModel()
        vModel2.style = .ViewModeStyleBuy
        vModel2.height = 80
        self.dataSource.append(vModel2)

        let vModel3 = XSVipViewModel()
        vModel3.style = .ViewModeStyleSection
        vModel3.height = 40
        vModel3.type = 0
        self.dataSource.append(vModel3)
        
        var count:Int = 0
        
        if self.merchantModel.count >= 3 {
            if self.isExtend == false {
                count = 3
            }else{
                count = self.merchantModel.count
            }
        }else{
            count = self.merchantModel.count
        }
        
        for i  in 0 ..< count {
            let vModel = XSVipViewModel()
            vModel.style = .ViewModeStyleMerchant(model:self.merchantModel[i])
            if i == self.merchantModel.count -  1{
                vModel.hasLine = false
                vModel.hasBottomRadiu = false
            }
            self.dataSource.append(vModel)
        }
        

        let vModel4 = XSVipViewModel()
        vModel4.style = .ViewModeStyleMore
        vModel4.height = 40
        self.dataSource.append(vModel4)
        
        
        if self.memberModel?.memberStatus == "1"{
            let vModel5 = XSVipViewModel()
            vModel5.style = .ViewModeStyleSection
            vModel5.height = 60
            vModel5.type = 1
            self.dataSource.append(vModel5)
            
            let vModel6 = XSVipViewModel()
            vModel6.style = .ViewModeStyleTicket(model: "")
            vModel6.height = 175
            self.dataSource.append(vModel6)
        }
        self.tableView.reloadData()
    }
}
// - 代理
extension XSVipHomeController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if dataSource[indexPath.row].height > 0 {
            return dataSource[indexPath.row].height
        }
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let vModel = dataSource[indexPath.row]
        switch vModel.style {
        case .ViewModeStyleDefault:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.backgroundColor = .background
            return cell
        case .ViewModeStyleHeader:
            let cell:XSVipHeaderCell = tableView.dequeueReusableCell(for: indexPath, cellType: XSVipHeaderCell.self)
            cell.model = self.memberModel
//            cell.userView.userStackView.userName.text = "131****6987"
//            cell.userView.userStackView.userNameTipLab.text = "2021.06.21到期>"
//
//            cell.headerTipView.userName.text = "可用红包"
//            cell.headerTipView.userNameTipLab.text = "有1张红包在3天后过期"
//
//            cell.numLab.text = "¥ 5   X   6张"
//            cell.numLab.jk.setsetSpecificTextFont("¥", font:MYFont(size: 17))
//            cell.numLab.jk.setsetSpecificTextFont("X", font:MYFont(size: 19))
//            cell.numLab.jk.setsetSpecificTextFont("张", font:MYFont(size: 16))
//
//            cell.bottomLab.text = "2021.06.22下期会员生效，发送6张5元会员红包"
            cell.delegate = self
            return cell
        case .ViewModeStyleBuy:
            let cell:XSVipBuyCell = tableView.dequeueReusableCell(for: indexPath, cellType: XSVipBuyCell.self)
            cell.model = self.memberModel
            cell.buyBlock = {[unowned self] in
                self.clickBuyVip()
            }
            return cell
        case .ViewModeStyleSection:
            let cell:XSVipSectionCell = tableView.dequeueReusableCell(for: indexPath, cellType: XSVipSectionCell.self)
            cell.tipLab.text = "会员商家"
            cell.subLab.isHidden = true
            if vModel.type == 1 {
                cell.tipLab.text = "低价购买会员加量包"
                cell.subLab.isHidden = false
                
                if let time = self.memberModel?.timeoutDate {
                
                    cell.subLab.text = "请在会员有效期\(time.components(separatedBy: " ").first ?? "")内购买和使用"
                }
            }
            cell.backView.hg_setCornerOnTopWithRadius(radius: 6)
            return cell
        case .ViewModeStyleMerchant(let model):
            let cell:XSVipMerchantCell = tableView.dequeueReusableCell(for: indexPath, cellType: XSVipMerchantCell.self)
            cell.backView.hg_setCornerOnTopWithRadius(radius: 0)
            if vModel.hasBottomRadiu {
                cell.backView.hg_setCornerOnBottomWithRadius(radius: 6)
            }
            cell.lineView.isHidden = !vModel.hasLine
            cell.model = model
            //cell.setNameIconType(type: indexPath.row%4)
            cell.enterShopBlock = {[unowned self] in
                self.enterMerchant(model:model)
            }
            cell.ticketView.clickBlock = {[unowned self] in
                self.clickTicketExchange(model:model)
            }
//            cell.delegate = self
            return cell
        case .ViewModeStyleMore:
            let cell:XSVipMoreCell = tableView.dequeueReusableCell(for: indexPath, cellType: XSVipMoreCell.self)
            cell.backView.hg_setCornerOnBottomWithRadius(radius: 6)
            self.moreCell = cell
            cell.delegate = self
            return cell
        case .ViewModeStyleTicket:
            let cell:XSVipCollectCell = tableView.dequeueReusableCell(for: indexPath, cellType: XSVipCollectCell.self)
            cell.collectView.hg_setCornerOnBottomWithRadius(radius: 6)
            cell.model = self.addPackageModel
            cell.block = {[unowned self] id in
                let vc = XSVipAddBuyController()
                vc.addPackageId = id
                self.navigationController?.pushViewController(vc, animated: true)
            }
//            cell.delegate = self
            return cell
        default :
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XSBaseTableViewCell.self)
            cell.backgroundColor = .background
            return cell
        }
    }
    
    // 控制向上滚动显示导航栏标题和左右按钮
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let offsetY = scrollView.contentOffset.y
//        if (offsetY > 0)
//        {
//            let alpha = offsetY / CGFloat(kNavBarBottom)
//            navBarBackgroundAlpha = alpha
//        }else{
//            navBarBackgroundAlpha = 0
//        }
//    }
}

///cell 的点击事件
extension XSVipHomeController:XSVipHeaderCellDelegate,XSVipCollectCellDelegate,XSVipMoreCellDelegate{
    func clickInsetMerchant() {
        
    }
    
    func clickAllOrder() {
        self.isExtend = !self.isExtend
        if self.isExtend == true {
            moreCell.arrowBtn.setTitle("收起", for: UIControl.State.normal)
            moreCell.arrowBtn.setImage(UIImage(named: "vip_arrow_Check_up"), for: UIControl.State.normal)
        }else{
            moreCell.arrowBtn.setTitle("查看更多", for: UIControl.State.normal)
            moreCell.arrowBtn.setImage(UIImage(named: "vip_more"), for: UIControl.State.normal)
        }

        self.loadModel()
    }
    ///商家进店
    func   enterMerchant(model:CLMerchantSimpleVoModel) {
        if model.takeout == 1 && model.privateChef == 1 && model.groupp == 1 { // 聚合商家详情
            let mult = TBGroupBuyMerchInfoViewController(style: .multiple, merchantId: model.merchantId)
            self.navigationController?.pushViewController(mult, animated: true)

        } else if model.takeout == 1 {
            let kitchen = TBDeliverMerchanInfoViewController(style: .privateKitchen, merchantId: model.merchantId)
            self.navigationController?.pushViewController(kitchen, animated: true)
        } else if model.privateChef == 1 {
            let group = TBGroupBuyMerchInfoViewController(style: .privateKitchen, merchantId: model.merchantId)
            self.navigationController?.pushViewController(group, animated: true)
        } else if model.groupp == 1 {
            let group = TBGroupBuyMerchInfoViewController(style: .groupBuy, merchantId: model.merchantId)
            self.navigationController?.pushViewController(group, animated: true)
        }
        
    }
    ///跳转我的会员卡
    func clickUserName() {
        if XSAuthManager.shared.isLoginEd {
            navigationController?.pushViewController(XSVipCardController(), animated: true)
            return
        }else {
            self.navigationController?.pushViewController(XSLoginController(), animated: true)
            
//            let nav = XSBaseNavigationController(rootVC: XSLoginController())
//            self.present(nav, animated: true, completion: nil)
        }
    }
    //会员购买
    func clickBuyVip() {
        if true {//未购买vip
            navigationController?.pushViewController(XSVipBuyController(), animated: true)
            return
        }
    }
    //我的会员卡
    func clickTicket() {
        navigationController?.pushViewController(XSVipTicketController(), animated: true)
        return
    }
    ///加量包购买
    func clickAddBuy() {
        navigationController?.pushViewController(XSVipAddBuyController(), animated: true)
    }
    //兑换商家红包
    func clickTicketExchange(model:CLMerchantSimpleVoModel) {
        let width:Int = Int(screenWidth - 64);
        let modalViewController = QMUIModalPresentationViewController()
        let contentView = XSVipCardExchangeView()
        contentView.exchangeBlock = {[unowned self] in
            self.exchangeMerchantCoupon(merchantId: model.merchantId)
            
        }
        contentView.model = model
        contentView.frame = CGRect(x: 32, y: 0, width: width, height: 400)
        modalViewController.contentView = contentView;
        present(modalViewController, animated: false, completion: nil)
    }
    
    
    func exchangeMerchantCoupon(merchantId: String) {
        
        MerchantInfoProvider.request(.exchangeMerchantCoupon(merchantId), model: CLMerchInfoHandlerModel.self) { [weak self] returnData in
            
            if returnData!.resCode == 0 {
                XSTipsHUD.showSucceed("兑换成功")
//                self?.delegate?.refreshTicket()
                // 重新刷新店铺详情的头接口获取数据
//                NotificationCenter.default.post(name: NSNotification.Name.XSUpdateMerchHeadrInfoNotification, object: nil)
            } else if  returnData!.resCode == 1{
                XSTipsHUD.showText("兑换失败")
            }else {
                XSTipsHUD.showText("你当前不是会员哦")
            }
            
        } errorResult: { errorMsg in
            print(errorMsg)
            XSTipsHUD.showText(errorMsg)
        }
        
    }

}

struct CLMerchInfoHandlerModel: HandyJSON {
    var resCode: Int = 0
}
