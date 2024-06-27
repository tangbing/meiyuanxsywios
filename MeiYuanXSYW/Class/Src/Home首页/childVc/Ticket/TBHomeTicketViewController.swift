//
//  TBHomeTicketViewController.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/10/20.
//

import UIKit


class TBHomeTicketViewController: XSBaseViewController {

    var pageIndex: Int = 1
    
    lazy var tableView : UITableView = {
        let tableV = UITableView.init(frame: CGRect.zero, style: UITableView.Style.plain)
        tableV.backgroundColor = .background
        tableV.tableFooterView = UIView(frame: CGRect.zero)
        tableV.separatorStyle = .none
        tableV.dataSource = self
        tableV.delegate = self
        tableV.register(cellType: TBHomeTicketTableViewCell.self)
        tableV.register(cellType: TBHomeTicketHeaderTableViewCell.self)
        tableV.register(cellType: TBHomeTicketSectionTableViewCell.self)
        return tableV;
    }()

    var ticketDatas = [TBHomeTicketViewModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func setupNavigationItems() {
        super.setupNavigationItems()
        navigationTitle = "领劵专区"
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
       
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets(top: 0, left: 10, bottom: bottomInset, right: 10))
        }
        
    }
    
    @objc func sellAllTicket(){
        
    }
    
    func receiveAndUseBtnClick(model: FreeCouponVoData,receiveAndUseBtn: UIButton){
        if receiveAndUseBtn.currentTitle == "立即使用" {
            
        } else { // 立即领取
            receiveCoupon(model: model)
        }
    }
    
    func receiveCoupon(model: FreeCouponVoData) {
        MerchantInfoProvider.request(.receiveCoupon(couponId: model.couponId), model: XSMerchInfoHandlerModel.self) { [weak self] returnData in
            
            guard let self = self else { return }
            
            if returnData?.trueOrFalse ?? 0 == 0 {
                XSTipsHUD.showSucceed("领取成功")
                
                self.ticketDatas.removeAll()
                self.pageIndex = 1
                self.loadMyTicket(pageIndex: self.pageIndex)
                
            } else {
                XSTipsHUD.showSucceed("领取失败")
            }
            
        } errorResult: { errorMsg in
            print(errorMsg)
            XSTipsHUD.showText(errorMsg)
        }
    }

}

// MARK: - httpRequest
extension TBHomeTicketViewController {
    
    func loadMyTicket(pageIndex: Int){
        MerchantInfoProvider.request(.homeGetMyCoupon(couponStatus: 0, useStatus: 0, userId: 0, page: pageIndex, pageSize: pageSize), model: TBHomeMyTicketModel.self, completion: { returnData in
            
            
            if let myTiketModel = returnData {
                let count = myTiketModel.couponNum
                
                if count > 0 {
                    
                    let headerVm = TBHomeTicketViewModel()
                    headerVm.style = .ViewModeStyleHeader
                    headerVm.height = 60
                    headerVm.modle = myTiketModel
                    self.ticketDatas.append(headerVm)

                    let myTicketViewModels: [TBHomeTicketViewModel] = myTiketModel.couponVoList.map {
                        let vm = TBHomeTicketViewModel()
                        vm.style = .ViewModeStyleTicketBySelf
                        vm.height = 60
                        vm.modle = $0
                        return vm
                    }
                    
                    self.tableView.uFoot.endRefreshingWithNoMoreData()

                    
                    self.ticketDatas.appends(myTicketViewModels)
                    self.tableView.reloadData()

                }
            }
            
            self.pageIndex += 1
            
            self.loadFreeTicket()
            
        }, errorResult: { errorMsg in
            self.tableView.uFoot.endRefreshing()

            XSTipsHUD.hideAllTips()
            XSTipsHUD.showText(errorMsg)
        })
        
    }
    
    
    func loadFreeTicket() {
        
        MerchantInfoProvider.request(.homeGetFreeCoupon(userId: 0, page: 1, pageSize: 1000), designatedPath: "data", model: FreeCouponVoData.self, completion: { returnData in }, pathCompletion: { returnData in
            
            if returnData.count > 0 {
                let headerVm = TBHomeTicketViewModel()
                headerVm.style = .ViewModeStyleSection
                headerVm.height = 60
                headerVm.modle = returnData
                self.ticketDatas.append(headerVm)

                let freeTickeViewModels: [TBHomeTicketViewModel] = returnData.map {
                    let vm = TBHomeTicketViewModel()
                    vm.style = .ViewModeStyleDefault
                    vm.height = 60
                    vm.modle = $0
                    return vm
                }
                self.ticketDatas.appends(freeTickeViewModels)
                
                self.tableView.reloadData()
            }

        }, errorResult: { errorMsg in
            XSTipsHUD.hideAllTips()
            XSTipsHUD.showText(errorMsg)
        })
                                     
    }
}


