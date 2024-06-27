//
//  CLMyOrderAddressSelectController.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/11/29.
//

import UIKit
import SwiftyJSON

enum CLMyOrderAddressType{
    case ableSelect
    case unableSelect
    case button
}

class CLMyOrderAddressSelectController: XSBaseViewController {
    var selectAddrBlock:((_ receiverDetailAddress:String,_ receiverName:String,_ receiverPhone:String,_ addressId:Int)->())?
    
    var addrModel:[CLOrderSelectAddrModel] = []
    var merchantIdList:[String] = []
    
    var cellModel:[CLMyOrderAddressType] = []
    
    let titleLabel = UILabel().then{
        $0.text = "选择收货地址"
        $0.font = MYFont(size: 16)
        $0.textColor = .text
    }
    
    
    let closeButton = UIButton().then{
        $0.setImage(UIImage(named: "merchinfo_ticket_closure"), for: .normal)
        $0.addTarget(self, action: #selector(close), for: .touchUpInside)
    }
    
    @objc func close(){
        self.dismiss(animated: true, completion: nil)
    }
    
    let addButton = UIButton().then{
        $0.setTitle("新增地址", for: .normal)
        $0.setTitleColor(.king, for: .normal)
        $0.titleLabel?.font = MYFont(size: 16)
        $0.layer.borderWidth = 0.5
        $0.layer.borderColor = UIColor.king.cgColor
        $0.layer.cornerRadius = 22

    }
    
    let doneButton = UIButton().then{
        $0.setTitle("确定，下一步", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = MYFont(size: 16)
        $0.setBackgroundImage(UIImage(named: "btnBackImg"), for: .normal)
        $0.hg_setAllCornerWithCornerRadius(radius: 22)
    }
    
    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = .white
        $0.register(cellType: CLAbleSelectAddressCell.self)
        $0.register(cellType: CLUnableSelectAddressCell.self)
//        $0.register(cellType: CLMyOrderAddressSelectButtonCell.self)
        $0.separatorStyle = .none
    }
    
    
    func loadData(){
        let dic = ["lat":22.539461,
                   "lng":114.113775,
                   "merchantIdList":merchantIdList] as [String : Any]
        
        myOrderProvider.request(.getOrderUserReceiverListByMerchantIdList(dic)) { result in
            switch result {
            case let .success(response):
                guard let jsonData = try? JSON(data: response.data) else {
                    return
                }
                if  jsonData["resp_code"].intValue == 0{
                    self.addrModel = jsonData["data"].arrayValue.compactMap { CLOrderSelectAddrModel(jsonData: $0)}
                    
                    DispatchQueue.main.async {
                        
                        for item in self.addrModel {
                            if item.canDistribution == true {
                                self.cellModel.append(.ableSelect)
                            }else{
                                self.cellModel.append(.unableSelect)
                            }
                        }
                        
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
    
    override func viewDidLoad() {
        
        loadData()
//        cellModel.append(.ableSelect)
//        cellModel.append(.ableSelect)
//        cellModel.append(.ableSelect)
//        cellModel.append(.unableSelect)
//        cellModel.append(.unableSelect)
//        cellModel.append(.unableSelect)
//        cellModel.append(.button)

        
        self.title = "选择收货地址"
        self.view.backgroundColor = .white
        self.view.addSubview(titleLabel)
        self.view.addSubview(closeButton)
        self.view.addSubview(addButton)
        self.view.addSubview(doneButton)
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.centerX.equalToSuperview()
        }

        closeButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.right.equalToSuperview().offset(-20)
            make.width.height.equalTo(20)
        }
        
        
        addButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.bottom.equalTo(self.view.snp.bottom).offset(-20)
            make.width.equalTo(165)
            make.height.equalTo(44)
        }
        
        doneButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-15)
            make.bottom.equalTo(self.view.snp.bottom).offset(-20)
            make.width.equalTo(165)
            make.height.equalTo(44)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(14)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(addButton.snp.top).offset(-10)
        }
    }
}

extension CLMyOrderAddressSelectController:UITableViewDelegate,UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModel.count
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch cellModel[indexPath.row] {
        case .ableSelect:
            let cell:CLAbleSelectAddressCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLAbleSelectAddressCell.self)
            cell.model = self.addrModel[indexPath.row]
            return cell
        case .unableSelect:
            let cell:CLUnableSelectAddressCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLUnableSelectAddressCell.self)
            cell.model = self.addrModel[indexPath.row]

            return cell
        case .button:
            let cell:CLMyOrderAddressSelectButtonCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderAddressSelectButtonCell.self)
            return cell
        }
    }
            
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch cellModel[indexPath.row] {
        case .ableSelect:
            return 61
        case .unableSelect:
            return 61
        case .button:
            return 64
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch cellModel[indexPath.row] {
        case .ableSelect:
            let model = self.addrModel[indexPath.row]
            guard let block = self.selectAddrBlock else { return }
            block(model.receiverDetailAddress,model.receiverName,model.receiverPhone,model.id)
        default:
            break
            
        }
    }
}
