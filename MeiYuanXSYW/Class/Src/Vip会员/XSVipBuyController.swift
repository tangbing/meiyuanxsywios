//
//  XSVipBuyController.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/8/6.
//

import UIKit
import QMUIKit
import Moya
import SwiftyJSON

class XSVipBuyController: XSBaseTableViewController {
    var model:CLMemberCardInfoModel?
    
    var dic:[[String:String]] = []
    
    var vipAuthDic:[[String:String]] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.backgroundColor = .white
        title = "会员购买"
        // Do any additional setup after loading the view.
    }
//    override func setupNavigationItems() {
//        super.setupNavigationItems()
//        title = "会员购买"
//
//    }
    
    let bottomView = XSVipBuyFooterView()
    
    override func requestData() {
        super.requestData()
        let dic :[String:Any] = [:]
        myOrderProvider.request(MyOrderService.getMemberCardInfo(dic)) { result in
            switch result {
            case let .success(response):
                guard let jsonData = try? JSON(data: response.data) else {
                    return
                }
                if  jsonData["resp_code"].intValue == 0{
                    
                    self.model =  CLMemberCardInfoModel.init(jsonData:jsonData["data"]) 
                    
                    DispatchQueue.main.async {
                                                
                        for item in self.model!.memberCardVo {
                            var des = ""
                            if item.validTimeUnit == "3"{
                                des = "每月仅\(Int(item.price)!/3)元"
                            }else if item.validTimeUnit == "4"{
                                des = "每月仅\(Int(item.price)!/12)元"
                            }else {
                                des = "无门槛"
                            }
                            
                            self.dic.append(["title":item.memberCardName,"price":item.price,"sprice":item.originalPrice,"seal":des])
                        }
                        
                        self.vipAuthDic = [
                            ["tipLab":"5元x6张","subLab":"无门槛红包","image":"vip_buy_envelope_icon"],
                            ["tipLab":"商家红包","subLab":"兑换商家红包","image":"vip_buy_envelope_icon2"],
                            ["tipLab":"会员活动","subLab":"参加平台会员活动","image":"vip_buy_envelope_icon3"],
                            ["tipLab":"会员折扣","subLab":"专项会员折扣","image":"vip_buy_envelope_icon4"]]
                        
                        self.loadModel()


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
    

    override func initSubviews() {
        super.initSubviews()

        tableView.delegate = self
        tableView.dataSource = self

        tableView.contentInset(top: 0, left: 0, bottom: 10, right: 0)
        
        tableView.register(cellType: XSVipCardHeaderCell.self)
        
        tableView.register(cellType: XSVipBuyCollectCell.self)
        tableView.register(cellType: XSVipBuySectionCell.self)
        tableView.register(cellType: XSVipBuyAuthCell.self)
        tableView.register(cellType: XSVipBuyAuthCollectCell.self)
        
        tableView.register(cellType: XSBaseTableViewCell.self)

    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        view.addSubview(bottomView)
        bottomView.bottomView.jk.addBorderTop(borderWidth: 1, borderColor: .borad)
        bottomView.snp_makeConstraints { make in
            make.left.right.equalTo(0)
            make.bottom.equalTo(view.usnp.bottom)
            make.height.equalTo(108)
        }

        view.addSubview(tableView)
        tableView.snp_remakeConstraints { make in
            make.left.top.right.equalTo(0)
            make.bottom.equalTo(bottomView.snp_top)
        }

    }

    var dataSource = [XSVipViewModel]()

    private lazy var merchantData: Array = {
        return [
            ["type":0, "isused": true],
            ["type":0, "isused": false],
            ["type":0, "isused": false],
            ["type":1, "isused": true],
            ["type":1, "isused": true],
            ["type":1, "isused": true],
            ["type":0, "isused": false],
            ["type":1, "isused": true],
            ["type":0, "isused": false]
        ]
    }()

                    
     func loadModel() {

        let vModel = XSVipViewModel()
        vModel.style = .ViewModeStyleHeader
        vModel.height = 80
        dataSource.append(vModel)
        

        let vModel3 = XSVipViewModel()
        vModel3.style = .ViewModeStyleTicket(model: "")
        vModel3.height = (screenWidth-60)/3*1.2+15+10
        dataSource.append(vModel3)
        
         if self.model!.couponHistoryVoList.count > 0 {
             let vModel4 = XSVipViewModel()
             vModel4.style = .ViewModeStyleSection
             vModel4.height = 60
             dataSource.append(vModel4)
         }

        let vModel5 = XSVipViewModel()
        vModel5.style = .ViewModeStyleBuyAuth
        vModel5.height = 80
        dataSource.append(vModel5)
         
        let vModel6 = XSVipViewModel()
        vModel6.style = .ViewModeStyleBuyAuthCollect
        vModel6.height = 120
        dataSource.append(vModel6)

    }
    
}
// - 代理
extension XSVipBuyController : UITableViewDelegate, UITableViewDataSource {
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
            cell.model = self.model
            cell.buyBlock = {[unowned self] in
                self.navigationController?.pushViewController(XSVipBuyHistoryController(), animated: true)
            }

            return cell
        case .ViewModeStyleTicket:
            let cell:XSVipBuyCollectCell = tableView.dequeueReusableCell(for: indexPath, cellType: XSVipBuyCollectCell.self)
            cell.selectBlock = {[unowned self] dic in
                self.bottomView.model = dic
            }
            
            cell.dataSource = self.dic
            
            return cell
        case .ViewModeStyleSection:
            let cell:XSVipBuySectionCell = tableView.dequeueReusableCell(for: indexPath, cellType: XSVipBuySectionCell.self)
            
            if let model = self.model {
                cell.priceBtn.setTitle("-￥" + model.couponHistoryVoList[0].discountAmount, for: .normal)
            }

            return cell
        case .ViewModeStyleBuyAuth:
            let cell:XSVipBuyAuthCell = tableView.dequeueReusableCell(for: indexPath, cellType: XSVipBuyAuthCell.self)
            if let model = self.model {
                cell.tipLab.text = "将在\(model.validDate)生效"
            }

            return cell
        case .ViewModeStyleBuyAuthCollect:
            let cell:XSVipBuyAuthCollectCell = tableView.dequeueReusableCell(for: indexPath, cellType: XSVipBuyAuthCollectCell.self)
            cell.model = self.vipAuthDic
            return cell
        default:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XSBaseTableViewCell.self)
            cell.backgroundColor = .background
            return cell
        }
    }
    
}

