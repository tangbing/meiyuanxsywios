//
//  TBHomeTicketTableViewCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/10/20.
//

import UIKit

class TBHomeTicketTableViewCell: XSBaseXIBTableViewCell {

    @IBOutlet weak var expendButton: UIButton!
    @IBOutlet weak var bottomView: UIView!

    public var expendBtnClickHandler: ((_ model: FreeCouponVoData, _ selectRow: Int) -> Void)?
    public var useBtnClickHandler: ((_ model: FreeCouponVoData, _ nowPullButton: UIButton) -> Void)?

    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var line: UIView!
    @IBOutlet weak var ticketBg: UIImageView!
    @IBOutlet weak var shopStackView: UIStackView!
    @IBOutlet weak var ticketUseEdLabel: UILabel!
    
    @IBOutlet weak var tickUseEdLabelH: NSLayoutConstraint!
    
    @IBOutlet weak var ticketCover: UIImageView!
    
    @IBOutlet weak var ticketNameLab: UILabel!
    
    @IBOutlet weak var receiveTimeLab: UILabel!
    
    @IBOutlet weak var ticket_timeout: UIImageView!
    @IBOutlet weak var useConditionLab: UILabel!
    
    // 使用说明
    @IBOutlet weak var useExplainLab: UILabel!
    
    @IBOutlet weak var stack_icon1: UIImageView!
    @IBOutlet weak var stack_icon2: UIImageView!
    @IBOutlet weak var stack_icon3: UIImageView!

    
    @IBOutlet weak var useGuideTitleLab: UILabel!
    
    
    //立即使用

    lazy var nowPullButton : UIButton = {
        let arrowBtn = UIButton(type: .custom)
        arrowBtn.setTitle("立即使用", for: UIControl.State.normal)
        arrowBtn.setTitleColor(.king, for: UIControl.State.normal)
        arrowBtn.jk.addBorder(borderWidth: 1, borderColor: .king)
        arrowBtn.hg_setAllCornerWithCornerRadius(radius: 12)
        arrowBtn.titleLabel?.font = MYFont(size: 12)
        arrowBtn.addTarget(self, action: #selector(clickNowUseAction(button:)), for: .touchUpInside)
        return arrowBtn
    }()
    
    var model: TBHomeTicketViewModel? {
        didSet {
            guard let data = model else { return }
            
            if data.style == .ViewModeStyleTicketBySelf {
                ticketBg.image = UIImage(named: "home_ticket_king_bg")
                nowPullButton.setTitle("立即使用", for: .normal)
                tickUseEdLabelH.constant = 0

            } else {
                ticketBg.image = UIImage(named: "home_ticket_red_bg")
                nowPullButton.setTitle("立即领取", for: .normal)
                tickUseEdLabelH.constant = 14.5
            }
            
            guard let model = data.modle as? FreeCouponVoData else { return }
            
            shopStackView.isHidden = !(model.merchantImageList.count > 0)
            useGuideTitleLab.isHidden = model.merchantImageList.count > 0
            expendButton.isHidden = model.merchantImageList.count > 0
            ticketUseEdLabel.text = "已领\(model.receivedNum)/限量\(model.issueTotalCount)张"
            
            if (model.merchantImageList.count == 1) {
                stack_icon1.xs_setImage(urlString: model.merchantImageList[0])
            } else if (model.merchantImageList.count == 2) {
                stack_icon1.xs_setImage(urlString: model.merchantImageList[0])
                stack_icon2.xs_setImage(urlString: model.merchantImageList[1])
            } else if (model.merchantImageList.count == 3) {
                stack_icon1.xs_setImage(urlString: model.merchantImageList[0])
                stack_icon2.xs_setImage(urlString: model.merchantImageList[1])
                stack_icon3.xs_setImage(urlString: model.merchantImageList[2])
            }
            
            
            let isTimeOut = model.useStatus != 2
            ticketCover.isHidden = isTimeOut
            ticket_timeout.isHidden = isTimeOut

            ticketNameLab.text = model.couponName
            
            useExplainLab.text = model.useExplain
            receiveTimeLab.text =  "\(model.endDate)到期"

            useConditionLab.text = "满\(model.fullReductionAmount)元使用"
            
            
            priceLabel.text = "¥\(model.discountAmount)"
            priceLabel.jk.setsetSpecificTextFont("\(model.discountAmount)", font:MYBlodFont(size: 35))
            priceLabel.jk.setSpecificTextColor("\(model.discountAmount)", color: .white)
            priceLabel.jk.setSpecificTextColor("¥", color: .white)
            
            line.jk.drawDashLine(strokeColor: UIColor.fourText, lineLength: 4, lineSpacing: 4, direction: .horizontal)
            
            let arrow = expendButton.imageView!
            if !model.isSelect { // 箭头旋转
                UIView.animate(withDuration: 0.25) {
                    arrow.transform = CGAffineTransform(rotationAngle: .pi)
                }
            } else {
                arrow.transform = CGAffineTransform.identity
            }
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        contentView.backgroundColor = .white
        contentView.hg_setAllCornerWithCornerRadius(radius: 10)
        

        self.contentView.addSubview(nowPullButton)
        nowPullButton.snp.makeConstraints { make in
            make.right.equalTo(ticketUseEdLabel)
            make.bottom.equalTo(ticketUseEdLabel.snp_top).offset(-10)
            make.size.equalTo(CGSize(width: 72, height: 24))
        }

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @objc func clickNowUseAction(button: UIButton) {
        guard let data = model?.modle as? FreeCouponVoData else { return }

        useBtnClickHandler?(data, button)
        
    }
    
    @IBAction func expendBtnClick(_ sender: UIButton) {
        
        guard let data = model?.modle as? FreeCouponVoData else { return }

        data.isSelect = !data.isSelect

        expendBtnClickHandler?(data, sender.tag)
    }

}
