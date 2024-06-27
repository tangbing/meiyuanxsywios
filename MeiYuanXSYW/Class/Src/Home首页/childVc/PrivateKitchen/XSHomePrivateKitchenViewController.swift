//
//  XSHomePrivateKitchenViewController.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/22.
//

import UIKit
import MJRefresh

class XSHomePrivateKitchenViewController: XSBaseViewController {

   
    
    var style: HomeShowStyle = .privateKitchen
    var pageIndex: Int = 1
    var privateDatas: [XSHomePrivateKitchenData] = [XSHomePrivateKitchenData]()
    
    
    init(style: HomeShowStyle) {
        self.style = style
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var privateKitchenTableView : UITableView = {
        let tableV = UITableView.init(frame: CGRect.zero, style: .plain)
        tableV.backgroundColor = UIColor.hex(hexString: "#131313")
        tableV.tableFooterView = UIView(frame: CGRect.zero)
        tableV.separatorStyle = .none
        tableV.dataSource = self
        tableV.delegate = self
        tableV.tableHeaderView = setupTableViewHeaderView()
        tableV.register(cellType: XSPrivateKitchTableViewCell.self)
        return tableV
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPrivateNav()
        setupTableView()
        setupRefresh()
    }
    
    func setupTableView() {
        view.addSubview(privateKitchenTableView)
        privateKitchenTableView.snp_remakeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: kNavHeight, left: 0, bottom: bottomInset, right: 0))
        }
       
    }
    
    func setupTableViewHeaderView() -> UIView {
        let iv = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: FMScreenScaleFrom(180)))
        
        let topBgImageView = UIImageView()
        topBgImageView.image = UIImage(named: "home_privateKitchen_bg_icon")
        topBgImageView.frame = iv.bounds
        iv.addSubview(topBgImageView)
        
        let locationBtn = UIButton(type: .custom)
        locationBtn.setTitle("深圳", for: .normal)
        locationBtn.setTitleColor(.white, for: .normal)
        locationBtn.setImage(UIImage(named: "home_privateKitchen_position"), for: .normal)
        locationBtn.titleLabel?.font = MYFont(size: 15)
        iv.addSubview(locationBtn)
        locationBtn.frame = CGRect(x: 0, y: 0, width: 64, height: 44)
        
        return iv
    }
    
    override func preferredNavigationBarHidden() -> Bool {
        return true
    }
    
    private func setupPrivateNav() {
        gk_navTitle = "私厨"
        gk_navTitleColor = .white
        gk_navLineHidden = false
        gk_statusBarStyle = .lightContent
        gk_navBackgroundColor = UIColor.hex(hexString: "#131313")

        let messageItem = UIBarButtonItem.gk_item(image:UIImage(named: "home_privateKitchen_news"), target: self, action: #selector(messageAction))
        self.gk_navRightBarButtonItem = messageItem
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

    }
    
    @objc func messageAction() {
        
    }
    
}

// MARK: - HttpRequest
extension XSHomePrivateKitchenViewController {
    
    func setupRefresh() {
        
        self.privateKitchenTableView.mj_header = URefreshAutoHeader(refreshingTarget: self, refreshingAction: #selector(headerRereshing))
       
        self.privateKitchenTableView.uFoot = URefreshAutoFooter(refreshingTarget: self, refreshingAction: #selector(footerRereshing))
        
        self.privateKitchenTableView.mj_header?.beginRefreshing()
        
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
        
        MerchantInfoProvider.request(.getPrivateChefPage(page: pageIndex, pageSize: pageSize), model: XSHomePrivateKitchenModel.self) { returnData in
            
            //guard let self = self else { return }
            
            guard let privateKitchenModel = returnData else {
                return
            }
            
            let privateKitchens = privateKitchenModel.data
            let count = privateKitchenModel.count
            
            if isRefresh {
                self.privateDatas = privateKitchens

                self.privateKitchenTableView.mj_footer?.isHidden = !(self.privateDatas.count > 0)
                if self.privateKitchenTableView.mj_footer?.state == .noMoreData {
                    self.privateKitchenTableView.mj_footer?.state = MJRefreshState.idle
                }
            } else {
                self.privateDatas.appends(privateKitchens)
                self.pageIndex += 1
            }
            
            if self.privateDatas.count > 0 && count <= self.privateDatas.count {
                self.privateKitchenTableView.mj_footer?.state = .noMoreData
            }
            self.endLoad(isRefresh: isRefresh)
            
        } errorResult: { errorMsg in
            XSTipsHUD.showError("加载失败，请重试")
            self.endLoad(isRefresh: isRefresh)
        }

    }
    
    func endLoad(isRefresh: Bool) {
        self.privateKitchenTableView.reloadData()
        if isRefresh {
            self.privateKitchenTableView.mj_header?.endRefreshing()
        } else if(!(self.privateKitchenTableView.mj_footer?.isHidden ?? true)) {
            if(self.privateKitchenTableView.mj_footer?.state != .noMoreData) {
                self.privateKitchenTableView.mj_footer?.endRefreshing()
            }
        }
    }
    
}

extension XSHomePrivateKitchenViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.privateDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XSPrivateKitchTableViewCell.self)
        let privateKitchen = privateDatas[indexPath.section]
        cell.privateKitchenModel = privateKitchen
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let iv = UIView()
        iv.backgroundColor = UIColor.clear
        return iv
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let iv = UIView()
        iv.backgroundColor = .red
        return iv
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /// 点击商品热区，跳转商家详情
        let privateKitchen = privateDatas[indexPath.section]
        let privateMerchantVc = TBDeliverMerchanInfoViewController(style: .privateKitchen, merchantId: privateKitchen.merchantId)
        self.navigationController?.pushViewController(privateMerchantVc, animated: true)
    }
}
