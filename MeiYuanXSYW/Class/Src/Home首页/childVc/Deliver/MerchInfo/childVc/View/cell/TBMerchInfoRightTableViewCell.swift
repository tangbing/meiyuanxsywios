//
//  TBMerchInfoRightTableViewCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/8.
//

import UIKit
import QMUIKit


protocol TBMerchInfoRightTableViewCellDelegate: NSObjectProtocol {
    func rightBuyButtonClickHandler(tableViewCell: TBMerchInfoRightTableViewCell, count: Int)
    
    func rightTableViewCell(_ tableViewCell: TBMerchInfoRightTableViewCell, rightLabelClick rightLabelTitle: String, rightInfoModel: GoodsItemVo)
    
    func rightPlusBtnClick(_ tableViewCell: TBMerchInfoRightTableViewCell)
    
    func rightReduceBtnClick(_ tableViewCell: TBMerchInfoRightTableViewCell)
    
    func rightTableViewCell(_ tableViewCell: TBMerchInfoRightTableViewCell, buyNumZero rightInfoModel: GoodsItemVo)
    
}

extension TBMerchInfoRightTableViewCellDelegate {
    func rightBuyButtonClickHandler(tableViewCell: TBMerchInfoRightTableViewCell, count: Int) {
        
    }
    
    func rightTableViewCell(_ tableViewCell: TBMerchInfoRightTableViewCell, rightLabelClick rightLabelTitle: String, rightInfoModel: GoodsItemVo) {

    }
}

class TBMerchInfoRightTableViewCell: XSBaseXIBTableViewCell {

    weak var delegate: TBMerchInfoRightTableViewCellDelegate?
    
    
    var rightInfoModel: GoodsItemVo? {
        didSet {
            guard let model = rightInfoModel else { return }
            
            goodsIcon.xs_setImage(urlString: model.picAddress, placeholder: UIImage.placeholder)
            goodsNameLab.text = model.goodsName
            goodsSalesLab.text = "月销\(model.goodsSales)"
            goodsPraise.text = "好评率\(model.goodsSales)"
            goodsCurrentPriceLab.text = "￥\(model.finalPrice)"
            goodsPreviousPriceLab.text = "￥\(model.originalPrice)"
            goodsPreviousPriceLab.isHidden = (model.finalPrice == model.originalPrice)
            
            plusRaduceButton.buyNum = UInt(model.buyOfNum)
            
            
            switch model.merchInfoShopState {
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
    
//    var rightInfoModel: TBDeliverMerchInfoShopModel? {
//        didSet {
//            guard let model = rightInfoModel else { return }
//
//            switch model.merchInfoShopState {
//                case .buyOut:
//                    rightBuyButton.isHidden = true
//                    rightLabel.isHidden = false
//                    rightLabel.text = "已售罄"
//                    rightLabel.textColor = UIColor.hex(hexString: "#FA6059")
//                    rightLabel.backgroundColor = .white
//                    rightLabel.font = MYFont(size: 13)
//                case .selectMulti:
//                    rightBuyButton.isHidden = true
//                    rightLabel.isHidden = false
//                    rightLabel.text = "+2份起售"
//                    rightLabel.textColor = UIColor.white
//                    rightLabel.font = MYFont(size: 12)
//                    rightLabel.backgroundColor = .king
//                case .selectStandard:
//                    rightBuyButton.isHidden = true
//                    rightLabel.isHidden = false
//                    rightLabel.text = "选规格"
//                    rightLabel.textColor = UIColor.white
//                    rightLabel.font = MYFont(size: 12)
//                    rightLabel.backgroundColor = .king
//                default:
//                    rightBuyButton.isHidden = false
//                    rightLabel.isHidden = true
//            }
//
//        }
//    }
    
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var goodsIcon: UIImageView!
    @IBOutlet weak var goodsNameLab: UILabel!
    @IBOutlet weak var goodsSalesLab: UILabel!
    @IBOutlet weak var goodsPraise: UILabel!
    @IBOutlet weak var goodsCurrentPriceLab: UILabel!
    @IBOutlet weak var goodsPreviousPriceLab: UILabel!
    
    @IBOutlet weak var rightLabel: QMUILabel!
    @IBOutlet weak var rightBuyButton: UIButton!
    
    lazy var plusRaduceButton: TBCartPlusReduceButtonView = {
        let button = TBCartPlusReduceButtonView()
        button.reduceBtnClickHandler = { [weak self] buttonView in
            guard let self = self else { return }
            self.delegate?.rightReduceBtnClick(self)
        }
        
        button.buyNumZeroBlock = { [weak self] buttonView in
            guard let self = self else { return }
            self.delegate?.rightTableViewCell(self, buyNumZero: self.rightInfoModel ?? GoodsItemVo())
        }
        
        button.plusBtnClickHandler = { [weak self] buttonView in
            guard let self = self else { return }
            self.delegate?.rightPlusBtnClick(self)
        }
        return button
    }()
    
    func configSearchStyle(){
        topConstraint.constant = 15
        self.hg_setAllCornerWithCornerRadius(radius: 10)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        goodsIcon.hg_setAllCornerWithCornerRadius(radius: 4)
        rightLabel.textColor = UIColor.white
        rightLabel.font = MYFont(size: 12)
        rightLabel.backgroundColor = .king
        
        rightLabel.contentEdgeInsets = UIEdgeInsets(top: 2, left: 4, bottom: 2, right: 4)
        rightLabel.hg_setAllCornerWithCornerRadius(radius: 4)
        rightLabel.jk.addGestureTap { [weak self] tap in
            guard let weakSelf = self else {
                return
            }
            weakSelf.delegate?.rightTableViewCell(weakSelf, rightLabelClick: weakSelf.rightLabel.text ?? "", rightInfoModel: weakSelf.rightInfoModel ?? GoodsItemVo() )
        }
        
        self.contentView.addSubview(plusRaduceButton)
        plusRaduceButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(0)
            make.centerY.equalTo(goodsCurrentPriceLab)
            make.height.equalTo(22)
        }
    }

    @IBAction func rightBuyButtonClick(_ sender: UIButton) {
        // 开始加号按钮值默认为1
        self.delegate?.rightBuyButtonClickHandler(tableViewCell: self, count: 1)
    }
    
}
