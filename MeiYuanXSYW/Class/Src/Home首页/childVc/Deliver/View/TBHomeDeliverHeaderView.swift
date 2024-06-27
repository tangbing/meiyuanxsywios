//
//  TBHomeDeliverHeaderView.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/10/22.
//

import UIKit
import SwiftyJSON


protocol TBHomeDeliverHeaderViewDelegate: NSObject {
    /// 点击热搜
    func clickHotSearch(_ hotSearchText: String)
    /// 点击金刚区
    func clickJG(_ JGData: KingkongDetal)
    /// 点击推荐区
    func clickCommand(_ JGData: KingkongDetal)

}


class TBHomeDeliverHeaderView: UIView {
    
    private var bannerAndNoticModel: XSHomeBannerAndNoticModel?
    private var secondTicketModel: XSHomeSecondAndTicketModel?
    private var searchDiscoverSigns: [String] = [String]()
    private var explosiveRecommendModels: [TBHomeDeliverHeaderViewExplosiveRecommendModel] = [TBHomeDeliverHeaderViewExplosiveRecommendModel]()
    private var delieveShopRecommand: XSHomeHeaderShopReommand?
    
    weak var delegate: TBHomeDeliverHeaderViewDelegate?
    
    private var countDown: Int = 0
    private var killSecondView :TBKillSecondView = TBKillSecondView()

   var updateDelieveHeaderHeight: ((_ isHasSecondKill: Bool) -> Void)?

    weak var superViewController: UIViewController?
    
    let sectionTitles = ["","","好店推荐","秒杀专场","爆品推荐"]
    lazy var tableView : UITableView = {
        let tableV = UITableView.init(frame: CGRect.zero, style: UITableView.Style.plain)
        tableV.backgroundColor = .background
        tableV.register(cellType: TBDeliverHeaderHotSearchTableViewCell.self)
        tableV.register(cellType: XSHomHeaderJGTableViewCell.self)
        tableV.register(cellType: TBDeliverHeaderTableViewCell.self)
        tableV.register(cellType: TBDeliverHeaderCoverFlowTableViewCell.self)
        tableV.register(cellType: TBHomeDeliverHeaderCommendTableViewCell.self)
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
        NotificationCenter.default.addObserver(self, selector: #selector(self.countDownNotification), name: .CLCountDownNotification, object: nil)

        setupUI()
        loadSecondTicketData()
        loadRecommandData(flage: 0)
        loadJGData()
        loadSearchDiscoverData()
        loadExplosiveRecommend()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.addSubview(tableView)
        tableView.snp_makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.bottom.equalToSuperview()
        }
    }
    
    func setupUI() {
        self.backgroundColor = .background
    }
    
}

// MARK: - HttpRquest
extension TBHomeDeliverHeaderView {
    
