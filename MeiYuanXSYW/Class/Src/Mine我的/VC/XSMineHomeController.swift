//
//  XSMineHomeController.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/8/6.
//

import UIKit
import SwiftyJSON
import Moya

class XSMineHomeController: XSBaseTableViewController {

    var headerCell: XSMineHeaderCell!
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //NotificationCenter.default.addObserver(self, selector: #selector(fetchUserCenterData), name: NSNotification.Name.XSLoginEndNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(logout), name: NSNotification.Name.XSLogoutNotification, object: nil)

    }
    
   @objc private func logout() {
       self.headerData =  [
           ["icon":"0", "title": "收藏商品"],
           ["icon":"0", "title": "收藏店铺"],
           ["icon":"0", "title": "足迹"],
           ["icon":"0", "title": "卡券"]
       ]
       
       self.orderData =   [["icon":"mine_order_pay","title": "待付款","num":"0"],
                           ["icon":"mine_order_time", "title": "待使用","num":"0"],
                           ["icon":"mine_order_comment", "title": "待评价","num":"0"],
                           ["icon":"mine_order_refund", "title": "退款/售后","num":"0"]]
       
       
       initMineDefaultData()
       
    }
    
    var countModel:CLCenterDataModel?
    
    func loadCenterData(){
        let dic :[String:Any] = [:]
        myOrderProvider.request(MyOrderService.countusercenter(dic)) { result in
            switch result {
            case let .success(response):
                guard let jsonData = try? JSON(data: response.data) else {
                    return
                }
               // uLog("loadCenterData:\(jsonData)")
                if  jsonData["resp_code"].intValue == 0{
                    
                    self.countModel =  CLCenterDataModel.init(jsonData: jsonData["data"])
                    
                    DispatchQueue.main.async {
                        self.headerData =  [
                            ["icon":self.countModel!.collectGoodsNum, "title": "收藏商品"],
                            ["icon":self.countModel!.collectMerchantNum, "title": "收藏店铺"],
                            ["icon":self.countModel!.browseGoodsNum, "title": "足迹"],
                            ["icon":self.countModel!.couponNum, "title": "卡券"]
                        ]
                        
                        self.orderData =   [["icon":"mine_order_pay","title": "待付款","num":self.countModel!.waitPayNum],
                                            ["icon":"mine_order_time", "title": "待使用","num":self.countModel!.waitDistributionNum],
                                            ["icon":"mine_order_comment", "title": "待评价","num":self.countModel!.waitCommentNum],
                                            ["icon":"mine_order_refund", "title": "退款/售后","num":self.countModel!.returnServiceNum]]
                        
                        self.tableView.reloadData()
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
    
    private func loadUserInfoData() {
        MerchantInfoProvider.request(.getUserInfo, model: XSMineHomeUserInfoModel.self) { returnData in
            
            if let userInfo = returnData {                
                
                self.setupModelData(userInfo: userInfo)
                
            }
            
        }  errorResult: { errorMsg in
            XSTipsHUD.hideAllTips()
            XSTipsHUD.showText(errorMsg)
        }

    }
    
    private func setupModelData(userInfo: XSMineHomeUserInfoModel) {
        
        self.dataSource.removeAll()
        
        let vModel = XSMineViewModel()
        vModel.style = .ViewModeStyleHeader
        vModel.modle = userInfo
        vModel.height = 60
        self.dataSource.append(vModel)
        
        let vModel2 = XSMineViewModel()
        vModel2.style = .ViewModeStyleHeaderCollection
        vModel2.height = 80
        self.dataSource.append(vModel2)

        let vModel3 = XSMineViewModel()
        vModel3.style = .ViewModeStyleOrder
        vModel3.height = 50
        self.dataSource.append(vModel3)

        let vModel4 = XSMineViewModel()
        vModel4.style = .ViewModeStyleOrderCollection
        vModel4.height = 90
        self.dataSource.append(vModel4)

        let vModel5 = XSMineViewModel()
        vModel5.style = .ViewModeStyleBanner
        vModel5.height = 124
        self.dataSource.append(vModel5)

        let vModel6 = XSMineViewModel()
        vModel6.style = .ViewModeStyleTool
        vModel6.height = 50
        self.dataSource.append(vModel6)

        let vModel7 = XSMineViewModel()
        vModel7.style = .ViewModeStyleToolCollection
        vModel7.height = 90
        self.dataSource.append(vModel7)
        
        self.tableView.reloadData()
    }
    
    @objc func fetchUserCenterData() {
        if XSAuthManager.shared.isLoginEd {
            loadCenterData()
            loadUserInfoData()
        } else {
            initMineDefaultData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchUserCenterData()
      
        
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)

    }
    

    
    override func initSubviews() {
        super.initSubviews()
        tableView.contentInset = UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0)
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(cellType: XSMineHeaderCell.self)
        tableView.register(cellType: XSMineOrderCell.self)
        tableView.register(cellType: XSMineCollectCell.self)
        tableView.register(cellType: XSMineHeaderCollectCell.self)
        tableView.register(cellType: XSBaseTableViewCell.self)
        
//        let popView = XSRegisterRedPacketPopView()
//        popView.show()

    }
    var dataSource = [XSMineViewModel]()

    private  var headerData: Array = {
        return [
            ["icon":"0", "title": "收藏商品"],
            ["icon":"0", "title": "收藏店铺"],
            ["icon":"0", "title": "足迹"],
            ["icon":"0", "title": "卡券"]
        ]
    }()
    private  var orderData: Array = {
        return [
            ["icon":"mine_order_pay", "title": "待付款","num":"0"],
            ["icon":"mine_order_time", "title": "待使用"],
            ["icon":"mine_order_comment", "title": "待评价"],
            ["icon":"mine_order_refund", "title": "退款/售后","num":"0"]
        ]
    }()
    private var toolData: Array = {
        return [
            ["icon":"mine_tool_kefu", "title": "客服"],
            ["icon":"mine_tool_address", "title": "收货地址"],
            ["icon":"mine_tool_comment", "title": "我的评价"],
            ["icon":"mine_tool_set", "title": "设置"]
        ]
    }()
           
    func initMineDefaultData() {
        
        let userInfo = XSMineHomeUserInfoModel()
        userInfo.headImg = ""
        userInfo.nickname = "请登录"
        userInfo.mobile = ""
        userInfo.memberStatus = 0
        self.setupModelData(userInfo: userInfo)
        
    }
    
}
// - 代理
extension XSMineHomeController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return dataSource[indexPath.row].height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let vModel = dataSource[indexPath.row]
        switch vModel.style {
        case .ViewModeStyleDefault:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XSBaseTableViewCell.self)
            cell.backgroundColor = .background
            return cell
        case .ViewModeStyleHeader:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XSMineHeaderCell.self)
            cell.backgroundColor = .background
            headerCell = cell
            if let userModel = vModel.modle as? XSMineHomeUserInfoModel {
                cell.userInfoModel = userModel
            }
            cell.delegate = self
            return cell
        case .ViewModeStyleHeaderCollection:
            let cell:XSMineHeaderCollectCell = tableView.dequeueReusableCell(for: indexPath, cellType: XSMineHeaderCollectCell.self)
                cell.dataSource = headerData
            cell.delegate = self
            return cell
        case .ViewModeStyleOrderCollection,
             .ViewModeStyleToolCollection:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XSMineCollectCell.self)
            if vModel.style == .ViewModeStyleOrderCollection{
                cell.dataSource = orderData
            }
            else{
                cell.dataSource = toolData
            }
            cell.collectView.hg_setCornerOnBottomWithRadius(radius: 6)
            cell.delegate = self
            return cell
        case .ViewModeStyleOrder,
             .ViewModeStyleTool:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XSMineOrderCell.self)
            if vModel.style == .ViewModeStyleOrder {
                cell.tipLab.text = "我的订单"
                cell.arrowBtn.isHidden = false
            }
            else{
                cell.tipLab.text = "我的工具"
                cell.arrowBtn.isHidden = true
            }
            cell.backView.hg_setCornerOnTopWithRadius(radius: 6)
            cell.delegate = self
            return cell
        case .ViewModeStyleBanner:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XSBaseTableViewCell.self)
            cell.backgroundColor = .clear
            cell.contentView.backgroundColor = .clear
            cell.imageView?.snp.makeConstraints({ make in
                make.left.equalTo(10)
                make.right.equalTo(-10)
                make.top.equalTo(20)
                make.bottom.equalTo(-20)

            })
            cell.imageView?.contentMode = .scaleAspectFill
            cell.imageView?.image = UIImage(named: "mine_banner")
            cell.imageView?.jk.addGestureTap({ geuture in
                print("点击了banner")
            })
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
extension XSMineHomeController:XSMineHeaderCellDelegate,XSMineHeaderCollectCellDelegate,XSMineOrderCellDelegate,XSMineCollectCellDelegate{
    
