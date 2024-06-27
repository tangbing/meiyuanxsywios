//
//  XSDiscoverController.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/8/6.
//

import UIKit

class XSDiscoverController: XSBaseViewController {

    var datas =  [XSDiscoverSectionViewModel]()
    
    
    lazy var customNavBar: UIView = {
        let custNav = TBHomeCustomNavBar()
        if let locationStr = UserDefaults.standard.string(forKey: kCurrCityStr) {
            custNav.selectLocationBtn.setTitle(locationStr, for: .normal)
        }
        custNav.searchTextFieldDidBeginEditingBlock = { nav in
            self.navigationController?.pushViewController(XSDiscoverSearchViewController(), animated: true)
        }
        custNav.searchGoSelectLocationBlock = { nav in
            let selectLocation = TBHomeSelectLocationViewController()
            selectLocation.didSelectAddressBlock = {
                if let locationStr = UserDefaults.standard.string(forKey: kCurrCityStr) {
                    custNav.selectLocationBtn.setTitle(locationStr, for: .normal)
                }
            }
            self.navigationController?.pushViewController(selectLocation, animated: true)

            
        }
        custNav.searchGoMessageBlock = { nav in
            let pop = XSDiscoverPopView()
            pop.show()
        }
        return custNav
    }()
    
    lazy var discoverTableView: TBBaseTableView = {
        let discoverTable = TBBaseTableView(frame: .zero, style: .plain)
        discoverTable.register(headerFooterViewType: TBHomeDeliverReusableView.self)
        discoverTable.register(cellType: XSDiscoverTopTableViewCell.self)
        discoverTable.register(cellType: XSDiscoverRecommandTableViewCell.self)
        discoverTable.backgroundColor = .background
        discoverTable.dataSource = self
        discoverTable.delegate = self
        discoverTable.tableFooterView = UIView()
        return discoverTable
    }()
    
    override func preferredNavigationBarHidden() -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        self.view.addSubview(customNavBar)
        customNavBar.snp.makeConstraints { make in
            make.top.equalTo(self.view.usnp.top)
            make.left.right.equalToSuperview()
        }
        
        self.view.addSubview(discoverTableView)
        discoverTableView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(customNavBar.snp_bottom).offset(10)
            make.bottom.equalTo(self.view.snp_bottom).offset(0)
        }
        
        
    }
    
    override func initData() {
        super.initData()
        let viemModel = XSDiscoverSectionViewModel()
        viemModel.fetchData()

        datas = viemModel.sections
        discoverTableView.reloadData()
    }

}

extension XSDiscoverController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionModel = datas[section]
        return sectionModel.cellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionModel = datas[indexPath.section]
        let rowModel = sectionModel.cellViewModels[indexPath.row]
        
        switch rowModel.style {
        case .studySpace :
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XSDiscoverTopTableViewCell.self)
            
            return cell
        default:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XSDiscoverRecommandTableViewCell.self)
            let recommandModel = rowModel as! XSDiscoverRecomandModel
            cell.bindViewModel(viewModel: recommandModel)
            return cell
        }
      
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sectionModel = datas[indexPath.section]
        let rowModel = sectionModel.cellViewModels[indexPath.row]
        return rowModel.rowHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let sectionModel = datas[section]
        guard let _ = sectionModel.sectionHeaderTitle else {
            return 0.001
        }
        return 40
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionModel = datas[section]
        
        guard let sectionText = sectionModel.sectionHeaderTitle else {
            return nil
        }
        
        let header = tableView.dequeueReusableHeaderFooterView(TBHomeDeliverReusableView.self)!
        header.configMerchInfo()
        header.moreBtnClickHandler = {[weak self] header in
            /// 跳到吃货研究所列表界面
            self?.navigationController?.pushViewController(XSDiscoverStudySpaceListViewController(), animated: true)
        }
        header.indicatorTitle.text = sectionText
        return header
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let iv = UIView()
        iv.backgroundColor = .background
        return iv
    }
    
    
}