extension TBHomeTicketViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return ticketDatas.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let vModel = ticketDatas[indexPath.section]
        switch vModel.style {
            case .ViewModeStyleHeader:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TBHomeTicketHeaderTableViewCell.self)
            //cell.seeAllBtn.addTarget(self, action:#selector(sellAllTicket) , for: .touchUpInside)
            if let headerModel = vModel.modle as? TBHomeMyTicketModel {
                cell.seeAllBtn.setTitle("查看全部(全部\(headerModel.couponNum)张)", for: .normal)
            }
            return cell
            
        case .ViewModeStyleSection:
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TBHomeTicketSectionTableViewCell.self)
        return cell
                
        case .ViewModeStyleDefault:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TBHomeTicketTableViewCell.self)
            cell.expendButton.tag = indexPath.section
            
            
            cell.model = ticketDatas[indexPath.section]
            cell.useBtnClickHandler = { [weak self] model, useButton in
                self?.receiveAndUseBtnClick(model: model, receiveAndUseBtn: useButton)
            }
            cell.expendBtnClickHandler = { [weak self] model ,selectRow in
                guard let weakSelf = self else  { return }
                // 取消之前的选中
                var vm: TBHomeTicketViewModel!
//                for idx in 0..<weakSelf.ticketDatas.count {
//                    if idx == selectRow {
//                        continue
//                    }
//                    vm = weakSelf.ticketDatas[idx]
//                    (vm.modle as! FreeCouponVoData).isSelect = false
//                }
                
                vm = weakSelf.ticketDatas[selectRow]
                (vm.modle as! FreeCouponVoData).isSelect = model.isSelect
                
                self?.tableView.reloadData()
            }

            return cell

        case .ViewModeStyleTicketBySelf:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TBHomeTicketTableViewCell.self)
            cell.expendButton.tag = indexPath.section
            
            
            cell.model = ticketDatas[indexPath.section]
            cell.useBtnClickHandler = { [weak self] model, useButton in
                self?.receiveAndUseBtnClick(model: model, receiveAndUseBtn: useButton)
            }
            
            cell.expendBtnClickHandler = { [weak self] model ,selectRow in
                guard let weakSelf = self else  { return }
                // 取消之前的选中
                var vm: TBHomeTicketViewModel!
                
//                let ticket = weakSelf.ticketDatas.filter( $0.style == .ViewModeStyleTicketBySelf || $0.style == .ViewModeStyleDefault)
//
//
//                for idx in 0..<weakSelf.ticketDatas.count {
//                    if idx == selectRow {
//                        continue
//                    }
//                    vm = weakSelf.ticketDatas[idx]
//                    (vm.modle as! FreeCouponVoData).isSelect = false
//                }
                
                vm = weakSelf.ticketDatas[selectRow]
                (vm.modle as! FreeCouponVoData).isSelect = model.isSelect

                self?.tableView.reloadData()
            }

            return cell
        }
        

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let vm = self.ticketDatas[indexPath.section]
        if vm.style == .ViewModeStyleHeader || vm.style == .ViewModeStyleSection { return vm.height }
            
        let height = (vm.modle as! FreeCouponVoData).height
        return height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vModel = ticketDatas[indexPath.section]

        if vModel.style == .ViewModeStyleHeader {
            let myTicket = TBHomeMyTicketViewController()
            self.navigationController?.pushViewController(myTicket, animated: true)
        }
        
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
