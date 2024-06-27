//
//  XSSettingQuestionController.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/8/6.
//

import UIKit

class XSSettingQuestionController: XSBaseTableViewController {

    var pageIndex: Int = 1
    var questionDataModels: [XSQuestionDataModel] = [XSQuestionDataModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "常见问题"
        // Do any additional setup after loading the view.
    }
//    override func setupNavigationItems() {
//        super.setupNavigationItems()
//        title = "常见问题"
//    }
        
    override func initSubviews() {
        super.initSubviews()
        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(cellType: XSNomalCell.self)
        tableView.register(cellType: XSBaseTableViewCell.self)

        
    }
    var dataSource = [XSSetViewModel]()

    private lazy var tableData: Array = {
        return [
            ["title": "问题名称问题名称问题名称问题问题名称问题名称问题名称问题名称问题问题名称","arrow":"vip_arrow_Check"],
            ["title": "问题名称问题名称问题名称问题问题名称问题名称问题名称问题名称问题问题名称","arrow":"vip_arrow_Check"],
            ["title": "问题名称问题名称问题名称问题问题名称问题名称问题名称问题名称问题问题名称","arrow":"vip_arrow_Check"],
            ["title": "问题名称问题名称问题名称问题问题名称问题名称问题名称问题名称问题问题名称","arrow":"vip_arrow_Check"],
            ["title": "问题名称问题名称问题名称问题问题名称问题名称问题名称问题名称问题问题名称","arrow":"vip_arrow_Check"],
        ]
    }()
        
    
    func setupRefresh() {
        
        self.tableView.uHead = URefreshAutoHeader(refreshingTarget: self, refreshingAction: #selector(headerRereshing))
       
        self.tableView.uFoot = URefreshAutoFooter(refreshingTarget: self, refreshingAction: #selector(footerRereshing))
        
        self.tableView.uHead.beginRefreshing()
        
        
    }
    
    @objc private func headerRereshing() {
        self.loadData(isRefresh: true)
    }
    @objc private func footerRereshing() {
        self.loadData(isRefresh: false)

    }
    
    func loadData(isRefresh: Bool) {
        
        var pageIndex = 0
        if isRefresh {
            pageIndex = 1
            self.pageIndex = 1
        } else {
            pageIndex = self.pageIndex + 1
        }
        
        MerchantInfoProvider.request(.userQuestionList(page: pageIndex, pageSize: pageSize), model: XSQuestionListModel.self) { returnData in
            
            //guard let self = self else { return }
            
            guard let questionListModel = returnData else {
                return
            }
            
            let questionDatas = questionListModel.data
            let count = questionListModel.count
            
            if isRefresh {
                self.questionDataModels = questionDatas
                
                self.dataSource.removeAll()
                
                self.dataSource = self.questionDataModels.map {
                    let vModel0 = XSSetViewModel()
                    vModel0.style = .ViewModeStyleDefault
                    vModel0.height = 51
                    vModel0.modle = $0
                    return vModel0
                }
              

                self.tableView.mj_footer?.isHidden = !(self.questionDataModels.count > 0)
                if self.tableView.mj_footer?.state == .noMoreData {
                    self.tableView.mj_footer?.state = .idle
                }
            } else {
                self.questionDataModels.appends(questionDatas)
                
                self.dataSource = self.questionDataModels.map {
                    let vModel0 = XSSetViewModel()
                    vModel0.style = .ViewModeStyleDefault
                    vModel0.height = 51
                    vModel0.modle = $0
                    return vModel0
                }
                
                self.pageIndex += 1
            }
            
            if self.questionDataModels.count > 0 && count <= self.questionDataModels.count {
                self.tableView.mj_footer?.state = .noMoreData
            }
            self.endLoad(isRefresh: isRefresh)
            
        } errorResult: { errorMsg in
            XSTipsHUD.showError("加载失败，请重试")
            self.endLoad(isRefresh: isRefresh)
        }

    }
    
    func endLoad(isRefresh: Bool) {
        self.tableView.reloadData()
        if isRefresh {
            self.tableView.mj_header?.endRefreshing()
        } else if(!(self.tableView.mj_footer?.isHidden ?? true)) {
            if(self.tableView.mj_footer?.state != .noMoreData) {
                self.tableView.mj_footer?.endRefreshing()
            }
        }
    }
                    
    override func initData() {
        setupRefresh()
    }
    
}
// - 代理
extension XSSettingQuestionController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return dataSource[indexPath.row].height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let vModel = dataSource[indexPath.row]
        switch vModel.style {
        case .ViewModeStyleDefault:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XSNomalCell.self)
            cell.iconImg.isHidden = true
            cell.subLab.isHidden = true
            cell.desLab.isHidden = true
            
            let model = vModel.modle as! XSQuestionDataModel
            
            cell.tipLab.text = model.title
            cell.leftView.snp_remakeConstraints { make in
                make.left.equalTo(16)
                make.right.equalTo(-36)
                make.centerY.equalToSuperview()
            }
            cell.arrowImg.image = UIImage(named: "vip_arrow_Check")
            return cell
        default:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XSBaseTableViewCell.self)
            return cell
        }
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let vModel = dataSource[indexPath.row]
        if vModel.style == .ViewModeStyleDefault{
            let ccell : XSBaseTableViewCell = cell as! XSBaseTableViewCell
            ccell.addLine(frame: CGRect(x: 10, y: cell.frame.height-1, width: cell.frame.width-20, height: 1), color: .borad)
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vModel = dataSource[indexPath.row]
        if vModel.style == .ViewModeStyleDefault{
            let model = vModel.modle as! XSQuestionDataModel
            navigationController?.pushViewController(XSQuestionDetailController(questionId: model.id), animated: true)
            
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
}

