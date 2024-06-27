//
//  CLSubmitPayController.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/13.
//

import UIKit
import Presentr
import Moya
import SwiftyJSON

class CLSubmitPayResultModel:CLSwiftyJSONAble{
    var biztypeOrderSn:String
    var id:String
    var merchantOrderSn:String
    var orderSn:String
    var payAmt:String
    var payBizSn:String
    var payStatus:String
    var payTime:String
    var payWay:String
    var totalAmt:String
    
    required init?(jsonData: JSON) {
        
        biztypeOrderSn = jsonData["biztypeOrderSn"].stringValue
        id = jsonData["id"].stringValue
        merchantOrderSn = jsonData["merchantOrderSn"].stringValue
        orderSn = jsonData["orderSn"].stringValue
        payAmt = jsonData["payAmt"].stringValue
        payBizSn = jsonData["payBizSn"].stringValue
        payStatus = jsonData["payStatus"].stringValue
        payTime = jsonData["payTime"].stringValue
        payWay = jsonData["payWay"].stringValue
        totalAmt = jsonData["totalAmt"].stringValue
    }
}

enum payType {
    case wexin
    case alipay
    case bank
    case detailBank
    case addBank
}

class CLSubmitPayController: XSBaseViewController {
    
    var model:CLSubmitGroupBuyResultModel?
    var resultModel:CLSubmitPayResultModel?

    var cellModel : [payType] = []
    
    var flag:Bool = false
    
    let leftTime = UILabel().then{
        $0.text = "剩余支付时间 00:30:00"
        $0.textColor = .text
        $0.font = MYBlodFont(size: 16)
    }
    
    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = .lightBackground
        $0.register(cellType: CLSubmitPayCell.self)
        $0.separatorStyle = .none
    }
    
    let money = UILabel().then{
        $0.textColor = .priceText
        $0.font = MYBlodFont(size: 36)
    }
    
    let goodName = UILabel().then{
        $0.text = "商品名称"
        $0.textColor = .text
        $0.font = MYFont(size: 14)
    }
    
    lazy var payPresenter: Presentr = {
        let width = ModalSize.full
        let height = ModalSize.custom(size: 440)
        let center = ModalCenterPosition.customOrigin(origin: CGPoint(x: 0, y: screenHeight - 440))
        let customType = PresentationType.custom(width: width, height: height, center: center)
        let presenter = Presentr(presentationType: customType)
        presenter.transitionType = .coverVertical
        presenter.dismissTransitionType = .coverVertical
        presenter.backgroundOpacity = 0.7
        presenter.roundCorners = true
        presenter.cornerRadius = 12
        return presenter
      }()
    
    let submitButton = UIButton().then{
        $0.setBackgroundImage(UIImage(named: "btnBackImg"), for: .normal)
        $0.setTitle("确认支付", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = MYFont(size: 16)
        $0.addTarget(self, action: #selector(enterPwd), for: .touchUpInside)
        $0.hg_setAllCornerWithCornerRadius(radius: 22)
    }
    
    
    @objc func enterPwd(){
        let vc  = CLPayKeyboardController()
        self.customPresentViewController(self.payPresenter, viewController: vc, animated: true)
    }
    
    private func receievNotify(){

        let red = NSNotification.Name(rawValue:"submit")
        NotificationCenter.default.addObserver(self, selector: #selector(submit(notify:)), name: red, object: nil)
    }
    
    @objc func submit(notify:Notification){
        guard let pwd: String = notify.object as! String? else { return }

        if pwd == "111111"{
            self.payOrder()
        }else{
            
        }

    }
    
    func payOrder(){
        let dic:[String : Any] = [:]
        myOrderProvider.request(MyOrderService.payOrder(dic)) { result in
            switch result {
            case let .success(response):
                guard let jsonData = try? JSON(data: response.data) else {
                    return
                }
                if  jsonData["resp_code"].intValue == 0{
                    let jsonObj = jsonData["data"]
                    self.resultModel = CLSubmitPayResultModel(jsonData: jsonObj)
                    uLog(self.resultModel)

                    DispatchQueue.main.async {
                        let vc =  CLPayStatusController()
                        vc.model = self.resultModel
                        self.navigationController?.pushViewController(vc, animated: true)
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
    
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("submit"), object: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.receievNotify()
        
        cellModel.append(.wexin)
        cellModel.append(.alipay)
        cellModel.append(.bank)
        
        self.navigationTitle = "支付订单"
        self.view.addSubviews(views: [leftTime,money,goodName,tableView,submitButton])
        tableView.delegate = self
        tableView.dataSource = self
        
        money.text = "￥" + model!.payAmt ?? ""
        money.jk.setsetSpecificTextFont("￥", font: MYBlodFont(size: 16))
        goodName.text = model!.goodsName
        
        leftTime.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.centerX.equalToSuperview()
        }
        
        money.snp.makeConstraints { make in
            make.top.equalTo(leftTime.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        goodName.snp.makeConstraints { make in
            make.top.equalTo(money.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
                
        submitButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-30)
            make.height.equalTo(44)
        }
        tableView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(goodName.snp.bottom).offset(30)
            make.bottom.equalTo(submitButton.snp.top).offset(-10)
        }
   
    }
}
extension CLSubmitPayController :UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  cellModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: CLSubmitPayCell.self)
        switch cellModel[indexPath.row]{
        case .wexin:
            cell.logo.image = UIImage(named: "weixin")
            cell.name.text  = "微信支付"

        case .alipay:
            cell.logo.image = UIImage(named: "zhifubao")
            cell.name.text  = "支付宝"

        case .bank:
            cell.logo.image = UIImage(named: "yinlianka")
            cell.name.text  = "银联卡"
            cell.updateLineConstraints()

        case .detailBank:
            cell.logo.isHidden = true
            cell.name.text  = "银联卡8888 8888 8888 8888"
            cell.updateLineConstraints()

        case .addBank:
            cell.logo.isHidden = true
            cell.name.text  = "+新增银行卡"
            cell.line.isHidden = true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch cellModel[indexPath.row] {
        case .bank:
            if self.flag == false{
                cellModel.append(.addBank)
                tableView.reloadData()
                self.flag = true
            }
        case .wexin:
            return
        case .alipay:
            return
        case .detailBank:
            return
        case .addBank:
            let vc = CLAddBankDetailController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

