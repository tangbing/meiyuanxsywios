//
//  TBMerchInfoTicketRedPacketPopView.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/3.
//

import UIKit

enum TBTicketRedPacketType {
    /// 可购买的会员卡列表
    case memberCard
    /// 我的会员红包列表
    case myRedMemberPacket
}

class TBMerchInfoTicketRedPacketPopView: UIView {
    var redPacketType: TBTicketRedPacketType = .myRedMemberPacket
    
    private var sectionTitles = [String]()
    weak var delegate: TBMerchInfoPopViewDelegate?

    var memberCardModels = [MemberCardVoList]()
    var myRedMemberPackets = [FreeCouponList]()
    
    var merchantId: String = ""

    var dataModel: TBMerchantCouponListModel? {
        didSet {
            guard let model = dataModel else { return }
            
            memberCardModels.removeAll()
            myRedMemberPackets.removeAll()
            
            if model.joinUpCoupon {// 参与红包升级活动,则直接展示行膳有味会员红包，直接兑换
                redPacketType = .myRedMemberPacket
                guard let myMemberCouponVoList = model.myMemberCouponVoList else {
                    setUempty()
                    return
                }
                myRedMemberPackets = myMemberCouponVoList
                sectionTitles.append("您有\(myMemberCouponVoList.count)个行膳有味会员红包")
            } else {// 没有参与红包升级活动,则直接展示购买会员，可以购买
                redPacketType = .memberCard
                guard let memberCardVoList = model.memberCardVoList else {
                    setUempty()
                    return
                }
                memberCardModels = memberCardVoList
                sectionTitles.append("您可购买行膳有味会员")
            }
        
            tableView.reloadData()
            
        }
      
    }

    
    lazy var tableView : UITableView = {
        let tableV = UITableView.init(frame: CGRect.zero, style: .grouped)
        tableV.backgroundColor = .lightBackground
        tableV.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0.1))
        tableV.tableFooterView = UIView(frame: CGRect.zero)
        tableV.separatorStyle = .none
        tableV.dataSource = self
        tableV.delegate = self
        tableV.register(cellType: TBMerchInfoTicketRedPacketPopViewCell.self)
        return tableV
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUILayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    private func setupUILayout(){
        self.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
   private func setUempty(){
        self.tableView.uempty = UEmptyView(description: "暂无红包")
        self.tableView.uempty?.emptyState = .noDataState
        self.tableView.reloadData()
    }

}

// MARK: - httpRequest
extension TBMerchInfoTicketRedPacketPopView {
    func exchangeMerchantCoupon(model: FreeCouponList) {
        
        MerchantInfoProvider.request(.exchangeMerchantCoupon(merchantId), model: XSMerchInfoHandlerModel.self) { [weak self] returnData in
            
            if returnData?.trueOrFalse ?? 0 == 0 {
                XSTipsHUD.showSucceed("兑换成功")
                self?.delegate?.refreshTicket()
                // 重新刷新店铺详情的头接口获取数据
                NotificationCenter.default.post(name: NSNotification.Name.XSUpdateMerchHeadrInfoNotification, object: nil)
            } else {
                XSTipsHUD.showSucceed("兑换失败")
            }
            
        } errorResult: { errorMsg in
            print(errorMsg)
            XSTipsHUD.showText(errorMsg)
        }
        
    }
}


extension TBMerchInfoTicketRedPacketPopView: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if redPacketType == .myRedMemberPacket {
            return myRedMemberPackets.count
        }
        return memberCardModels.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TBMerchInfoTicketRedPacketPopViewCell.self)
        
        if redPacketType == .myRedMemberPacket {
            let model = myRedMemberPackets[indexPath.row]
            cell.myRedMemberPacketModels = model
        } else {
            let model = memberCardModels[indexPath.row]
            cell.memberCardModels = model
            
            cell.expandBlock = {
                model.ruleExpand = !model.ruleExpand
                tableView.reloadData()
            }
        }
        
        cell.exchangeMerchantHandler = { [weak self] model in
            if let exchangeModel = model as? FreeCouponList {
                if exchangeModel.redPacketType == .myRedMemberPacket { // 兑换操作
                    self?.exchangeMerchantCoupon(model: exchangeModel)
                }
            } else { // 购买会员操作
                
            }
        }
        

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        let titleLabel = UILabel()
        titleLabel.text = "暂无红包"
        titleLabel.font = MYFont(size: 14)
        titleLabel.textColor = .text
        
        header.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(header).offset(10)
            make.centerY.equalTo(header)
        }
        return header
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let iv = UIView()
        iv.backgroundColor = .background
        return iv
    }


}

