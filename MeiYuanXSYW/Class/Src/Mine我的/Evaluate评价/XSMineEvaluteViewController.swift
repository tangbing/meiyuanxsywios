//
//  XSMineEvaluteViewController.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/9/13.
//

import UIKit
import HMSegmentedControl
import SwiftyJSON
import Moya

struct EvaluateModel {
    let evaluateContent: String?
    let evaluatePics: [String]?
    let commendStr: String?
    let repeatStr: String?
}


class XSMineEvaluteViewController: XSBaseViewController {
    
    
    var model:CLMyCenterCommentModel?
    
    let titles = ["全部","晒图","获得回复"]
    
    lazy var segment: HMSegmentedControl = {
        let segment = HMSegmentedControl(sectionTitles: titles)
        segment.type = .text
        segment.backgroundColor = .white
        segment.selectionIndicatorHeight = 1.0
        segment.selectionIndicatorLocation = .bottom
        
        segment.selectedTitleTextAttributes = [ NSAttributedString.Key.foregroundColor : UIColor.hex(hexString: "#DDA877"), NSAttributedString.Key.font : MYFont(size: 14)]
        segment.titleTextAttributes = [ NSAttributedString.Key.foregroundColor : UIColor.hex(hexString: "#737373"), NSAttributedString.Key.font : MYFont(size: 14)]
        
        //segment.selectionIndicatorMaxWidth = 24
        segment.selectionIndicatorColor = UIColor.hex(hexString: "#DDA877")
        
        //segment.frame = CGRect(x:0 , y: 0, width: Int(screenWidth), height: 44)
        segment.addTarget(self, action: #selector(segmentValueChanged), for: .valueChanged)
        return segment
    }()
    
    lazy var tableView : UITableView = {
        let tableV = UITableView.init(frame: CGRect.zero)
        tableV.backgroundColor = .clear
        tableV.tableFooterView = UIView(frame: CGRect.zero)
        tableV.separatorStyle = .none
        tableV.estimatedRowHeight = 600
//        tableV.estimatedSectionHeaderHeight = 0;
//        tableV.estimatedSectionFooterHeight = 0;
        tableV.dataSource = self
        tableV.delegate = self
        tableV.showsVerticalScrollIndicator = false
        return tableV;
    }()
   
    override func setupNavigationItems() {
        super.setupNavigationItems()
        navigationTitle = "发现"
    }
    override func requestData() {
        super.requestData()
        loadEvaluteData(bizType: 0)
    }
    
    func loadEvaluteData(bizType: Int) {
       
        var params = [String:Any]()
        params["commentType"] = bizType
        params["userId"] = 11
        params["page"] = 1
        params["pageSize"] = 1000

        let dic :[String:Any] = ["userId":11]
        myOrderProvider.request(MyOrderService.getMyCommentPageResult(params)) { result in
            switch result {
            case let .success(response):
                guard let jsonData = try? JSON(data: response.data) else {
                    return
                }
                uLog(jsonData)
                if  jsonData["resp_code"].intValue == 0{
                    
                    self.model =  CLMyCenterCommentModel.init(jsonData: jsonData["data"])
                    
                    DispatchQueue.main.async {
                        
                        let segmentTitlesArray = [SegMentModel(mentTitle: "全部", mentBadge: self.model?.allCommentAccount ?? -1),
                                                  SegMentModel(mentTitle: "晒图", mentBadge: self.model?.picAccount ?? -1),
                                                  SegMentModel(mentTitle: "获得回复", mentBadge: self.model?.merchantReplyAccount ?? -1),
                         ]
                         
                         let titles = segmentTitlesArray.map({ segmentModel -> String in
                            return segmentModel.totalResult()
                         })
                        self.segment.sectionTitles = titles

                        
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
    
    override func initSubviews() {
        super.initSubviews()
        view.addSubview(segment)
        segment.snp.makeConstraints {
            $0.left.right.top.equalToSuperview()
            $0.height.equalTo(44)
        }
        
        view.addSubview(tableView)
        tableView.register(cellType: XSMineEvaluateTableViewCell.self)
        tableView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(10)
            $0.right.equalToSuperview().offset(-10)
            $0.top.equalTo(segment.snp_bottom)
            $0.bottom.equalTo(self.view.usnp.bottom)
        }

        uLog("segmentedView:\(segment)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.uempty = UEmptyView(description: "暂无数据")
        tableView.uempty?.emptyState = .noDataState
        tableView.uempty?.allowShow = true
    }
    
    @objc func segmentValueChanged(){
        /// 全部评价0，晒图1,2获得回复.3低分，4最新。（012是我的评价，0134是商家评价）,（用户C端传入）
        var commentType = 0
        if(segment.selectedSegmentIndex == 1) {
            commentType = 1
        } else if(segment.selectedSegmentIndex == 2) {
            commentType = 2
        }
        
       loadEvaluteData(bizType: commentType)
    }
    
}

extension XSMineEvaluteViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XSMineEvaluateTableViewCell.self)
        cell.delegate = self
        cell.evaluateModel = self.model?.data[indexPath.row]
        return cell
    }
    
}

// MARK: - XSMineEvaluateTableViewCellDelegate
extension XSMineEvaluteViewController: XSMineEvaluateTableViewCellDelegate {
    func deleteBtnClick(in cell: XSMineEvaluateTableViewCell) {
        print("deleteBtnClick")
    }
    
    func editBtnClick(in cell: XSMineEvaluateTableViewCell) {
        print("editBtnClick")
    }
    
    func shareBtnClick(in cell: XSMineEvaluateTableViewCell) {
        let sharePop = XSSharePopView()
        sharePop.didSelectShareCompleteBlock = { [weak self] popModel in
            switch popModel.style {
            case .weixin:
                 print(#function)
            case .weixinCircle:
                print(#function)

            default:
                print(#function)

            }
        }
        sharePop.show()
    }
    
    
}
