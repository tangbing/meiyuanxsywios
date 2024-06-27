//
//  XSInfoController.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/8/6.
//

import UIKit
import QMUIKit
import BRPickerView

struct XSInfoModel {
    //["title": "头像","arrow":"vip_arrow_Check","place":"","desTitle":""],
    var title: String
    var arrowImageV: String
    var placeholderText: String
    var content: String
}

class XSInfoController: XSBaseTableViewController {

    var userImg:UIImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func setupNavigationItems() {
        super.setupNavigationItems()
        title = "个人信息"
    }
        
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
            ["title": "头像","arrow":"vip_arrow_Check","place":"","desTitle":""],
            ["title": "昵称","arrow":"vip_arrow_Check","place":"","desTitle":"文和友"],
            ["title": "性别","arrow":"vip_arrow_Check","place":"请设置您的性别","desTitle":""],
            ["title": "生日","arrow":"vip_arrow_Check","place":"请设置您的生日","desTitle":""],
        ]
    }()
                    
    override func initData() {
       
        loadMineUserInfo()
    }
    

    private func loadMineUserInfo() {
        MerchantInfoProvider.request(.getUserInfo, model: XSMineHomeUserInfoModel.self) { returnData in
            
            uLog(returnData)
            if let userInfo = returnData {
                uLog(userInfo)
                self.dataSource.removeAll()

                let headViewModel = XSSetViewModel()
                let headModel = XSInfoModel(title: "头像", arrowImageV: "vip_arrow_Check", placeholderText: "", content: userInfo.headImg)
                headViewModel.style = .ViewModeStyleDefault
                headViewModel.height = 60
                headViewModel.type = 1
                headViewModel.modle = headModel
                self.dataSource.append(headViewModel)
                
                
                let nickViewModel = XSSetViewModel()
                let nickModel = XSInfoModel(title: "昵称", arrowImageV: "vip_arrow_Check", placeholderText: "", content: userInfo.nickname)
                nickViewModel.style = .ViewModeStyleDefault
                nickViewModel.height = 51
                nickViewModel.modle = nickModel
                self.dataSource.append(nickViewModel)
                
                
                let sexViewModel = XSSetViewModel()
                let sexModel = XSInfoModel(title: "性别", arrowImageV: "vip_arrow_Check", placeholderText: "请设置您的性别", content: userInfo.sex == 0 ? "女" : "男")
                sexViewModel.style = .ViewModeStyleDefault
                sexViewModel.height = 51
                sexViewModel.modle = sexModel
                self.dataSource.append(sexViewModel)
                
                
                let birthViewModel = XSSetViewModel()
                let birthModel = XSInfoModel(title: "生日", arrowImageV: "vip_arrow_Check", placeholderText: "请设置您的生日", content: userInfo.birthday)
                birthViewModel.style = .ViewModeStyleDefault
                birthViewModel.height = 51
                birthViewModel.modle = birthModel
                self.dataSource.append(birthViewModel)

                
                self.tableView.reloadData()
            }
            
        }  errorResult: { errorMsg in
            XSTipsHUD.hideAllTips()
            XSTipsHUD.showText(errorMsg)
        }

    }
    
}
// - 代理
extension XSInfoController : UITableViewDelegate, UITableViewDataSource {
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
            cell.desLab.isHidden = false

            let infoModel = vModel.modle as! XSInfoModel
            cell.tipLab.text = infoModel.title
            
            if infoModel.content.count > 0 {
                cell.desLab.text = infoModel.content
                cell.desLab.textColor = .text
            }
            else{
                cell.desLab.text = infoModel.placeholderText
                cell.desLab.textColor = .twoText
            }
            cell.arrowImg.snp_updateConstraints { make in
                make.width.height.equalTo(16)
            }
            
            cell.arrowImg.hg_setAllCornerWithCornerRadius(radius: 0)
            cell.arrowImg.image = UIImage(named: infoModel.arrowImageV)

            if vModel.type == 1 {
                cell.desLab.isHidden = true
                
                cell.arrowImg.snp_updateConstraints { make in
                    make.width.height.equalTo(44)
                }
                cell.arrowImg.hg_setAllCornerWithCornerRadius(radius: 22)
                if userImg != nil {
                    cell.arrowImg.image = userImg
                }
                else{
                    let url = URL(string: infoModel.content)!
                    cell.arrowImg.kf.setImage(with: .network(url), placeholder: UIImage.placeholderUesr)
                }
            }
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
        var infoModel = vModel.modle as! XSInfoModel

        if infoModel.title == "头像"{//头像
            let imgManage = XSSelectImgManage()
            imgManage.delegate = self
            imgManage.showImagePicker(controller: self, soureType: .XSSelectImgTypeDefault,maxItemCount: 1)
        }
        else if infoModel.title == "昵称"{
            let edit = XSInfoEditNickController()
            edit.nick = infoModel.content
            edit.editBlock = { nick in
                infoModel.content = nick
                vModel.modle = infoModel
                tableView.reloadData()
                
                self.updateUserInfo(params: ["nickname" : nick])
                
            }
            navigationController?.pushViewController(edit, animated: true)
        }
        else if infoModel.title == "性别"{
            let data = ["男","女"]
            let selIndex:Int = data.firstIndex(of: infoModel.content) ?? 0
            BRStringPickerView.showPicker(withTitle: "选择性别", dataSourceArr: data, select: selIndex) { resultModel in
                infoModel.content = resultModel?.value ?? "无"
                vModel.modle = infoModel
                tableView.reloadData()
                
                let idx = ((resultModel?.index ?? 0) != 0) ? 0 : 1
                self.updateUserInfo(params: ["sex" : idx])

            }
        }
        else if infoModel.title == "生日"{
            BRDatePickerView.showDatePicker(with: BRDatePickerMode.YMD, title: "选择时间", selectValue: infoModel.content) { resultDate, resultValue in
                infoModel.content = resultValue ?? "无"
                vModel.modle = infoModel
                tableView.reloadData()
                
                self.updateUserInfo(params: ["birthday" : (resultValue ?? "无")])

            }
        }
    }
    
    func updateUserInfo(params: [String : Any]) {
        
        MerchantInfoProvider.request(.updateUserInfo(params: params), model:XSMerchInfoHandlerModel.self) { returnData in
            
            if returnData?.trueOrFalse ?? 0 == 0 {
                XSTipsHUD.showSucceed("修改成功")
            }
            
        } errorResult: { errorMsg in
            XSTipsHUD.hideAllTips()
            XSTipsHUD.showInfo(errorMsg)
        }

    }
    
}
extension XSInfoController : XSSelectImgManageDelegate {
    func XSSelectImgManageFinsh(images: [UIImage]) {
        if images.count > 0 {
            userImg = images[0]
            tableView.reloadData()
            
            XSTipsHUD.showLoading("正在上传", inView: self.view)
            MerchantInfoProvider.request(.batchUpload(images), model: [TBUploadResultModel].self) { returnData in
                if let model = returnData {
                    let urls = model.map { uploadMoes -> String in
                        return uploadMoes.url
                    }
                    self.updateUserInfo(params: ["headImg" : urls.first!])
                }
                
            } errorResult: { error in
                uLog(error)
                XSTipsHUD.showText(error)
            }
            
        }
    }
}

