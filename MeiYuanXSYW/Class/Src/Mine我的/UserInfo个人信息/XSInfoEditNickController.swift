//
//  XSInfoEditNickController.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/8/6.
//

import UIKit
import QMUIKit
import BRPickerView
import SVProgressHUD

class XSInfoEditNickController: XSBaseTableViewController {
    typealias XSInfoEditBlock = (_ nick:String) ->Void
    var editBlock:XSInfoEditBlock?

    var nick:String? = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func setupNavigationItems() {
        super.setupNavigationItems()
        title = "修改昵称"
    }
        
    override func initSubviews() {
        super.initSubviews()
        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(cellType: XSInfoEditNickCell.self)
        tableView.register(cellType: XSSetLogoutCell.self)
        tableView.register(cellType: XSBaseTableViewCell.self)

    }
    var dataSource = [XSSetViewModel]()
                    
    override func initData() {
        let vModel0 = XSSetViewModel()
        vModel0.style = .ViewModeStyleDefault
        vModel0.height = 105
        dataSource.append(vModel0)
        
        let vModel1 = XSSetViewModel()
        vModel1.style = .ViewModeStyleLogout
        vModel1.height = 104
        dataSource.append(vModel1)
    }
    
}
// - 代理
extension XSInfoEditNickController : UITableViewDelegate, UITableViewDataSource {
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
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XSInfoEditNickCell.self)
            if nick?.count ?? 0 > 0 {
                cell.textF.text = nick
            }
            return cell
        case .ViewModeStyleLogout:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XSSetLogoutCell.self)
            cell.outBtn.setTitle("保存", for: UIControl.State.normal)
            cell.outBtn.isUserInteractionEnabled = false
            return cell
        default:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XSBaseTableViewCell.self)
            return cell

        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vModel = dataSource[indexPath.row]
        if vModel.style == .ViewModeStyleLogout {
            let ccell : XSInfoEditNickCell = tableView.cellForRow(at: IndexPath.init(row: 0, section: 0)) as! XSInfoEditNickCell
            let text = ccell.textF.text ?? ""
            if text.count < 4 {
                SVProgressHUD.showInfo(withStatus: "需要大于4个字符")
                SVProgressHUD.dismiss(withDelay: 1.5, completion: nil)
                return
            }
            if text.count > 20 {
                SVProgressHUD.showInfo(withStatus: "输入非法字符")
                SVProgressHUD.dismiss(withDelay: 1.5, completion: nil)
                return
            }
            if text.jk.isValidNickName{
                editBlock!(text)
                navigationController?.popViewController(animated: true)
            }
            else{
                SVProgressHUD.showInfo(withStatus: "输入非法字符")
                SVProgressHUD.dismiss(withDelay: 1.5, completion: nil)
                return
            }
        }
    }
    
}

