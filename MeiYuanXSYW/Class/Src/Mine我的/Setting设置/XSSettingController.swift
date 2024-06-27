//
//  XSSettingController.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/8/6.
//

import UIKit

class XSSettingController: XSBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func setupNavigationItems() {
        super.setupNavigationItems()
        title = "设置"
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
            ["title": "个人信息","arrow":"vip_arrow_Check"],
            ["title": "账号和安全","arrow":"vip_arrow_Check"],
            ["title": "关于我们","arrow":"vip_arrow_Check"],
            ["title": "常见问题","arrow":"vip_arrow_Check"],
            ["title": "意见反馈","arrow":"vip_arrow_Check"],
            ["title": "平台隐私政策","arrow":"vip_arrow_Check"],
            ["title": "注册协议","arrow":"vip_arrow_Check"],
            ["title": "版本更新","arrow":"vip_arrow_Check","desTitle":"正在检查版本"],
        ]
    }()
                    
    override func initData() {
        for i in 0..<tableData.count {
            let data = tableData[i]

            let vModel0 = XSSetViewModel()
            vModel0.style = .ViewModeStyleDefault
            vModel0.height = 51
            vModel0.modle = data
            dataSource.append(vModel0)
            if (data["title"] == "版本更新") {
                vModel0.type = 1
            }
        }

        let vModel1 = XSSetViewModel()
        vModel1.style = .ViewModeStyleLogout
        vModel1.height = 104
        dataSource.append(vModel1)
    }
    
}
// - 代理
extension XSSettingController : UITableViewDelegate, UITableViewDataSource {
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
            let dict: [String: String] = vModel.modle as! [String : String]
            cell.tipLab.text = dict["title"]
            cell.desLab.text = dict["desTitle"]
            cell.arrowImg.image = UIImage(named: dict["arrow"] ?? "")
            return cell
        case .ViewModeStyleLogout:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XSSetLogoutCell.self)
            cell.outBtn.addTarget(self, action: #selector(logout), for: .touchUpInside)
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
            let dict: [String: String] = vModel.modle as! [String : String]
            if dict["title"] == "个人信息" {
                navigationController?.pushViewController(XSInfoController(), animated: true)
            }
            else if dict["title"] == "账号和安全"{
                navigationController?.pushViewController(XSSettingSecurtyController(), animated: true)
            }
            else if dict["title"] == "常见问题"{
                navigationController?.pushViewController(XSSettingQuestionController(), animated: true)
            }else if dict["title"] == "意见反馈"{
                navigationController?.pushViewController(XSSettingFeedbackViewController(), animated: true)
            }
        } else {
          
        }
    }
    
    @objc func logout() {
        self.showAlert(title: "温馨提示", message: "确定要退出登录?",sureAlertActionText: "继续退出", alertType: .alert) {
            XSMineHomeUserInfoModel.removeAccountInfo()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                NotificationCenter.default.post(name: NSNotification.Name.XSLogoutNotification, object: nil)
                self.navigationController?.popViewController(animated: true)
            }
        } cancelBlock: { 
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

