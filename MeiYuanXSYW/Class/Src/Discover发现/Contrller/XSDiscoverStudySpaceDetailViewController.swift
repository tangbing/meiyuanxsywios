//
//  XSDiscoverStudySpaceDetailViewController.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/12/6.
//

import UIKit



class XSDiscoverStudySpaceDetailViewController: XSBaseViewController {

    var datas = [XSStudySpaceDetailSectionViewModel]()
    
    lazy var titleLabel: UILabel! = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        titleLabel.text = "吃货研究所"
        titleLabel.alpha = 0
        titleLabel.textAlignment = .center
        return titleLabel
    }()
    
    lazy var custom_titleView: UIView = {
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 120, height: 44))
        titleView.backgroundColor = UIColor.clear
        titleView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints({ (make) in
            make.edges.equalTo(titleView)
        })
        return titleView
    }()
    
    lazy var tableView : UITableView = {
        let tableV = UITableView.init(frame: CGRect.zero, style: UITableView.Style.grouped)
        tableV.backgroundColor = .background
        tableV.tableFooterView = UIView(frame: CGRect.zero)
        tableV.tableHeaderView = head
        tableV.separatorStyle = .none
        tableV.delegate = self
        tableV.dataSource = self
        tableV.register(cellType: XSDiscoverStudySpaceInfoTableViewCell.self)
        tableV.register(cellType: XSDiscoverStudySpaceContentTableViewCell.self)
        tableV.register(cellType: XSDiscoverStudySpaceWaitTableViewCell.self)
        tableV.register(cellType: XSDiscoverStudySpaceMerchInfoTableViewCell.self)
        return tableV
    }()
    
    private lazy var head: XSDiscoverStudySpaceDetaiTablelHeaderView = {
        return XSDiscoverStudySpaceDetaiTablelHeaderView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 200))
    }()

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.gk_navBarAlpha = 0.0
        self.gk_statusBarStyle = .lightContent
        self.gk_navTitleView = custom_titleView
        
        
        view.addSubview(tableView)
        
    }
    
    override func initData() {
        super.initData()
        let viemModel = XSStudySpaceDetailSectionViewModel()
        viemModel.fetchData()

        datas = viemModel.sections
        tableView.reloadData()
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.snp_makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
       
    }
    
    @objc func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension XSDiscoverStudySpaceDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sections = datas[section]
        return sections.cellViewModels.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = datas[indexPath.section]
        let model = section.cellViewModels[indexPath.row]

        switch model.style {
           case .info :
                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XSDiscoverStudySpaceInfoTableViewCell.self)
                cell.infoModel = model as? XSStudySpaceInfoModel
                return cell
           case .content :
                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XSDiscoverStudySpaceContentTableViewCell.self)
                return cell
           case .wait :
                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XSDiscoverStudySpaceWaitTableViewCell.self)
                cell.waitModel = model as? XSStudySpaceWaitModel
                return cell
           default:
                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XSDiscoverStudySpaceMerchInfoTableViewCell.self)
                return cell
          }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        // 偏移量 < 60 0
        // 偏移量 60 - 100 导航栏0-1渐变
        // 偏移量 > 100 1
        var alpha: CGFloat = 0
        if offsetY <= 60.0 {
            alpha = 0
            self.titleLabel.alpha = 0
            self.gk_statusBarStyle = .lightContent
            self.gk_navLeftBarButtonItem = UIBarButtonItem.gk_item(image: UIImage(named: "nav_back_white")!, target: self, action: #selector(backAction))
        }else if offsetY >= 100.0 {
            alpha = 1.0
            self.gk_statusBarStyle = .default
            self.gk_navLeftBarButtonItem = UIBarButtonItem.gk_item(image: UIImage(named: "nav_back_black")!, target: self, action: #selector(backAction))
            self.titleLabel.alpha = 1
        }else {
            alpha = (offsetY - 60) / (100 - 60)
            
            if alpha > 0.8 {
                self.gk_statusBarStyle = .default
                self.gk_navLeftBarButtonItem = UIBarButtonItem.gk_item(image: UIImage(named: "nav_back_black")!, target: self, action: #selector(backAction))
                self.titleLabel.alpha = (offsetY - 92) / (100 - 92)
            }else {
                self.titleLabel.alpha = 0
                self.gk_statusBarStyle = .lightContent
                self.gk_navLeftBarButtonItem = UIBarButtonItem.gk_item(image: UIImage(named: "nav_back_black")!, target: self, action: #selector(backAction))
            }
        }
        self.gk_navBarAlpha = alpha
        
        // 头图下拉
        head.scrollViewDidScroll(contentOffsetY: scrollView.contentOffset.y)
    }
    
    override func preferredNavigationBarHidden() -> Bool {
        return true
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = datas[indexPath.section]
        let model = section.cellViewModels[indexPath.row]

        return model.rowHeight
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
