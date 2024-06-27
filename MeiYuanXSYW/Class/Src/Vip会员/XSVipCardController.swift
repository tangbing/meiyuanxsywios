//
//  XSVipCardController.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/8/6.
//

import UIKit
import QMUIKit
import SwiftyJSON
import Moya
class XSVipCardController: XSBaseTableViewController {
    var model:CLMyMemberCardModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func setupNavigationItems() {
        super.setupNavigationItems()
        title = "我的会员卡"
    }
    
    override func initSubviews() {
        super.initSubviews()
        

        tableView.delegate = self
        tableView.dataSource = self

        tableView.contentInset(top: 0, left: 0, bottom: 10, right: 0)
        
        tableView.register(cellType: XSVipCardHeaderCell.self)
        
        tableView.register(cellType: XSVipSectionCell.self)
        tableView.register(cellType: XSVipCardTicketCell.self)
        tableView.register(cellType: XSMineOrderCell.self)

        
        
        tableView.register(cellType: XSBaseTableViewCell.self)

//        tableView.register(cellType: XSMineHeaderCollectCell.self)

    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        view.addSubview(tableView)
        tableView.snp_remakeConstraints { make in
            make.left.bottom.top.right.equalTo(0)
        }

    }

    var dataSource = [XSVipViewModel]()

    var merchantData: [[String:Any]] = []
    
//    private lazy var merchantData: Array = {
//        return [
//            ["type":0, "isused": true],
//            ["type":0, "isused": false],
//            ["type":0, "isused": false],
//            ["type":1, "isused": true],
//            ["type":1, "isused": true],
//            ["type":1, "isused": true],
//            ["type":0, "isused": false],
//            ["type":1, "isused": true],
//            ["type":0, "isused": false]
//        ]
//    }()


