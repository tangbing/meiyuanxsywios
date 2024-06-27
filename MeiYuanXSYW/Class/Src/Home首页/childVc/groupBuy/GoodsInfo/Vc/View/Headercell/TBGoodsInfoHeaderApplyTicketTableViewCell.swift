//
//  TBShopInfoHeaderTicketTableViewCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/15.
//

import UIKit

class TBGoodsInfoHeaderApplyTicketTableViewCell: XSBaseTableViewCell {
    
    var ticketDataModel: TBGoodsInfoHeaderTicketModel? {
        didSet {
            guard let ticketModel = ticketDataModel else { return }
            
            
            
            if ticketModel.commonCouponVos != nil {
                ticketLab.isHidden = true
                merchTicketView.isHidden = false
                
                merchTicketView.setupTicketScrollView(ticketModel.commonCouponVos!)
                ticketTitleLab.text = ticketModel.prefixTitleText

            } else {
                merchTicketView.isHidden = true
                ticketLab.isHidden = false
                
                ticketTitleLab.text = ticketModel.prefixTitleText
                ticketLab.text = ticketModel.suffixValueText
            }
            
            if ticketModel.hasTopRadius {
                containView.hg_setCornerOnTopWithRadius(radius: 10)
            }
            
            if ticketModel.hasBottomRadus {
                containView.hg_setCornerOnBottomWithRadius(radius: 10)
            }
            
 
            
        }
    }

    lazy var containView: UIView = {
        let contain = UIView()
        contain.backgroundColor = .white
        return contain
    }()
    
    lazy var ticketTitleLab: UILabel = {
        let label = UILabel()
        label.text = "领券专区"
        label.font = MYFont(size: 12)
        label.textColor = .twoText
        return label
    }()
    
    lazy var ticketLab: UILabel = {
        let label = UILabel()
        label.text = "2件9折，3件8.5折"
        label.font = MYFont(size: 12)
        label.textColor = UIColor.text
        return label
    }()
    
    lazy var merchTicketView: TBMerchTicketScrollView = {
        let ticketScroll = TBMerchTicketScrollView()
        ticketScroll.isAllowPopView = false
        return ticketScroll
    }()
    

    override func configUI() {
        super.configUI()
        self.contentView.backgroundColor = .clear

        self.contentView.addSubview(containView)
        containView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.top.equalToSuperview()
        }
        
        containView.addSubview(ticketTitleLab)
        ticketTitleLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
            make.width.equalTo(50)
        }
        
        containView.addSubview(merchTicketView)
        merchTicketView.snp.makeConstraints { make in
            make.left.equalTo(ticketTitleLab.snp_right).offset(18)
            make.right.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
            make.height.equalTo(24)
        }
        
        containView.addSubview(ticketLab)
        ticketLab.snp.makeConstraints { make in
            make.left.equalTo(ticketTitleLab.snp_right).offset(18)
            make.centerY.equalToSuperview()
        }
        
    }
    
    func onlyShowTicket() {
        merchTicketView.isHidden = false
        ticketLab.isHidden = true
    }
    
    func onlyShowMsg() {
        merchTicketView.isHidden = true
        ticketLab.isHidden = false
    }

}