    func clickUser() {
        
        if !XSAuthManager.shared.isLoginEd {
//            NotificationCenter.default.post(name: NSNotification.Name.XSNeedToLoginNotification, object: self, userInfo:nil)
            self.navigationController?.pushViewController(XSLoginController(), animated: true)
            return
        }
        
        if false {
//            let loginVC = XSBaseNavigationController(rootViewController: XSLoginController())
//            loginVC.modalPresentationStyle = UIModalPresentationStyle.fullScreen
//
//            present(loginVC, animated: true, completion: nil)
            self.navigationController?.pushViewController(XSLoginController(), animated: true)
            return
        }
        else{
            navigationController?.pushViewController(XSInfoController(), animated: true)
        }
    }
    
    func clickHeaderCate(dict: [String : String]) {
        
        if !XSAuthManager.shared.isLoginEd {
//            NotificationCenter.default.post(name: NSNotification.Name.XSNeedToLoginNotification, object: self, userInfo:nil)
            self.navigationController?.pushViewController(XSLoginController(), animated: true)
            return
        }
        
        switch dict["title"] {
        case "收藏商品":
            let collectVc = XSmineCollectViewController(selectedIdx: 0)
            navigationController?.pushViewController(collectVc, animated: true)
            print("收藏商品")
        case "收藏店铺":
            let collectVc = XSmineCollectViewController(selectedIdx: 1)

            navigationController?.pushViewController(collectVc, animated: true)
            print("收藏店铺")
        case "足迹":
            navigationController?.pushViewController(XSFootMarkViewController(), animated: true)
            print("足迹")
        case "卡券":
            navigationController?.pushViewController(XSVipTicketController(), animated: true)
        case "待付款":
            let vc = CLMyOrderController()
            vc.selectIndext = 1
            navigationController?.pushViewController(vc, animated: true)
        case "待使用":
            let vc = CLMyOrderController()
            vc.selectIndext = 2
            navigationController?.pushViewController(vc, animated: true)
        case   "待评价":
            let vc = CLMyOrderController()
            vc.selectIndext = 3
            navigationController?.pushViewController(vc, animated: true)
        case   "退款/售后":
            let vc = CLMyOrderController()
            vc.selectIndext = 4
            navigationController?.pushViewController(vc, animated: true)
        case "客服":
            print("客服")
        case "收货地址":
            navigationController?.pushViewController(XSPayAddressViewController(), animated: true)

            print("收货地址")
        case "我的评价":
            navigationController?.pushViewController(XSMineEvaluteViewController(), animated: true)
            print("我的评价")
        case "设置":
            navigationController?.pushViewController(XSSettingController(), animated: true)
        default:
            print("点击未知")
        }
        
    }
    
    func clickAllOrder() {
        if !XSAuthManager.shared.isLoginEd {
//            NotificationCenter.default.post(name: NSNotification.Name.XSNeedToLoginNotification, object: self, userInfo:nil)
//            return
            
            self.navigationController?.pushViewController(XSLoginController(), animated: true)
        }
        
        let vc = CLMyOrderController()
        vc.selectIndext = 0
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

