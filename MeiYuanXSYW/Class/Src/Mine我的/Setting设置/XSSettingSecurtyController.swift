//
//  XSSettingSecurtyController.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/8/6.
//

import UIKit

class XSSettingSecurtyController: XSBaseTableViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func setupNavigationItems() {
        super.setupNavigationItems()
        title = "账号与安全"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadUserInfoData()
    }
        
    override func initSubviews() {
        super.initSubviews()
        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(cellType: XSNomalCell.self)
        tableView.register(cellType: XSSetLogoutCell.self)
        tableView.register(cellType: XSBaseTableViewCell.self)

        
    }
    var dataSource = [XSSetViewModel]()

    private lazy var tableData: Array = {
        return [
            ["title": "绑定手机号","arrow":"vip_arrow_Check","desTitle":"16754447654"],
            ["title": "修改绑定手机号","arrow":"vip_arrow_Check"],
            ["title": "注销账号","arrow":"vip_arrow_Check","place":"注销后无法恢复，请谨慎操作"],
        ]
    }()
    
    private func closeAccount() {
        MerchantInfoProvider.request(.userCloseAccount, model: XSMerchInfoHandlerModel.self) { returnData in
            
            if (returnData?.trueOrFalse ?? -1) == 0 {
                self.showAlert(title: "温馨提示", message: "账号注销成功，行膳有味感谢您的陪伴",sureAlertActionText: "继续注销", alertType: .alert) {
                    self.navigationController?.popToRootViewController(animated: true)
                    // 注销账号，token信息也要清除
                    XSMineHomeUserInfoModel.removeAccountInfo()
                    

                } cancelBlock: {
                    
                }
            }
            
        }  errorResult: { errorMsg in
            XSTipsHUD.hideAllTips()
            XSTipsHUD.showText(errorMsg)
        }
    }
    
    
    
    private func loadUserInfoData() {
        MerchantInfoProvider.request(.getUserInfo, model: XSMineHomeUserInfoModel.self) { returnData in
            
            if let userInfo = returnData {

                self.dataSource.removeAll()
                
                let vModel0 = XSSetViewModel()
                let mobileModel = XSInfoModel(title: "绑定手机号", arrowImageV: "vip_arrow_Check", placeholderText: "", content: userInfo.mobile)
                vModel0.style = .ViewModeStyleDefault
                vModel0.height = 51
                vModel0.modle = mobileModel
                self.dataSource.append(vModel0)
                
                let vModel1 = XSSetViewModel()
                let editMobileModel = XSInfoModel(title: "修改绑定手机号", arrowImageV: "vip_arrow_Check", placeholderText: "", content: "")
                vModel1.style = .ViewModeStyleDefault
                vModel1.height = 51
                vModel1.modle = editMobileModel
                self.dataSource.append(vModel1)
                
                let vModel2 = XSSetViewModel()
                let closeAccountModel = XSInfoModel(title: "注销账号", arrowImageV: "vip_arrow_Check", placeholderText: "注销后无法恢复，请谨慎操作", content: "")
                vModel2.style = .ViewModeStyleDefault
                vModel2.height = 51
                vModel2.modle = closeAccountModel
                self.dataSource.append(vModel2)
                
//                let vModel3 = XSSetViewModel()
//                vModel3.style = .ViewModeStyleLogout
//                vModel3.height = 104
//                self.dataSource.append(vModel3)
               
                self.tableView.reloadData()
            }
            
        }  errorResult: { errorMsg in
            XSTipsHUD.hideAllTips()
            XSTipsHUD.showText(errorMsg)
        }

    }
                    
    private func logout() {
//        MerchantInfoProvider.request(., designatedPath: <#T##String?#>, model: <#T##HandyJSON.Protocol#>, completion: <#T##((HandyJSON?) -> Void)?##((HandyJSON?) -> Void)?##(_ returnData: HandyJSON?) -> Void#>, pathCompletion: <#T##(([HandyJSON]) -> Void)?##(([HandyJSON]) -> Void)?##(_ returnData: [HandyJSON]) -> Void#>, errorResult: <#T##errorCallback?##errorCallback?##(_ errorMsg: String) -> (Void)#>)
        
    }
    
}
// - 代理
extension XSSettingSecurtyController : UITableViewDelegate, UITableViewDataSource {
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
            
            let infoModel = vModel.modle as! XSInfoModel

            cell.tipLab.text = infoModel.title
            
            if infoModel.content.count > 0 {
                cell.desLab.text = infoModel.content
                cell.desLab.textColor = .text
            }
            else{
                cell.desLab.text = infoModel.placeholderText
                cell.desLab.textColor = .fourText
            }
            
            cell.arrowImg.isHidden = (indexPath.row == 0)
            cell.arrowImg.image = UIImage(named: infoModel.arrowImageV)
            return cell
        case .ViewModeStyleLogout:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XSSetLogoutCell.self)
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
            let infoModel = vModel.modle as! XSInfoModel
            
            if infoModel.title == "修改绑定手机号" {
                let editPhoneVc = XSEditPhoneController()
                editPhoneVc.editBlock = { nick in
                    print(uLog(nick))
                }
                navigationController?.pushViewController(editPhoneVc, animated: true)
            } else if(infoModel.title == "注销账号") {
                self.showAlert(title: "温馨提示", message: "注销后无法恢复，请谨慎操作",sureAlertActionText: "继续注销", alertType: .alert) {
                    self.closeAccount()
                } cancelBlock: {
                    
                }

            }
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

