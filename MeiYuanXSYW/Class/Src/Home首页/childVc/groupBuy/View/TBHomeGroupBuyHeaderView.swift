//
//  TBHomeGroupBuyHeaderView.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/10/26.
//

import UIKit
import SwiftyJSON


class TBHomeGroupBuyHeaderView: UIView {
    
    weak var delegate: TBHomeDeliverHeaderViewDelegate?

    weak var superViewController: UIViewController?
    
    private var bannerAndNoticModel: XSHomeBannerAndNoticModel?
    private var secondTicketModel: XSHomeSecondAndTicketModel?
    private var searchDiscoverSigns: [String] = [String]()
    private var groupBuyShopRecommand: XSHomeHeaderShopReommand?

    private var countDown: Int = 0
    private var killSecondView :TBKillSecondView = TBKillSecondView()
    
    var updateGroupBuyHeaderHeight: ((_ isHasSecondKill: Bool) -> Void)?

    
    let sectionTitles = ["","","","好店推荐","秒杀专场"]
    lazy var tableView : UITableView = {
        let tableV = UITableView.init(frame: CGRect.zero, style: UITableView.Style.plain)
        tableV.backgroundColor = .background
        tableV.register(cellType: TBDeliverHeaderHotSearchTableViewCell.self)
        tableV.register(cellType: XSHomHeaderJGTableViewCell.self)
        tableV.register(cellType: TBDeliverHeaderTableViewCell.self)
        tableV.register(cellType: TBHomeDeliverHeaderCommendTableViewCell.self)
        tableV.register(cellType: TBGroupBuyHeaderBannerTableViewCell.self)
        tableV.register(headerFooterViewType: TBHomeDeliverReusableView.self)
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
        loadSearchDiscoverData()
        loadbannerAndNoticData()
        loadSecondTicketData()
        loadRecommandData(flage: 1)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.groupBuyCountDownNotification), name: .CLCountDownNotification, object: nil)
        
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
extension TBHomeGroupBuyHeaderView {
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
    private func loadbannerAndNoticData() {

        MerchantInfoProvider.request(.getIndexPageTopPart(advertiseAreaType: 1, kingKongAreaType: 1), model: XSHomeBannerAndNoticModel.self) { returnData in
            
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
        MerchantInfoProvider.request(.getMarketingHomePageVo(goodsType: 1), model:XSHomeSecondAndTicketModel.self ) { returnData in
            guard let indexPageModel = returnData else { return }

            //uLog(indexPageModel)
            self.secondTicketModel = indexPageModel
            
            if let seckill = indexPageModel.secKillHomePageVo,
               seckill.secKillGoodsVos.count <= 0 {
                self.updateGroupBuyHeaderHeight?(true)
            }
            
            self.tableView.reloadData()

        } errorResult: { errorMsg in
            XSTipsHUD.hideAllTips()
            XSTipsHUD.showText(errorMsg)
        }
    }
    
    private func loadRecommandData(flage: UInt) {

         MerchantInfoProvider.request(.getFrontPageProbeShopRecommend(lat:lat , lng: lon, flag: Int(flage)), model: XSHomeHeaderShopReommand.self) { returnData in
             
             guard let shopRecommand = returnData else {
                 return
             }

             self.groupBuyShopRecommand = shopRecommand
             self.tableView.reloadData()

             
         } errorResult: { errorMsg in
             XSTipsHUD.hideAllTips()
             XSTipsHUD.showText(errorMsg)
         }
     }
    
}

extension TBHomeGroupBuyHeaderView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TBDeliverHeaderHotSearchTableViewCell.self)
            cell.recommands = self.searchDiscoverSigns
            cell.delieveHotBtnClick = {
                self.delegate?.clickHotSearch($0)
            }
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XSHomHeaderJGTableViewCell.self)
            cell.listData = self.bannerAndNoticModel?.kingkongDetals ?? [KingkongDetal]()
            cell.delegate = self
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TBGroupBuyHeaderBannerTableViewCell.self)
            cell.slidesList = self.bannerAndNoticModel?.advertiseDetails
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TBHomeDeliverHeaderCommendTableViewCell.self)
            cell.shopRecommand = groupBuyShopRecommand?.probeShopDetails.first

            cell.clickHeaderCommendHandler = { [weak self] model in
                
                let groupBuyMerchInfo = TBGroupBuyMerchInfoViewController(style: .groupBuy, merchantId: model.merchantId)

                self?.superViewController?.navigationController?.pushViewController(groupBuyMerchInfo, animated: true)
            }
            return cell
        default:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TBDeliverHeaderTableViewCell.self)
            if let secondTicket = self.secondTicketModel?.secKillHomePageVo{
                cell.secKillGoods  = secondTicket.secKillGoodsVos
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 36
        } else if indexPath.section == 1 {
            return 165
        } else if indexPath.section == 2 {
            return 120
        } else if(indexPath.section == 3){
            return 120
        } else {
            if let second = self.secondTicketModel?.secKillHomePageVo,
               second.secKillGoodsVos.count > 0
            {
                return 160
            }
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 4 {
            if let second = self.secondTicketModel?.secKillHomePageVo,
               second.secKillGoodsVos.count > 0
            {
                return 10
            }
            return 0.001
        }
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let iv = UIView()
        iv.backgroundColor = .background
        return iv
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let textTitle = sectionTitles[section]
        if sectionTitles[section] == "秒杀专场" {
            
            if let second = self.secondTicketModel?.secKillHomePageVo,
               second.secKillGoodsVos.count > 0
            {
                return 40
            }
            return 0.001
            
        } else {
            if textTitle.count > 0 { return 40 }
        }
        return 0.001
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let textTitle = sectionTitles[section]
        if textTitle.count > 0 {
            let header = tableView.dequeueReusableHeaderFooterView(TBHomeDeliverReusableView.self)
            header?.indicatorTitle.text = sectionTitles[section]
            
            if sectionTitles[section] == "秒杀专场" {
                
                header?.subTitleLab.isHidden = true
                header?.killSecond.isHidden = false
                header?.moreBtn.isHidden = false
                
                if let secondTicket = self.secondTicketModel?.secKillHomePageVo,
                   secondTicket.countDown > 0 {
                    
                    let tiemStr = Date.jk.getFormatPlayTime(seconds: secondTicket.countDown, type: .hour)
                    let times = tiemStr.components(separatedBy: ":")
                    

                    header?.killSecond.hour.text = times[0]
                    header?.killSecond.minute.text = times[1]
                    header?.killSecond.second.text = times[2]

                    
                    // 开启定时器秒杀哦
                    self.countDown = secondTicket.countDown
                    self.killSecondView = header?.killSecond ?? TBKillSecondView()
                    
                    startSecondKill(countDown: secondTicket.countDown)
                    
                    //cell.secondTicketModel = secondTicket
                  

                }
            } else {
                header?.killSecond.isHidden = true
                header?.subTitleLab.isHidden = false
                header?.moreBtn.isHidden = true
            }
            
            
            header?.moreBtnClickHandler = {[weak self] head in
                if head.indicatorTitle.text == "秒杀专场"  {
                    guard let superVc = self?.superViewController else {
                        fatalError()
                    }
                    let second = TBHomeSecondViewController(killSecondStyle: .groupBy)
                    second.changeSecondStatus(isFinish: true)
                    superVc.navigationController?.pushViewController(second, animated: true)
                }
            }

            return header
        }
        return nil
    }
    
    @objc private func groupBuyCountDownNotification() {
        // 计算倒计时
        let timeInterval: Int
        timeInterval = CLCountDownManager.sharedManager.timeIntervalWithIdentifier(identifier:"HomeGroupBuyStartSecondKill")
        let countDown = self.countDown - timeInterval
        // 当倒计时到了进行回调
        if (countDown <= 0) {
            
            // 活动开始
            // loadSecondTicketData()
            uLog(" handler()")
            
        }else{
            // 重新赋值
            let tiemStr = Date.jk.getFormatPlayTime(seconds: countDown, type: .hour)
            let times = tiemStr.components(separatedBy: ":")
            
            self.killSecondView.hour.text = times[0]
            self.killSecondView.minute.text = times[1]
            self.killSecondView.second.text = times[2]
            
        }
    }
    
    func startSecondKill(countDown: Int) {
        
        CLCountDownManager.sharedManager.start()
        CLCountDownManager.sharedManager.addSourceWithIdentifier(identifier: "HomeGroupBuyStartSecondKill")
        uLog(CLCountDownManager.sharedManager.timeIntervalDict)
        

    }
    
    
}

// MARK: - XSHomHeaderJGTableViewCellDelegate
extension TBHomeGroupBuyHeaderView : XSHomHeaderJGTableViewCellDelegate {
    func homeHeaderJGClick(_ tableViewCell: XSHomHeaderJGTableViewCell, click itemModel: KingkongDetal) {
        self.delegate?.clickJG(itemModel)
    }
}