    override func requestData() {
        super.requestData()
        let dic :[String:Any] = [:]
        myOrderProvider.request(MyOrderService.getMyMemberCard(dic)) { result in
            switch result {
            case let .success(response):
                guard let jsonData = try? JSON(data: response.data) else {
                    return
                }
                if  jsonData["resp_code"].intValue == 0{
                    
                    self.model =  CLMyMemberCardModel.init(jsonData:jsonData["data"])
                    
                    if let value = self.model?.couponHistoryVoList {
                        for item in value {
                            
                            var type:Int = 0
                            if item.couponType == 6 {
                                type = 0
                            }else if item.couponType == 2 || item.couponType == 3 || item.couponType == 9{
                                type = 1
                            }
                            self.merchantData.append(["type":type,"isused":item.isUse])
                        }
                    }
                    
                    
                    DispatchQueue.main.async {
                        
                            
                    
                        let vModel = XSVipViewModel()
                        vModel.style = .ViewModeStyleHeader
                        vModel.height = 110
                        self.dataSource.append(vModel)
                        

                        let vModel3 = XSVipViewModel()
                        vModel3.style = .ViewModeStyleSection
                        vModel3.height = 50
                        vModel3.type = 0
                        self.dataSource.append(vModel3)
                        
                        let count = Float(self.merchantData.count)/2.0
                        let a = Int(ceil(count))
                        for i in 0..<a {
                            let vModel = XSVipViewModel()
                            vModel.style = .ViewModeStyleTicket(model: "")
                            vModel.height = (screenWidth-35)/2*0.74
                            var list = [Any]()
                            list.append(self.merchantData[i*2])
                            if self.merchantData.count > (i*2+1) {
                                list.append(self.merchantData[i*2+1])
                            }
                            vModel.modle = list
                            self.dataSource.append(vModel)
                        }
                        
                        let vModel4 = XSVipViewModel()
                        vModel4.style = .ViewModeStyleMore
                        vModel4.height = 60
                        self.dataSource.append(vModel4)
                        
                        let vModel5 = XSVipViewModel()
                        vModel5.style = .ViewModeStyleUsed
                        vModel5.height = 50
                        self.dataSource.append(vModel5)
                        
                        
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
    
    override func initData() {

        

    }
    
}
// - 代理
extension XSVipCardController : UITableViewDelegate, UITableViewDataSource {
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
        case .ViewModeStyleHeader:
            let cell:XSVipCardHeaderCell = tableView.dequeueReusableCell(for: indexPath, cellType: XSVipCardHeaderCell.self)
            cell.myModel = self.model
            
            return cell
        case .ViewModeStyleSection:
            let cell:XSVipSectionCell = tableView.dequeueReusableCell(for: indexPath, cellType: XSVipSectionCell.self)
            if let model = self.model {
                cell.tipLab.text = "本月可用红包：\(model.remainingCouponNum)张  共\(model.totalCouponNum)张"
                cell.tipLab.jk.setsetSpecificTextFont("共\(model.totalCouponNum)张", font:MYFont(size: 12))
                cell.tipLab.jk.setSpecificTextColor("共\(model.totalCouponNum)张", color: .king)

                cell.subLab.isHidden = true
            }

            cell.backView.snp.remakeConstraints { make in
                make.top.right.left.bottom.equalTo(0)
            }

            return cell
        case .ViewModeStyleTicket:
            let cell:XSVipCardTicketCell = tableView.dequeueReusableCell(for: indexPath, cellType: XSVipCardTicketCell.self)
            cell.model = vModel.modle as! [Any]
            return cell
        case .ViewModeStyleMore:
            let cell:XSMineOrderCell = tableView.dequeueReusableCell(for: indexPath, cellType: XSMineOrderCell.self)
            cell.tipLab.text = "会员购买记录"
            cell.backView.snp.remakeConstraints { make in
                make.top.equalTo(10)
                make.bottom.left.right.equalTo(0)
            }
            cell.arrowBtn.setTitle("", for: UIControl.State.normal)
            return cell
        case .ViewModeStyleUsed:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XSBaseTableViewCell.self)
            let btn = QMUIButton()
            btn.setTitle("查看无效券", for: UIControl.State.normal)
            btn.setImage(UIImage(named: "vip_arrow_Check"), for: UIControl.State.normal)
            btn.titleLabel?.font = MYFont(size: 13)
            btn.imagePosition = .right
            btn.setTitleColor(.twoText, for: UIControl.State.normal)
            
            cell.contentView.addSubview(btn)
            btn.snp.makeConstraints { make in
                make.edges.equalTo(0)
            }
            btn.backgroundColor = .clear
            cell.contentView.backgroundColor = .background
            return cell
        default:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XSBaseTableViewCell.self)
            cell.backgroundColor = .background
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch dataSource[indexPath.row].style {
        case .ViewModeStyleMore:
            navigationController?.pushViewController(XSVipBuyHistoryController(), animated: true)
        default:break
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

/////cell 的点击事件
//extension XSVipCardController{
//    func clickUserName() {
//        if true {
//            let loginVC = XSBaseNavigationController(rootViewController: XSLoginController())
//            loginVC.modalPresentationStyle = UIModalPresentationStyle.fullScreen
//
//            present(loginVC, animated: true, completion: nil)
//            return
//        }
//    }
//
//    func clickHeaderCate(dict: [String : String]) {
//        switch dict["title"] {
//        case "收藏商品":
//            print("收藏商品")
//        case "收藏店铺":
//            print("收藏店铺")
//        case "足迹":
//            print("足迹")
//        case "卡券":
//            print("卡券")
//        case "待付款",
//             "待使用",
//             "待评价",
//             "退款/售后":
//            print("订单")
//        case "客服":
//            print("客服")
//        case "收货地址":
//            print("收货地址")
//        case "我的评价":
//            print("我的评价")
//        case "设置":
//            print("设置")
//
//        default:
//            print("点击未知")
//        }
//
//    }
//
//    func clickAllOrder() {
//        print("全部订单")
//    }
//
//
//}

