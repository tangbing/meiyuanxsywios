//
//  XSPayAddressViewController.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/9/22.
//

import UIKit
import Moya
import SwiftyJSON

class XSPayAddressViewController: XSBaseViewController {

    lazy var tableView : UITableView = {
        let tableV = UITableView.init(frame: CGRect.zero, style: UITableView.Style.plain)
        tableV.backgroundColor = .background
        tableV.tableFooterView = UIView(frame: CGRect.zero)
        tableV.register(cellType: XSPayAddressTableViewCell.self)
        tableV.separatorStyle = .none
        tableV.dataSource = self
        tableV.delegate = self
        return tableV;
    }()
    
    var addAddrestn :UIButton={
        let btn = UIButton()
        btn.titleLabel?.font = MYBlodFont(size: 16)
        btn.setTitleColor(.white, for: UIControl.State.normal)
        btn.setTitle("新增地址", for: UIControl.State.normal)
        btn.setBackgroundImage(UIImage(named: "btnBackImg"), for: UIControl.State.normal)
        btn.hg_setAllCornerWithCornerRadius(radius: 22)
        btn.addTarget(self, action: #selector(addAddress), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        showEmptyView(with: #imageLiteral(resourceName: "No receiving address"), text: "还没有收货地址", detailText: nil, buttonTitle: nil, buttonAction: nil)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadAddressData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //hideEmptyView()
        //tableView.reloadData()
    }
    
//    override func showEmptyView() {
//        super.showEmptyView()
//        self.emptyView?.imageViewInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//    }
    
    var models:[CLReceiverAddressModel] = []
    
     func loadAddressData() {
        XSTipsHUD.showLoading("", inView: self.view)
                  
        tableView.uempty = UEmptyView(description: "还没有收货地址")
        tableView.uempty?.emptyState = .noDataState
        tableView.uempty?.allowShow = true
        
        let dic :[String:Any] = [:]
        myOrderProvider.request(MyOrderService.getReceiverAddress(dic)) { result in
            XSTipsHUD.hideAllTips()

            switch result {
            case let .success(response):
                guard let jsonData = try? JSON(data: response.data) else {
                    return
                }
                
                if  jsonData["resp_code"].intValue == 0{
                    
                    self.models = jsonData["data"].arrayValue.compactMap{
                        return CLReceiverAddressModel.init(jsonData: $0)
                    }
                    self.tableView.reloadData()
                    
                    
                }else{
                    XSTipsHUD.showText(jsonData["resp_msg"].stringValue)
                }

             case let .failure(_):
                //网络连接失败，提示用户
                XSTipsHUD.hideAllTips()
                XSTipsHUD.showText("网络连接失败")
                
            }
        }
    }
    

    func deleteAddress(model: CLReceiverAddressModel, completeHandler : @escaping (() -> (Void))) {
        var dic :[String:Any] = [:]
        dic["id"] = model.id
        
        myOrderProvider.request(MyOrderService.getReceiverAddress(dic)) { result in
            XSTipsHUD.hideAllTips()

            switch result {
            case let .success(response):
                guard let jsonData = try? JSON(data: response.data) else {
                    return
                }
                
                if  jsonData["resp_code"].intValue == 0{
                    let flage = jsonData["data"]["trueOrFalse"].intValue
                    if flage == 0 {
                        XSTipsHUD.showText("操作成功！")
                        completeHandler()
                    }
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
    
    
    override func setupNavigationItems() {
        super.setupNavigationItems()
        navigationTitle = "地址"
    }
    
    override func initSubviews() {
        self.view.addSubview(addAddrestn)
        addAddrestn.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.usnp.bottom).offset(-30)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(44)
        }
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints{ make in
            make.left.right.equalTo(self.view)
            make.top.equalTo(self.view.usnp.top)
            make.bottom.equalTo(addAddrestn.snp_top).offset(-10)
        }
       
    }
    
    @objc func addAddress(){
        self.navigationController?.pushViewController(XSPayAddressEditViewController(addressId: nil), animated: true)
    }

}

/// UITableViewDataSource & UITableViewDelegate
extension XSPayAddressViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XSPayAddressTableViewCell.self)
        let addressModel = models[indexPath.row]
        cell.model = addressModel
        cell.editClickBlock = {
            let editVc = XSPayAddressEditViewController(addressId: addressModel.id)
            self.navigationController?.pushViewController(editVc, animated: true)
        }
        
        
     
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let addressModel = models[indexPath.row]
        
        UserDefaults.standard.set(addressModel.receiverDetailAddress, forKey: kCurrCityStr)
        XSAuthManager.shared.latitude = addressModel.lat
        XSAuthManager.shared.longitude = addressModel.lng

        UserDefaults.standard.set(addressModel.lat, forKey: kLatitude)
        UserDefaults.standard.set(addressModel.lng, forKey: kLongitude)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // 删除数据
            let model = self.models[indexPath.row]
            deleteAddress(model: model) {
                self.models.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
                self.tableView.reloadData()
            }
            
//            [self.dataArray removeObjectAtIndex:indexPath.row];
//            _refreshCount++;
//            [Global setupUnreadMessageCount];
//
//            [self.chatTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }
    
    
}

