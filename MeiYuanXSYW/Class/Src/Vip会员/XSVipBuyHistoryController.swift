//
//  XSVipBuyHistoryController.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/8/6.
//

import UIKit
import QMUIKit
import SwiftyJSON
import Moya

class XSVipBuyHistoryController: XSBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func setupNavigationItems() {
        super.setupNavigationItems()
        title = "会员购买记录"
    }
    
    override func initSubviews() {
        super.initSubviews()
        

        tableView.delegate = self
        tableView.dataSource = self

        tableView.contentInset(top: 0, left: 0, bottom: 10, right: 0)
        
        tableView.register(cellType: XSVipCardHeaderCell.self)
        tableView.register(cellType: XSVipHistoryCell.self)
        
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
    var model:[CLMemberBuyRecordListModel] = []
    
    private lazy var merchantData: Array = {
        return [
            ["title":"续费行膳有味会员月卡", "subtitle": "有效期：2021.6.20  10:00","time":"2021.6.20  10:00","price":"6"],
            ["title":"加量包-2张5元会员红包", "subtitle": "有效期：2021.6.20  10:00","time":"2021.6.20  10:00","price":"8"],
            ["title":"加量包-8张5元会员红包", "subtitle": "有效期：2021.6.20  10:00","time":"2021.6.20  10:00","price":"5"],
            ["title":"续费行膳有味会员季卡", "subtitle": "有效期：2021.6.20  10:00","time":"2021.6.20  10:00","price":"10"],
            ["title":"10元会员购买优惠券", "subtitle": "有效期：2021.6.20  10:00","time":"2021.6.20  10:00","price":"6"],
            ["title":"充值行膳有味会员月卡", "subtitle": "有效期：2021.6.20  10:00","time":"2021.6.20  10:00","price":"5"],
            ["title":"续费行膳有味会员月卡", "subtitle": "有效期：2021.6.20  10:00","time":"2021.6.20  10:00","price":"7"],
            ["title":"续费行膳有味会员月卡", "subtitle": "有效期：2021.6.20  10:00","time":"2021.6.20  10:00","price":"8"],
            ["title":"续费行膳有味会员月卡", "subtitle": "有效期：2021.6.20  10:00","time":"2021.6.20  10:00","price":"4"]
        ]
    }()
    
    override func requestData() {
        super.requestData()
        
        tableView.uempty = UEmptyView(description: "暂无数据")
        tableView.uempty?.emptyState = .noDataState
        tableView.uempty?.allowShow = true
        
        let dic :[String:Any] = [
            "page": 1,
            "pageSize": 10,
            "targetId": 0,
            "targetType": 0,
            "userId": 0
          ]
        myOrderProvider.request(MyOrderService.getMemberBuyRecordList(dic)) { result in
            switch result {
            case let .success(response):

                guard let jsonData = try? JSON(data: response.data) else {
                    return
                }

                if  jsonData["resp_code"].intValue == 0{
                    
                    self.model =  jsonData["data"].arrayValue.compactMap{
                        return CLMemberBuyRecordListModel.init(jsonData: $0 )
                    }
                    
                    DispatchQueue.main.async {
                        
                        for item in self.model {
                            let vModel = XSVipViewModel()
                            vModel.style = .ViewModeStyleTicket(model: "")
                            vModel.height = 95
                            vModel.modle = item
                            self.dataSource.append(vModel)
                        }
                        
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

//        let vModel = XSVipViewModel()
//        vModel.style = .ViewModeStyleHeader
//        vModel.height = 110
//        dataSource.append(vModel)
//
//
//        for i in 0..<merchantData.count {
//            let vModel = XSVipViewModel()
//            vModel.style = .ViewModeStyleTicket
//            vModel.height = 95
//            vModel.modle = merchantData[i]
//            dataSource.append(vModel)
//        }
//
//        let vModel5 = XSVipViewModel()
//        vModel5.style = .ViewModeStyleUsed
//        vModel5.height = 50
//        dataSource.append(vModel5)

    }
    
}
// - 代理
extension XSVipBuyHistoryController : UITableViewDelegate, UITableViewDataSource {
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
            cell.userView.userStackView.userName.text = "行膳有味会员"
            cell.userView.userStackView.userNameTipLab.text = "有效期：2021.06.21-2021.07.20"

            cell.numLab.text = "本月已省520元"
            cell.numLab.jk.setsetSpecificTextFont("520", font:MYBlodFont(size: 22))
            cell.numLab.jk.setsetSpecificTextFont("元", font:MYFont(size: 16))
            
            return cell
        case .ViewModeStyleTicket:
            let cell:XSVipHistoryCell = tableView.dequeueReusableCell(for: indexPath, cellType: XSVipHistoryCell.self)
            cell.model = vModel.modle as! CLMemberBuyRecordListModel
            return cell
        case .ViewModeStyleUsed:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XSBaseTableViewCell.self)
            let btn = QMUIButton()
            btn.setTitle("仅展示仅1年的购买记录", for: UIControl.State.normal)
            btn.titleLabel?.font = MYFont(size: 13)
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
    
}


