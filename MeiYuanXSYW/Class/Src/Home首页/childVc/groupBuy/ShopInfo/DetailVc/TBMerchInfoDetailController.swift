//
//  TBMerchInfoDetailController.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/3.
//

import UIKit

enum TBMerchInfoDetailStyle {
    case address
    case system
    case time
    case publicNote
    case merchService
    case merchFeedback
}

class TBDetailViewModel {
    var detailStyle: TBMerchInfoDetailStyle = .address
    var sectionContent: String = ""
    var rowModel: [TBDetailModel]?
}

struct TBDetailModel {
    var title: String = ""
    var subTitle: String = ""
    var cellHeight: CGFloat = 0
    var tags: [String] = [String]()
    var rowStyle: TBMerchInfoDetailStyle = .system
}


class TBMerchInfoDetailController: TBBasePageScrollViewController {
    
    var detailModel: TBDelieveMerchatInfoModel!
    
    var dataModels: [TBDetailViewModel] = [TBDetailViewModel]()
    let systemID = "system"
    
    override func setupNavigationItems() {
        super.setupNavigationItems()

//        let shareItem = UIBarButtonItem(image: UIImage(named: "nav_share_black_icon"), style: .plain, target: self, action: #selector(shareAction))
//
//        let collectItem = UIBarButtonItem(image:UIImage(named: "nav_collect_black_icon"), style: .plain, target: self, action: #selector(collectAction))
//        self.navigationItem.rightBarButtonItems = [shareItem, collectItem]
        
//        self.gk_navRightBarButtonItems = [shareItem, collectItem]
    }
    
    lazy var feedBackView: UIView = {
       let iv = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 44))
        iv.backgroundColor = .red
        return iv
    }()
    
    lazy var tableView : UITableView = {
        let tableV = TBBaseTableView(frame: .zero, style: .plain)
        tableV.backgroundColor = .background
        tableV.separatorColor = UIColor.hexStringColor(hexString: "#000000", alpha: 0.1)
        tableV.separatorInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
      
        tableV.register(cellType: TBMerchInfoDetailTimeCell.self)
        tableV.register(cellType: TBMerchInfoDetailAddressCell.self)
        tableV.register(UITableViewCell.self, forCellReuseIdentifier: systemID)
        tableV.register(cellType: TBMerchInfoDetailPublicNoteCell.self)
        tableV.register(cellType: TBMerchInfoDetailMerchServiceCell.self)
        tableV.register(cellType: TBMerchInfoDetailFeedBackCell.self)
        tableV.tableFooterView = UIView()
        tableV.dataSource = self
        tableV.delegate = self
        
        return tableV;
    }()
    
    func setupDataModel(_ detailModel: TBDelieveMerchatInfoModel) {
        
        self.detailModel = detailModel
        
        
        let vm1 = TBDetailViewModel()
        vm1.detailStyle = .address
        let model1 = TBDetailModel(title: detailModel.merchantName, subTitle: detailModel.merchantAddress, cellHeight: -1,rowStyle: .address)
        vm1.rowModel = [model1]
        dataModels.append(vm1)
        
        
        let vm2 = TBDetailViewModel()
        vm2.detailStyle = .system
        let model2 = TBDetailModel(title: "商家资质", subTitle: detailModel.merchantAddress, cellHeight: 52, rowStyle: .system)
//        let model3 = TBDetailModel(title: "其他门店", subTitle: "罗湖桂园路255国贸商城5层452号", cellHeight: 52, rowStyle: .system)
        var subTimeStr = "周一至周日  0:00-24:00"
        
        detailModel.onDuty = 1
        
        if detailModel.onDuty == 1 {// 自定义
            if let array = configTime(detailModel.openingHoursWeekVos),
                    array.count > 1 {
                subTimeStr = (array.first)! + "\n" + (array.last)!
            }
        }
       
        let model4 = TBDetailModel(title: "营业时间", subTitle: subTimeStr, cellHeight: -1, rowStyle: .time)
        let model5 = TBDetailModel(title: "商家公告", subTitle: detailModel.storeNotice, cellHeight: -1, rowStyle: .publicNote)
        vm2.rowModel = [model2,model4,model5]
        dataModels.append(vm2)
        
          /// 第一期不做，第二期加上，故注释
//        let vm3 = TBDetailViewModel()
//        vm3.detailStyle = .merchService
//        vm3.sectionContent = "sectionContent"
//        let modelService = TBDetailModel(title: "商家服务", subTitle: detailModel.merchantAddress, cellHeight: -1, tags: ["Wi-Fi","充电宝","宝宝座椅","无障碍通道","可停车","Wi-Fi","Wi-Fi","充电宝","宝宝座椅"], rowStyle: .merchService)
//
//        vm3.rowModel = [modelService]
//        dataModels.append(vm3)
        
        
        let vm4 = TBDetailViewModel()
        vm4.detailStyle = .merchFeedback
        let modelFeedBack = TBDetailModel(title: "商家投诉", subTitle: detailModel.merchantAddress, cellHeight: 44,rowStyle: .merchFeedback)
        vm4.rowModel = [modelFeedBack]
        dataModels.append(vm4)
        
        tableView.reloadData()

    }
    
    func configTime(_ weekVo: [OpeningHoursWeekVo]?) -> [String]? {
        guard let weekVoModel = weekVo else {
            return nil
        }
        var resultStr = [String]()
       
        for weekModel in weekVoModel {
            var timePrefixStr: String = ""
            weekModel.weekTime?.forEach({
                if $0 == "6" {
                    timePrefixStr.append("周六")
                } else if $0 == "7" {
                    timePrefixStr.append("周日")
                } else if $0 == "1" {
                    timePrefixStr.append("周一")
                } else if $0 == "2" {
                    timePrefixStr.append("周二")
                } else if $0 == "3" {
                    timePrefixStr.append("周三")
                } else if $0 == "4" {
                    timePrefixStr.append("周四")
                } else if $0 == "5" {
                    timePrefixStr.append("周五")
                }
            })
            
            var timeSuffixStr: String = ""
            weekModel.hoursTimesVos?.forEach({
                timeSuffixStr.append("\($0.startTime)" + " - " + "\($0.endTime)" + " ")
            })
            
            resultStr.append(timePrefixStr + " " + timeSuffixStr)
            
        }
        return resultStr
    }
    
    override func initData() {
        super.initData()
    }
    
    override func initSubviews() {
        super.initSubviews()
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(self.view.usnp.top).offset(0)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(self.view.usnp.bottom)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
   override func listViewDidScroll(callBack: @escaping (UIScrollView) -> ()) {
        self.scrollCallBack = callBack
    }
    //
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.scrollCallBack?(scrollView)
    }
    
    override func listScrollView() -> UIScrollView {
        return tableView
    }
    override func setContentInset(bottomInset: CGFloat){
         tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: bottomInset, right: 0)
     }
    
 

}

