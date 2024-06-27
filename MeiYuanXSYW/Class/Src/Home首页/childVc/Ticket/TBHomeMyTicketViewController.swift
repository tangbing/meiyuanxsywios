//
//  TBHomeMyTicketViewController.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/10/21.
//

import UIKit
import QMUIKit

class TBHomeMyTicketViewController: XSBaseViewController {

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
    
    //进店
    lazy var errorTicketBtn : QMUIButton = {
        let arrowBtn = QMUIButton(type: .custom)
        arrowBtn.imagePosition = QMUIButtonImagePosition.right
        arrowBtn.setTitle("查看无效劵", for: UIControl.State.normal)
        arrowBtn.setImage(UIImage(named: "home_ticket_timeout_right"), for: .normal)
        arrowBtn.setTitleColor(.twoText, for: UIControl.State.normal)
        arrowBtn.titleLabel?.font = MYFont(size: 12)
        arrowBtn.addTarget(self, action: #selector(timeoutTicketBtnAction), for: .touchUpInside)
        return arrowBtn
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func setupNavigationItems() {
        super.setupNavigationItems()
        navigationTitle = "我的红包卡劵"
    }
    
    override func initSubviews() {
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets(top: 0, left: 10, bottom: bottomInset + 60, right: 10))
        }
        
        self.view.addSubview(errorTicketBtn)
        errorTicketBtn.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.usnp.bottom).offset(-20)
            make.centerX.equalToSuperview()
        }
        
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
    
    // MARK: - event click
    @objc func timeoutTicketBtnAction() {
        self.navigationController?.pushViewController(TBHomeErrorTicketViewController(), animated: true)
    }

}

// MARK: - httpRequest
extension TBHomeMyTicketViewController {
    
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


// MARK: - UITableViewDataSource & UITableViewDelegate
extension TBHomeMyTicketViewController: UITableViewDataSource, UITableViewDelegate {
    
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

