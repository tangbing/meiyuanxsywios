//
//  XSVipAddBuyController.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/8/6.
//

import UIKit
import QMUIKit
import SwiftyJSON
import Moya

class XSVipAddBuyController: XSBaseTableViewController {
    
    var model :CLAddPackageModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "加量包购买"
        // Do any additional setup after loading the view.
    }
//    override func setupNavigationItems() {
//        super.setupNavigationItems()
//        title = "加量包购买"
//    }
    
    var addPackageId:String = ""
    
    override func requestData() {
        super.requestData()
        myOrderProvider.request(MyOrderService.getAddPackageVo(addPackageId)) { result in
            switch result {
            case let .success(response):
                guard let jsonData = try? JSON(data: response.data) else {
                    return
                }
                if  jsonData["resp_code"].intValue == 0{
                    
                    self.model =   CLAddPackageModel.init(jsonData: jsonData["data"])
                    DispatchQueue.main.async {
                        
                        let vModel = XSVipViewModel()
                        vModel.style = .ViewModeStyleHeader
                        vModel.height = 125
                        self.dataSource.append(vModel)
                        

                        let vModel3 = XSVipViewModel()
                        vModel3.style = .ViewModeStyleAddBuy
                        self.dataSource.append(vModel3)
                        
                        
                        let vModel4 = XSVipViewModel()
                        vModel4.style = .ViewModeStyleAddBuy
                        self.dataSource.append(vModel4)
                        
                        self.bottomView.money = self.model!.discountAmt
                        
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
    
    let bottomView = XSVipBuyFooterView()

    override func initSubviews() {
        super.initSubviews()
        tableView.backgroundColor = .background

        tableView.delegate = self
        tableView.dataSource = self

        tableView.contentInset(top: 0, left: 0, bottom: 10, right: 0)
        
        tableView.register(cellType: XSVipAddBuyHeaderCell.self)
        
        tableView.register(cellType: XSVipAddBuyCell.self)
        
        tableView.register(cellType: XSBaseTableViewCell.self)

    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        view.addSubview(bottomView)
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

}
// - 代理
extension XSVipAddBuyController : UITableViewDelegate, UITableViewDataSource {
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
            let cell:XSVipAddBuyHeaderCell = tableView.dequeueReusableCell(for: indexPath, cellType: XSVipAddBuyHeaderCell.self)
            cell.model = self.model
            return cell
        case .ViewModeStyleAddBuy:
            let cell:XSVipAddBuyCell = tableView.dequeueReusableCell(for: indexPath, cellType: XSVipAddBuyCell.self)

            return cell
        default:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XSBaseTableViewCell.self)
            cell.backgroundColor = .background
            return cell
        }
    }
}


