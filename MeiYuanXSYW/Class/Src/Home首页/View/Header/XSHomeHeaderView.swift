//
//  XSHomeHeaderView.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/9/24.
//

import UIKit
import SwiftyJSON


protocol XSHomeHeaderViewDelegate: NSObjectProtocol {
    func clickHeaderSecondLeftView(_ header: XSHomeHeaderView)
    func clickHeaderSecondRightView(_ header: XSHomeHeaderView)
    func clickHeaderJGTableViewCell(_ header: XSHomeHeaderView, click itemModel: KingkongDetal)
}

class XSHomeHeaderView: UIView {
    weak var delegate: XSHomeHeaderViewDelegate?
    
    private var bannerAndNoticModel: XSHomeBannerAndNoticModel?
    private var secondTicketModel: XSHomeSecondAndTicketModel?
    private var searchDiscoverSigns: [String] = [String]()

    lazy var tableView : UITableView = {
        let tableV = UITableView.init(frame: CGRect.zero, style: UITableView.Style.plain)
        tableV.backgroundColor = .background
        tableV.register(cellType: XSHomeHeaderBannerTableViewCell.self)
        tableV.register(cellType: XSHomHeaderJGTableViewCell.self)
        tableV.register(cellType: XSHomeHeaderAdvTableViewCell.self)
        tableV.register(cellType: XSHomeHeaderSecondTableViewCell.self)
        tableV.register(cellType: XSHomeHeaderMeituanTableViewCell.self)
        tableV.isScrollEnabled = false
        tableV.tableFooterView = UIView(frame: CGRect.zero)
        tableV.separatorStyle = .none
        tableV.dataSource = self
        tableV.delegate = self
        return tableV;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        loadbannerAndNoticData()
        loadSecondTicketData()
        loadSearchDiscoverData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.backgroundColor = .background
        self.addSubview(tableView)
        tableView.snp_makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.bottom.equalToSuperview()
        }
    }
    
}

// MARK: - HttpRequest
extension XSHomeHeaderView {
        
    private func loadbannerAndNoticData() {

        MerchantInfoProvider.request(.getIndexPageTopPart(advertiseAreaType: 0, kingKongAreaType: nil), model: XSHomeBannerAndNoticModel.self) { returnData in
            
            guard let indexPageModel = returnData else { return }
            
            //uLog(indexPageModel)
            self.bannerAndNoticModel = indexPageModel
            self.tableView.reloadData()
            
        } errorResult: { errorMsg in
            XSTipsHUD.hideAllTips()
            XSTipsHUD.showText(errorMsg)
        }
    }
    
    func loadSecondTicketData() {
        MerchantInfoProvider.request(.getMarketingHomePageVo(goodsType: nil), model:XSHomeSecondAndTicketModel.self ) { returnData in
            guard let indexPageModel = returnData else { return }

            //uLog(indexPageModel)
            self.secondTicketModel = indexPageModel
            self.tableView.reloadData()

        } errorResult: { errorMsg in
            XSTipsHUD.hideAllTips()
            XSTipsHUD.showText(errorMsg)
        }
    }
    
   private func loadSearchDiscoverData() {
        myOrderProvider.request(.getSearchDiscover(userId: nil)) { result in
            switch result {
            case let .success(response):
                guard let jsonData = try? JSON(data: response.data) else {
                    return
                }
                if  jsonData["resp_code"].intValue == 0{
                    uLog(jsonData["data"])
                    
                    if let signs = jsonData["data"].arrayObject as? [String] {
                        self.searchDiscoverSigns = signs
                        self.tableView.reloadData()
                    }
                    
                }else{
                    XSTipsHUD.showText(jsonData["resp_msg"].stringValue)
                }

             case let .failure(error):
                //网络连接失败，提示用户
                print("网络连接失败\(error)")
            }
        }
    }
        
}

extension XSHomeHeaderView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XSHomeHeaderBannerTableViewCell.self)
            cell.slidesList = self.bannerAndNoticModel?.advertiseDetails
            cell.signs = self.searchDiscoverSigns
            cell.hotBtnClickHandler = { btnTitle in
                let homeSearch = XSHomeSearchViewController()
                topVC?.navigationController?.pushViewController(homeSearch, animated: true)
                
                homeSearch.searchText = btnTitle

            }
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XSHomHeaderJGTableViewCell.self)
            cell.delegate = self
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XSHomeHeaderAdvTableViewCell.self)
            cell.signDataArray = self.bannerAndNoticModel?.noticeDetails
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XSHomeHeaderSecondTableViewCell.self)
            if let secondTicket = self.secondTicketModel?.secKillHomePageVo{
                cell.secondTicketModel = secondTicket
            }
            
            if let free = self.secondTicketModel?.freeCouponVos  {
                cell.freeCouponVos = free
            }
            
            cell.killSecondStartHandler = {[weak self] in
               // self?.loadSecondTicketData()
            }
            cell.clickLeftMoreViewHandler = {[weak self] in
                self?.delegate?.clickHeaderSecondLeftView(self!)
            }
            cell.clickRightMoreViewHandler = {[weak self] in
                self?.delegate?.clickHeaderSecondRightView(self!)
            }
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XSHomeHeaderMeituanTableViewCell.self)
            return cell
        default:
            break
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 176
        } else if indexPath.section == 1 {
            return 165
        } else if indexPath.section == 2 {
            return 40
        } else if indexPath.section == 3 {
            return 210
        } else if indexPath.section == 4 {
            return 180
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let iv = UIView()
        iv.backgroundColor = .background
        return iv
    }

}

// MARK: - XSHomHeaderJGTableViewCellDelegate
extension XSHomeHeaderView: XSHomHeaderJGTableViewCellDelegate {
    func homeHeaderJGClick(_ tableViewCell: XSHomHeaderJGTableViewCell, click itemModel: KingkongDetal) {
        delegate?.clickHeaderJGTableViewCell(self, click: itemModel)
    }

}
