//
//  TBHomeErrorTicketViewController.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/10/21.
//

import UIKit

class TBHomeErrorTicketViewController: XSBaseViewController {

    lazy var tableView : UITableView = {
        let tableV = UITableView.init(frame: CGRect.zero, style: UITableView.Style.plain)
        tableV.backgroundColor = .background
        tableV.tableFooterView = UIView(frame: CGRect.zero)
        tableV.separatorStyle = .none
        tableV.dataSource = self
        tableV.delegate = self
        tableV.register(cellType: TBHomeTicketTableViewCell.self)
        return tableV;
    }()
    
    var ticketDatas = [TBHomeTicketViewModel]()
    var pageIndex: Int = 1

    
    override func setupNavigationItems() {
        super.setupNavigationItems()
        navigationTitle = "失效的劵"
    }
    
    override func initSubviews() {
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets(top: 0, left: 10, bottom: bottomInset, right: 10))
        }
    }
    
    override func initData(){
        tableView.uempty = UEmptyView(description: "暂无数据")
        tableView.uempty?.emptyState = .noDataState
        tableView.uempty?.allowShow = true
        
        self.loadMyloseTimeTicket(pageIndex: self.pageIndex)
        
        self.tableView.uFoot = URefreshAutoFooter(refreshingBlock: { [weak self] in
        
            guard let self = self else {
                return
            }
            
            self.loadMyloseTimeTicket(pageIndex: self.pageIndex)
            
        })

    }
    
    
    // MARK: - event click
    @objc func timeoutTicketBtnAction() {
        
    }

}


// MARK: - httpRequest
extension TBHomeErrorTicketViewController {
    
    func loadMyloseTimeTicket(pageIndex: Int){
        MerchantInfoProvider.request(.homeGetMyCoupon(couponStatus: 1, useStatus: 0, userId: 0, page: pageIndex, pageSize: pageSize), model: TBHomeMyTicketModel.self, completion: { returnData in
            
            if let myTiketModel = returnData {
                let count = myTiketModel.couponNum
                
                if count > 0 {
                    
                    let myTicketViewModels: [TBHomeTicketViewModel] = myTiketModel.couponVoList.map {
                        let vm = TBHomeTicketViewModel()
                        vm.style = .ViewModeStyleTicketBySelf
                        vm.height = 60
                        vm.modle = $0
                        return vm
                    }
                    
                    self.ticketDatas.appends(myTicketViewModels)
                    self.tableView.reloadData()
                                        
            //        if isNomoreData {
            //            self.tableView.uFoot.endRefreshingWithNoMoreData()
            //        } else {
            //            self.tableView.uFoot.endRefreshing()
            //            pageIndex += 1
            //        }


                }
            }
            
            self.pageIndex += 1
            self.tableView.uFoot.endRefreshing()

            
            
        }, errorResult: { errorMsg in
            self.tableView.uFoot.endRefreshing()

            XSTipsHUD.hideAllTips()
            XSTipsHUD.showText(errorMsg)
        })
        
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension TBHomeErrorTicketViewController: UITableViewDataSource, UITableViewDelegate {
    
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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

