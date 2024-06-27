//
//  XSFootMarkViewController.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/9/17.
//

import UIKit
import SwiftyJSON
import Moya

class XSFootMarkViewController: XSBaseViewController {

    lazy var timeView: XSFootMarkTopView = {
        let timeView = XSFootMarkTopView.loadFromNib()
        timeView.selectTimeBlock = { select in
            self.model.removeAll()
            
            self.loadFootMarkData(selectModel: select)
        }
        return timeView
    }()
    
    lazy var tableView : UITableView = {
        let tableV = UITableView.init(frame: CGRect.zero, style: UITableView.Style.plain)
        tableV.backgroundColor = UIColor.hex(hexString: "#F6F6F6")
        tableV.tableFooterView = UIView(frame: CGRect.zero)
        tableV.separatorStyle = .none
        tableV.register(cellType: XSFootMarkTableViewCell.self)
        tableV.dataSource = self
        tableV.delegate = self
        return tableV;
    }()
        
    
    override func setupNavigationItems() {
        super.setupNavigationItems()
        title = "我的足迹"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.hex(hexString: "#F6F6F6")
     
    }
    
    
    var model:[CLUserBrowseRecordModel] = []
    
    override func requestData() {
        super.requestData()
        let todayCmps = XSTool.getDateComponentsWithDate(theDate: Date())
        let markModel = XSFootMarkModel(isSelect: true, isCurrentDate: true, cmps: todayCmps)
        loadFootMarkData(selectModel: markModel)
    }
    
    private func loadFootMarkData(selectModel: XSFootMarkModel) {
        guard  let cmp = selectModel.cmps else { return }
        let dateStr = "\(cmp.year!)-\(cmp.month!)-\(cmp.day!)"
        let dic :[String:Any] = ["date":dateStr,"page":1,"pageSize":1000]
        myOrderProvider.request(MyOrderService.userBrowseRecord(dic)) { result in
            switch result {
            case let .success(response):
                guard let jsonData = try? JSON(data: response.data) else {
                    return
                }
                if  jsonData["resp_code"].intValue == 0{
                    
                    self.model = jsonData["data"].arrayValue.compactMap{
                        return CLUserBrowseRecordModel.init(jsonData:$0)
                    }
                    
                    DispatchQueue.main.async {
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
        self.view.addSubview(timeView)
        timeView.snp.makeConstraints { make in
            make.top.equalTo(self.view.usnp.top)
            make.left.right.equalToSuperview()
        }
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(timeView.snp_bottom).offset(20)
            make.left.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(0)
            make.bottom.equalTo(self.view.usnp.bottom)
        }
        tableView.uempty = UEmptyView(description: "暂无数据")
        tableView.uempty?.emptyState = .noDataState
        tableView.uempty?.allowShow = true
    }
}


extension XSFootMarkViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        model.count
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let iv = UIView()
        iv.backgroundColor = UIColor.hex(hexString: "#F6F6F6")
        return iv
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XSFootMarkTableViewCell.self)
        cell.model = self.model[indexPath.section]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        uLog(ceil(Float(self.model[indexPath.section].goodsList.count)/2))
//        uLog(ceil(Float(self.model[indexPath.section].goodsList.count)/2))
//        uLog(ceil(Float(self.model[indexPath.section].goodsList.count)/2))
//        uLog(ceil(Float(self.model[indexPath.section].goodsList.count)/2))
        
        return CGFloat( ceil(Float(self.model[indexPath.section].goodsList.count)/2) * 65 + 15 + 34)
    }
}

