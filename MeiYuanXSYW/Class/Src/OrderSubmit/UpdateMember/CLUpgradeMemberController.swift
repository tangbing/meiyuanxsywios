//
//  CLUpgradeMemberView.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/9.
//

import UIKit

enum upgradeMember{
    case canUseCoupon(isAbel:Bool)
    case head(title:String,color:UIColor)
}

class CLUpgradeMemberController: XSBaseViewController {
    
    let leftLabel = UILabel().then{
        $0.text = "升级会员红包￥8"
        $0.textColor = .priceText
        $0.font = MYFont(size: 18)
        $0.textAlignment = .center
    }
    
    
    let rightButton = UIButton().then{
        $0.setTitle("确认", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = MYFont(size: 18)
        $0.setBackgroundImage(UIImage(named: "cartBackImg"), for: .normal)
        $0.addTarget(self, action: #selector(done), for: .touchUpInside)
    }
    
    @objc func done(){
        self.dismiss(animated: true, completion: nil)
        
        let NotifMycation = NSNotification.Name(rawValue:"red")
        NotificationCenter.default.post(name: NotifMycation, object: nil)
    }
    
    var cellModel:[upgradeMember]  = []
    
    let titleLabel = UILabel().then{
        $0.text = "升级为会员红包"
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
    
    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = .white
        $0.register(cellType: CLUpgradeMemberCell.self)
        $0.register(cellType: CLUpgradeMemberHeadCell.self)

        $0.separatorStyle = .none
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.leftLabel.hg_setCorner(conrners: [UIRectCorner.topLeft,UIRectCorner.bottomLeft], radius: 22, borderWidth: 0.5,borderColor: .priceText)
        
        self.rightButton.hg_setCorner(conrner: [.layerMaxXMinYCorner,.layerMaxXMaxYCorner], radius: 22)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        cellModel.append(.canUseCoupon(isAbel: true))
        cellModel.append(.head(title:"可用优惠券",color: .text))
        cellModel.append(.canUseCoupon(isAbel: true))
        cellModel.append(.canUseCoupon(isAbel: true))
        cellModel.append(.head(title:"不可用优惠券",color: .twoText))
        cellModel.append(.canUseCoupon(isAbel: false))
        cellModel.append(.canUseCoupon(isAbel: false))

        self.view.backgroundColor = .white
        self.view.addSubview(titleLabel)
        self.view.addSubview(closeButton)
        self.view.addSubview(tableView)
        
        self.view.addSubview(leftLabel)
        self.view.addSubview(rightButton)
        tableView.delegate = self
        tableView.dataSource = self
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(14)
            make.centerX.equalToSuperview()
        }

        closeButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.right.equalToSuperview().offset(-20)
            make.width.height.equalTo(20)
        }
    
        leftLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-20)
            make.height.equalTo(44)
            make.width.equalTo(233)
        }
        
        rightButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.left.equalTo(leftLabel.snp.right)
            make.height.equalTo(44)
            make.bottom.equalToSuperview().offset(-20)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(14)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(leftLabel.snp.top).offset(-20)
        }
    }
}
extension CLUpgradeMemberController:UITableViewDelegate,UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModel.count
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch cellModel[indexPath.row] {
        case .canUseCoupon(let isAble):
            let cell:CLUpgradeMemberCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLUpgradeMemberCell.self)
            cell.isAbel = isAble
            return cell

        case .head(title: let title, color: let color):
            let cell:CLUpgradeMemberHeadCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLUpgradeMemberHeadCell.self)
            cell.setting(title, color)
            return cell
        }
    }
            
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch cellModel[indexPath.row] {
        case .canUseCoupon:
            return 90
        case .head:
            return 24
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }

}
