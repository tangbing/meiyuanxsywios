//
//  XSVipTicketController.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/8/6.
//

import UIKit
import QMUIKit
import SwiftyJSON
import Moya

class XSVipTicketController: XSBaseTableViewController {
    
    var pageIndex: Int = 1
    var dataSource = [XSVipViewModel]()
    private var ticketDatas = [TBHomeTicketViewModel]()


    var model :[CLMyCouponModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "我的红包卡券"
    }

    
    override func initData(){
        self.loadMyTicket(pageIndex: self.pageIndex)
        
        self.tableView.uFoot = URefreshAutoFooter(refreshingBlock: { [weak self] in
        
            guard let self = self else {
                return
            }
            
            self.loadMyTicket(pageIndex: self.pageIndex)
           
        })

    }
    
  
    override func initSubviews() {
        super.initSubviews()
        

        tableView.delegate = self
        tableView.dataSource = self

        tableView.contentInset(top: 0, left: 0, bottom: 10, right: 0)
        
        tableView.register(cellType: TBHomeTicketTableViewCell.self)
        
        tableView.uempty = UEmptyView(description: "暂无数据")
        tableView.uempty?.emptyState = .noDataState
        tableView.uempty?.allowShow = true
        
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        view.addSubview(tableView)
        tableView.snp_remakeConstraints { make in
            make.bottom.top.equalTo(0)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }

    }


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
    
}

// MARK: - httpRequest
extension XSVipTicketController {
    
    func loadMyTicket(pageIndex: Int){
        MerchantInfoProvider.request(.homeGetMyCoupon(couponStatus: 0, useStatus: 0, userId: Int(userId)!, page: pageIndex, pageSize: pageSize), model: TBHomeMyTicketModel.self, completion: { returnData in
            
            if let myTiketModel = returnData {
                let count = myTiketModel.couponNum
                
                    let myTicketViewModels: [TBHomeTicketViewModel] = myTiketModel.couponVoList.map {
                        let vm = TBHomeTicketViewModel()
                        vm.style = .ViewModeStyleTicketBySelf
                        vm.height = 60
                        vm.modle = $0
                        return vm
                    }
                
                    self.ticketDatas.appends(myTicketViewModels)
                    
                    if self.ticketDatas.count >= count {
                        self.tableView.uFoot.endRefreshingWithNoMoreData()
                    } else {
                        self.tableView.uFoot.endRefreshing()
                        self.pageIndex += 1
                    }
                    
                    self.tableView.reloadData()
                }

        }, errorResult: { errorMsg in
            self.tableView.uFoot.endRefreshing()

            XSTipsHUD.hideAllTips()
            XSTipsHUD.showText(errorMsg)
        })
        
    }
}

// - 代理
extension XSVipTicketController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return ticketDatas.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TBHomeTicketTableViewCell.self)
        cell.expendButton.tag = indexPath.section
        
        
        cell.model = ticketDatas[indexPath.section]
        cell.useBtnClickHandler = { [weak self] model, nowPullButton in
            guard let weakSelf = self else { return }
            weakSelf.navigationController?.popViewController(animated: true)
            
        }
        cell.expendBtnClickHandler = { [weak self] model ,selectRow in
            guard let weakSelf = self else  { return }
            // 取消之前的选中
            var vm: TBHomeTicketViewModel!
//            for idx in 0..<weakSelf.ticketDatas.count {
//                if idx == selectRow {
//                    continue
//                }
//                vm = weakSelf.ticketDatas[idx]
//                (vm.modle as! FreeCouponVoData).isSelect = false
//            }
            
            vm = weakSelf.ticketDatas[selectRow]
            (vm.modle as! FreeCouponVoData).isSelect = model.isSelect
            
            self?.tableView.reloadData()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let vm = self.ticketDatas[indexPath.section]
        if vm.style == .ViewModeStyleHeader || vm.style == .ViewModeStyleSection { return vm.height }
            
        let height = (vm.modle as! FreeCouponVoData).height
        return height
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let iv = UIView()
        iv.backgroundColor = UIColor.background
        return iv
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let iv = UIView()
        iv.backgroundColor = .red
        return iv
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



