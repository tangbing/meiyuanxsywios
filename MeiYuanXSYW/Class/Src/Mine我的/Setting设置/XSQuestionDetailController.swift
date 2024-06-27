//
//  XSQuestionDetailController.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/8/6.
//

import UIKit
import SwiftyJSON

class XSQuestionDetailController: XSBaseTableViewController {

    var questionId: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func setupNavigationItems() {
        super.setupNavigationItems()
        title = "常见问题详情"
    }
    
    init(questionId: Int) {
        self.questionId = questionId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func initSubviews() {
        super.initSubviews()
        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(cellType: XSBaseTableViewCell.self)
        
    }
    var dataSource = [XSSetViewModel]()

    override func initData() {
        
        myOrderProvider.request(MyOrderService.userQuestionDetail(questionId)) { result in
            switch result {
            case let .success(response):
                guard let jsonData = try? JSON(data: response.data) else {
                    return
                }
                uLog("jsonData:\(jsonData)")

                if  jsonData["resp_code"].intValue == 0{
                    let jsonObj = jsonData["data"]
                    let model = XSQuestionDetailModel(jsonData: jsonObj)
                    DispatchQueue.main.async {
                        
                        let vModel0 = XSSetViewModel()
                        vModel0.style = .ViewModeStyleDefault
                        vModel0.modle = model?.title
                        self.dataSource.append(vModel0)

                        let vModel1 = XSSetViewModel()
                        vModel1.style = .ViewModeStyleDefault
                        vModel1.type = 1
                        vModel1.modle = model?.content
                        self.dataSource.append(vModel1)
                        
                        self.tableView.reloadData()
                        
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
    
}
// - 代理
extension XSQuestionDetailController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let vModel = dataSource[indexPath.row]
        switch vModel.style {
        case .ViewModeStyleDefault:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XSBaseTableViewCell.self)
            cell.textLabel?.font = MYFont(size: 14)
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.snp_updateConstraints({ make in
                make.left.equalTo(16)
                make.top.equalTo(12)
                make.right.equalTo(-16)
                make.bottom.equalTo(-12)
            })
            cell.textLabel?.textColor = .text
            if vModel.type == 1 {
                cell.textLabel?.textColor = .twoText
            }
            cell.textLabel?.text = vModel.modle as? String
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