    private func loadExplosiveRecommend() {
        
        myOrderProvider.request(MyOrderService.showExplosiveRecommend(businessType: 0, userLat: lat, userLng: lon)) { result in
            switch result {
            case let .success(response):
                guard let jsonData = try? JSON(data: response.data) else {
                    return
                }
                uLog("jsonData:\(jsonData)")

                if  jsonData["resp_code"].intValue == 0{
                    let returnData = jsonData["data"].arrayValue
                    let compactMapData = returnData.map {
                        $0.arrayValue.map {
                            TBHomeDeliverHeaderViewExplosiveRecommendModel.init(jsonData: $0)
                        }
                    }
                    self.explosiveRecommendModels = compactMapData.flatMap { $0}
                    
                    self.tableView.reloadData()
                }else{
                    XSTipsHUD.showText(jsonData["resp_msg"].stringValue)
                }
                
            case .failure(_):
                //网络连接失败，提示用户
                XSTipsHUD.hideAllTips()
                XSTipsHUD.showText("网络连接失败")
            }
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
    
    func loadSecondTicketData() {
        MerchantInfoProvider.request(.getMarketingHomePageVo(goodsType: 0), model:XSHomeSecondAndTicketModel.self ) { returnData in
            guard let indexPageModel = returnData else { return }

            //uLog(indexPageModel)
            self.secondTicketModel = indexPageModel
            
            if let seckill = indexPageModel.secKillHomePageVo,
               seckill.secKillGoodsVos.count <= 0 {
                self.updateDelieveHeaderHeight?(true)
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

             self.delieveShopRecommand = shopRecommand
             self.tableView.reloadData()

             
         } errorResult: { errorMsg in
             XSTipsHUD.hideAllTips()
             XSTipsHUD.showText(errorMsg)
         }
     }
    
    
    func loadJGData() {
         
        MerchantInfoProvider.request(.getGroupBuyPageTopPart(kingKongAreaType: 0), model: XSHomeBannerAndNoticModel.self) { returnData in
             
             guard let indexPageModel = returnData else { return }
             
             //uLog(indexPageModel)
             self.bannerAndNoticModel = indexPageModel
            
             self.tableView.reloadData()
             
         } errorResult: { errorMsg in
             XSTipsHUD.hideAllTips()
             XSTipsHUD.showText(errorMsg)
         }
     }
    
    
    
}

extension TBHomeDeliverHeaderView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
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
            cell.delegate = self
            cell.listData = self.bannerAndNoticModel?.kingkongDetals ?? [KingkongDetal]()
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TBHomeDeliverHeaderCommendTableViewCell.self)
            cell.shopRecommand = delieveShopRecommand?.probeShopDetails.first
            cell.clickHeaderCommendHandler = { [weak self] model in
                let delieveMerchantInfo = TBDeliverMerchanInfoViewController(style: .deliver, merchantId: model.merchantId)
                self?.superViewController?.navigationController?.pushViewController(delieveMerchantInfo, animated: true)
                
            };
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TBDeliverHeaderTableViewCell.self)
            if let secondTicket = self.secondTicketModel?.secKillHomePageVo{
                cell.secKillGoods  = secondTicket.secKillGoodsVos
            }

            return cell
        default:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TBDeliverHeaderCoverFlowTableViewCell.self)
            cell.explosiveRecommendModels = explosiveRecommendModels
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
            if let second = self.secondTicketModel?.secKillHomePageVo,
               second.secKillGoodsVos.count > 0
            {
                return 160
            }
            return 0
        } else {
            return 160
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 3 {
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
        
        let sectionTitle = sectionTitles[section]
        if sectionTitle.count > 1  {
            
            let header = tableView.dequeueReusableHeaderFooterView(TBHomeDeliverReusableView.self)
            header?.indicatorTitle.text = sectionTitles[section]
            if sectionTitles[section] == "秒杀专场" {
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
            }
            
            header?.moreBtnClickHandler = {[weak self] head in
                if head.indicatorTitle.text == "秒杀专场"  {
                    guard let superVc = self?.superViewController else {
                        fatalError()
                    }
                    let second = TBHomeSecondViewController(killSecondStyle: .delivery)
                    second.changeSecondStatus(isFinish: true)
                    superVc.navigationController?.pushViewController(second, animated: true)
                }
            }
            if section == 3 {
                header?.subTitleLab.isHidden = true
                header?.killSecond.isHidden = false
            } else {
                header?.killSecond.isHidden = true
                header?.subTitleLab.isHidden = false
            }
            return header
        }
       return nil
    }
    
    
    @objc private func countDownNotification() {
        // 计算倒计时
        let timeInterval: Int
        timeInterval = CLCountDownManager.sharedManager.timeIntervalWithIdentifier(identifier:"HomeDelieveStartSecondKill")
        let countDown = self.countDown - timeInterval
        // 当倒计时到了进行回调
        if (countDown <= 0) {
            
            // 活动开始
            //loadSecondTicketData()
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
        CLCountDownManager.sharedManager.addSourceWithIdentifier(identifier: "HomeDelieveStartSecondKill")
        uLog(CLCountDownManager.sharedManager.timeIntervalDict)
        

    }
    
}

// MARK: - XSHomHeaderJGTableViewCellDelegate
extension TBHomeDeliverHeaderView: XSHomHeaderJGTableViewCellDelegate {
    func homeHeaderJGClick(_ tableViewCell: XSHomHeaderJGTableViewCell, click itemModel: KingkongDetal) {
        self.delegate?.clickJG(itemModel)
    }
}
