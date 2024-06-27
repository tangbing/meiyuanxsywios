//
//  TBMerchInfoDeliverCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/5.
//

import UIKit
import QMUIKit

class TBMerchInfoDeliverCollectionViewCell: XSBaseXIBCollectionViewCell {
    
    var goodsItem: GoodsItemVo? {
        didSet {
            guard let item = goodsItem else {
                return
            }
            
            picImageView.xs_setImage(urlString: item.picAddress)
            
            goodsNameLab.text = item.goodsName
            
            goodsSaleLab.text = "月销\(item.goodsSales)"
            evaluteLabel.text = "\(item.praise)%好评率"
            minPriceLab.text = "¥\(item.finalPrice.doubleValue)"
            originalPriceLab.text = "¥\(item.originalPrice.doubleValue)"
            
            
            originalPriceLab.isHidden = (item.finalPrice == item.originalPrice)
            
            plusRaduceButton.buyNum = UInt(item.buyOfNum)
            
            
            switch item.merchInfoShopState {
                case .buyOut:
                    plusRaduceButton.isHidden = true
                    rightBuyButton.isHidden = true
                    rightLabel.isHidden = false
                    rightLabel.text = "已售罄"
                    rightLabel.textColor = UIColor.hex(hexString: "#FA6059")
                    rightLabel.backgroundColor = .white
                    rightLabel.font = MYFont(size: 13)
                case .selectMulti:
                    plusRaduceButton.isHidden = true
                    rightBuyButton.isHidden = true
                    rightLabel.isHidden = false
                    rightLabel.text = "+2份起售"
                    rightLabel.textColor = UIColor.white
                    rightLabel.font = MYFont(size: 12)
                    rightLabel.backgroundColor = .king
                case .selectStandard:
                    plusRaduceButton.isHidden = true
                    rightBuyButton.isHidden = true
                    rightLabel.isHidden = false
                    rightLabel.text = "选规格"
                    rightLabel.textColor = UIColor.white
                    rightLabel.font = MYFont(size: 12)
                    rightLabel.backgroundColor = .king
                case .plusReduce:
                   rightLabel.isHidden = true
                   rightBuyButton.isHidden = true
                   plusRaduceButton.isHidden = false
            case .pauseBusiness:
                  plusRaduceButton.isHidden = true
                  rightBuyButton.isHidden = false
                  rightBuyButton.isSelected = true
                  rightBuyButton.isUserInteractionEnabled = false
                  rightLabel.isHidden = true
                
                default:
                   plusRaduceButton.isHidden = true
                   rightBuyButton.isHidden = false
                   rightBuyButton.isSelected = false
                   rightBuyButton.isUserInteractionEnabled = true
                   rightLabel.isHidden = true
            }
            
            
            
        }
    }

    @IBOutlet weak var evaluteLabel: QMUILabel!
    
    @IBOutlet weak var originalPriceLab: UILabel!
    @IBOutlet weak var goodsSaleLab: UILabel!
    @IBOutlet weak var goodsNameLab: UILabel!
    @IBOutlet weak var picImageView: UIImageView!
    @IBOutlet weak var minPriceLab: UILabel!
    
    @IBOutlet weak var rightLabel: QMUILabel!
    @IBOutlet weak var rightBuyButton: UIButton!
    
    weak var delegate: TBMerchInfoRightTableViewCellDelegate?

    
    lazy var plusRaduceButton: TBCartPlusReduceButtonView = {
        let button = TBCartPlusReduceButtonView()
        button.reduceBtnClickHandler = { [weak self] buttonView in
            guard let self = self else { return }
            //self.delegate?.rightReduceBtnClick(self)
            NotificationCenter.default.post(name: NSNotification.Name.XSCartReduceClickNotification , object: self, userInfo: ["TBMerchInfoDeliverCollectionViewCell" : self])
        }
        
        button.buyNumZeroBlock = { [weak self] buttonView in
            guard let self = self else { return }
            //self.delegate?.rightTableViewCell(self, buyNumZero: self.rightInfoModel ?? GoodsItemVo())
        }
        
        button.plusBtnClickHandler = { [weak self] buttonView in
            guard let self = self else { return }
            //self.delegate?.rightPlusBtnClick(self)
            
            NotificationCenter.default.post(name: NSNotification.Name.XSCartPlusBtnClickNotification , object: self, userInfo: ["TBMerchInfoDeliverCollectionViewCell" : self])
            
        }
        return button
    }()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        evaluteLabel.contentEdgeInsets = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        evaluteLabel.text = "97%好评率"
        evaluteLabel.backgroundColor = .tag
        evaluteLabel.hg_setAllCornerWithCornerRadius(radius: 2)
        
        
        rightLabel.textColor = UIColor.white
        rightLabel.font = MYFont(size: 12)
        rightLabel.backgroundColor = .king
        
        rightLabel.contentEdgeInsets = UIEdgeInsets(top: 2, left: 4, bottom: 2, right: 4)
        rightLabel.hg_setAllCornerWithCornerRadius(radius: 4)
        rightLabel.jk.addGestureTap { [weak self] tap in
            guard let weakSelf = self else {
                return
            }
            
            NotificationCenter.default.post(name: NSNotification.Name.XSSelectStandardMenuFirstClickNotification , object: weakSelf, userInfo: ["TBMerchInfoDeliverCollectionViewCell" : weakSelf])

            //weakSelf.delegate?.rightTableViewCell(weakSelf, rightLabelClick: weakSelf.rightLabel.text ?? "", rightInfoModel: weakSelf.rightInfoModel ?? GoodsItemVo() )
        }
        
        self.contentView.addSubview(plusRaduceButton)
        plusRaduceButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(0)
            make.centerY.equalTo(minPriceLab)
            make.height.equalTo(22)
        }
        
        
    }
    
    @IBAction func rightBuyButtonClick(_ sender: UIButton) {
        // 开始加号按钮值默认为1
        //self.delegate?.rightBuyButtonClickHandler(tableViewCell: self, count: 1)
        NotificationCenter.default.post(name: NSNotification.Name.XSRightBuyButtonFirstClickNotification , object: self, userInfo: ["TBMerchInfoDeliverCollectionViewCell" : self])
        
        
    }
    
    
}