extension TBMerchInfoDetailController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionModel = dataModels[section]
        guard let rowModels = sectionModel.rowModel else {
            return 0
         }
        return rowModels.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let sectionModel = dataModels[indexPath.section]
        let rowModels = sectionModel.rowModel!
        let rowModel = rowModels[indexPath.row]
        
        switch rowModel.rowStyle {
        case .address:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TBMerchInfoDetailAddressCell.self)
            cell.detailModel = rowModel
            return cell
        case .system:
            let cell = tableView.dequeueReusableCell(withIdentifier: systemID)!
            cell.textLabel?.text = rowModel.title
            cell.accessoryType = .disclosureIndicator
            cell.selectionStyle = .none
            cell.textLabel?.font = MYFont(size: 14)
            cell.textLabel?.textColor = .text
            return cell
        case .time:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TBMerchInfoDetailTimeCell.self)
            cell.titleLab.text = rowModel.title
            cell.timeLabel.text = rowModel.subTitle
            return cell
        case .publicNote:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TBMerchInfoDetailPublicNoteCell.self)
            cell.titleLab.text = rowModel.title
            cell.noteContentLab.text = rowModel.subTitle
            return cell
        case .merchService:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TBMerchInfoDetailMerchServiceCell.self)
            cell.tagLayout(tags: rowModel.tags)
            cell.serviceTitleLab.text = rowModel.title
            return cell
        default:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TBMerchInfoDetailFeedBackCell.self)
            cell.feedBackTitleLab.text = rowModel.title
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let sectionModel = dataModels[indexPath.section]
        let rowModels = sectionModel.rowModel!
        let rowModel = rowModels[indexPath.row]
        
        if rowModel.cellHeight == -1 {
            return UITableView.automaticDimension
        }
        return rowModel.cellHeight
    }

    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let iv = UIView()
        iv.backgroundColor = .red
        return iv
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let iv = UIView()
        iv.backgroundColor = UIColor.background
        return iv
    }
    
    
}

extension TBMerchInfoDetailController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sectionModel = dataModels[indexPath.section]
        let rowModels = sectionModel.rowModel!
        let rowModel = rowModels[indexPath.row]
        
        switch rowModel.rowStyle {
        case .merchFeedback:
            let compain = TBMerchInfoCompainViewController(merchantId: merchantId)
            compain.detailModel = self.detailModel
            self.navigationController?.pushViewController(compain, animated: true)
        case .system:
            let license = TBMerchinfoLicenseViewController()
            license.dataModels = detailModel
            self.navigationController?.pushViewController(license, animated: true)
            break
        default:
            break
        }
    }
}

