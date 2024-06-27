//
//  CLMyOrderTimeSelectController.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/11/29.
//

import UIKit
import SwiftyJSON
import Alamofire


class CLMyOrderTimeSelectController: XSBaseViewController {
    var timeModel:[CLTimeModel] = []

    
    let titleLabel = UILabel().then{
        $0.text = "选择上门时间"
        $0.font = MYFont(size: 16)
        $0.textColor = .text
    }
    let backButton = UIButton().then{
        $0.setTitle("返回上一步", for: .normal)
        $0.setTitleColor(.king, for: .normal)
        $0.titleLabel?.font = MYFont(size: 16)
        $0.layer.borderWidth = 0.5
        $0.layer.borderColor = UIColor.king.cgColor
        $0.hg_setAllCornerWithCornerRadius(radius: 22)
    }
    
    let doneButton = UIButton().then{
        $0.setTitle("确定，提交", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = MYFont(size: 16)
        $0.setBackgroundImage(UIImage(named: "btnBackImg"), for: .normal)
        $0.hg_setAllCornerWithCornerRadius(radius: 22)
    }

    let tableView = CLTimeSelectTabelView()
    
    var bizType:Int = 0
    var merchantId:String = ""
    var distributionWay:Int = 0
    
    
//    init(bizType:Int,merchantId:String) {
//        self.bizType = bizType
//        self.merchantId = merchantId
//        super.init(nibName: nil, bundle: nil)
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    func loadData(){
                
        let dic = [["bizType":self.bizType,
                    "distributionWay":self.distributionWay,
                    "lat":XSAuthManager.shared.latitude,
                    "lng":XSAuthManager.shared.longitude,
                    "merchantId":self.merchantId]]
        
        myOrderProvider.request(.getArriveTime(dic)) { result in
            switch result {
            case let .success(response):
                guard let jsonData = try? JSON(data: response.data) else {
                    return
                }
                if  jsonData["resp_code"].intValue == 0{
                    self.timeModel = jsonData["data"].arrayValue.compactMap { CLTimeModel(jsonData: $0) }
                    

                    
                    DispatchQueue.main.async {
                        
                        for item in self.timeModel[0].timeVOList {
                            self.tableView.rightTotalModel.append(item.timeList)
                            self.tableView.leftModel.append(item.weekStr)
                        }
                    }
                    
                    uLog(self.timeModel)
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
        self.title = "选择收货地址"
        self.view.backgroundColor = .white
        self.view.addSubview(titleLabel)
        self.view.addSubview(tableView)

//        self.view.addSubviews(views: [backButton,doneButton])
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(14)
            make.centerX.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(14)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(self.view.usnp.bottom)
        }
        
//        backButton.snp.makeConstraints { make in
//            make.left.equalToSuperview().offset(15)
//            make.top.equalTo(tableView.snp.bottom).offset(20)
//            make.width.equalTo(165)
//            make.height.equalTo(44)
//        }
//
//        doneButton.snp.makeConstraints { make in
//            make.right.equalToSuperview().offset(-15)
//            make.top.equalTo(tableView.snp.bottom).offset(20)
//            make.width.equalTo(165)
//            make.height.equalTo(44)
//        }

    }
}
