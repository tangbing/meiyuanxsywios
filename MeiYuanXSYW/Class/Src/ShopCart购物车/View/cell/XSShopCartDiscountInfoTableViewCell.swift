//
//  XSShopCartDiscountInfoTableViewCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/29.
//

import UIKit
import QMUIKit


class XSCaculateAmtView: TBBaseView {
    
    lazy var leftTitleLab: UILabel = {
        let leftTitle = UILabel()
        leftTitle.text = "打包费"
        leftTitle.textColor = .text
        leftTitle.font = MYFont(size: 14)
        return leftTitle
    }()
    
    lazy var rightSubValueLab: UILabel = {
        let rightSubValue = UILabel()
        rightSubValue.text = "¥2"
        rightSubValue.textColor = UIColor.hex(hexString: "#B3B3B3")
        rightSubValue.font = MYFont(size: 11)
        return rightSubValue
    }()
    
    lazy var rightValueLab: UILabel = {
        let rightValue = UILabel()
        rightValue.text = "¥2"
        rightValue.textColor = .text
        rightValue.font = MYFont(size: 14)
        return rightValue
    }()
    
    override func configUI() {
        super.configUI()
        
        self.addSubview(leftTitleLab)
        leftTitleLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.bottom.equalToSuperview()
        }
        
        self.addSubview(rightValueLab)
        rightValueLab.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
        }
        
        self.addSubview(rightSubValueLab)
        rightSubValueLab.snp.makeConstraints { make in
            make.right.equalTo(rightValueLab.snp_left).offset(-6)
            make.centerY.equalTo(rightValueLab)
        }
        
    }
}

class XSShopCartDiscountInfoTableViewCell: XSBaseTableViewCell {
    
    var caculateModel: OrderCarVOList = OrderCarVOList()
    
    var infoModel: XSShopCartDiscountInfoModel? {
        didSet {
            guard let model = infoModel else {
                return
            }
            caculateModel = model.caculateMoreAmt
                
                // 团购, 隐藏打包费，配送费
                // 业务类型，0外卖，1私厨，2团购
                if caculateModel.bizType != 2 {
                    hideAmt(false)
                } else {
                    hideAmt(true)
                }
                
            
                packetAmt.leftTitleLab.text = "打包费"
                packetAmt.rightValueLab.text = "¥\(caculateModel.packetAmt)"
                
                transportAmt.leftTitleLab.text = "预计配送费"
                transportAmt.rightSubValueLab.text = "¥\(caculateModel.distributionAmt)"
            
                let finalPrice = "¥\(caculateModel.distributionAmt.doubleValue - caculateModel.distributionCheapAmt.doubleValue)"
                transportAmt.rightValueLab.text = finalPrice
                transportAmt.rightSubValueLab.jk.setSpecificTextDeleteLine("¥\(caculateModel.distributionAmt)", color: .twoText)

                
                multDiscountValuelab.text = "-¥\(caculateModel.moreDiscountAmt)"
                
                totalPriceLab.text = "¥\(caculateModel.payAmt)"
                
                totalDiscountLab.text = "-¥\(caculateModel.cheapAmt)"
    
            if model.hasBottomRadius {
                self.contentView.hg_setCornerOnBottomWithRadius(radius: 10)
            }
        }
    }
    
    let discontInfoTitles = ["配送减免"]
    
    lazy var discontInfoTitle: UILabel = {
        let infoTitle = UILabel()
        infoTitle.text = "优惠信息"
        infoTitle.font = MYBlodFont(size: 16)
        infoTitle.textColor = .text
        return infoTitle
    }()
    
    let line = lineView(bgColor: UIColor.hex(hexString: "#E5E5E5"))
    
    lazy var multDiscountBtn : QMUIButton = {
        let arrowBtn = QMUIButton()
        arrowBtn.contentHorizontalAlignment = .left
        arrowBtn.imagePosition = QMUIButtonImagePosition.right
        arrowBtn.setTitle("多件折扣", for: UIControl.State.normal)
      
        arrowBtn.setImage(UIImage(named: "shopcart-icon-question"), for: UIControl.State.normal)
        arrowBtn.setTitleColor(.text, for: UIControl.State.normal)
        arrowBtn.titleLabel?.font = MYBlodFont(size: 14)
        arrowBtn.spacingBetweenImageAndTitle = 2
        //arrowBtn.addTarget(self, action: #selector(showShopInfo), for: .touchUpInside)
        return arrowBtn
    }()
    
    lazy var multDiscountValuelab: UILabel = {
        let lab = UILabel()
        lab.text = "-¥0"
        lab.textAlignment = .right
        lab.textColor = UIColor.hex(hexString: "#737373")
        lab.font = MYFont(size: 16)
        return lab
    }()
    
    /// 优惠金额
    lazy var totalDiscountLab: UILabel = {
        let discount = UILabel()
        discount.text = "-¥0"
        discount.textColor = UIColor.hex(hexString: "#E61016")
        discount.font = MYBlodFont(size: 16)
        return discount
    }()
    
    var leftTitleLabel: UILabel = {
        let leftTitle = UILabel()
        leftTitle.text = "已优惠："
        leftTitle.textColor = .twoText
        leftTitle.font = MYFont(size: 14)
        return leftTitle
    }()
    
    var rightTitleLabel: UILabel = {
        let rightTitle = UILabel()
        rightTitle.text = "小计："
        rightTitle.textColor = .text
        rightTitle.font = MYFont(size: 14)
        return rightTitle
    }()
    
    /// 小计值
    lazy var totalPriceLab: UILabel = {
        let price = UILabel()
        price.text = "¥0"
        price.textColor = UIColor.hex(hexString: "#E61016")
        price.font = MYBlodFont(size: 16)
        return price
    }()
    
    lazy var footerView: UIView = {
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 44))
        
        footer.addSubview(leftTitleLabel)
        leftTitleLabel.snp.makeConstraints { make in
            make.left.centerY.equalToSuperview()
        }


        footer.addSubview(totalDiscountLab)
        totalDiscountLab.snp.makeConstraints { make in
            make.left.equalTo(leftTitleLabel.snp_right).offset(0)
            make.centerY.equalToSuperview()
        }

        footer.addSubview(totalPriceLab)
        totalPriceLab.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(0)
            make.centerY.equalToSuperview()
        }

        footer.addSubview(rightTitleLabel)
        rightTitleLabel.snp.makeConstraints { make in
            make.right.equalTo(totalPriceLab.snp_left).offset(0)
            make.centerY.equalToSuperview()
        }
        
        return footer
    }()
    
    lazy var headerView: UIView = {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 44))
        header.addSubview(multDiscountBtn)
        multDiscountBtn.frame = CGRect(x: 0, y: 40, width: 120, height: 15)
        multDiscountBtn.tb_centerY = 44 * 0.5
        
        header.addSubview(multDiscountValuelab)
        multDiscountValuelab.frame = CGRect(x: screenWidth - 50 - 80, y: 0, width: 80, height: 23)
        multDiscountValuelab.tb_centerY = 44 * 0.5
        return header
    }()
    
    lazy var packetAmt: XSCaculateAmtView = {
        let packet = XSCaculateAmtView()
        return packet
    }()
    
    lazy var transportAmt: XSCaculateAmtView = {
        let transport = XSCaculateAmtView()
        return transport
    }()
    
  
    lazy var expendTableView: TBBaseTableView = {
        let exendTableView = TBBaseTableView(frame: .zero, style: .plain)
        //exendTableView.register(cellType: TBMerchInfoExpendDiscountInfoCell.self)
       // exendTableView.register(cellType: TBMerchInfoExpendMerchServiceCell.self)
        exendTableView.register(cellType: XSShopCartMultDiscountTableViewCell.self)
        exendTableView.backgroundColor = .white
        //exendTableView.estimatedRowHeight = 80
        exendTableView.dataSource = self
        exendTableView.delegate = self
        exendTableView.tableFooterView = footerView
        exendTableView.tableHeaderView = headerView

        return exendTableView
    }()
    
    override func configUI() {
        super.configUI()
        setupDiscountInfoCell()
    }
    
    func hideAmt(_ isHide: Bool) {
        
        if isHide {
            packetAmt.isHidden = isHide
            transportAmt.isHidden = isHide
            
            packetAmt.snp.updateConstraints { make in
                make.height.equalTo(0)
                make.top.equalToSuperview().offset(0)
            }
            transportAmt.snp.updateConstraints { make in
                make.height.equalTo(0)
            }
        } else {
            packetAmt.isHidden = isHide
            transportAmt.isHidden = isHide
            packetAmt.snp.updateConstraints { make in
                make.height.equalTo(44)
                make.top.equalToSuperview().offset(10)
            }
            transportAmt.snp.updateConstraints { make in
                make.height.equalTo(44)
            }
        }
    }
    
    func setupDiscountInfoCell(){
        
        self.contentView.addSubview(packetAmt)
        packetAmt.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(10)
            make.height.equalTo(44)
        }
        
        self.contentView.addSubview(transportAmt)
        transportAmt.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(packetAmt.snp_bottom)
            make.height.equalTo(44)

        }
        
        self.contentView.addSubview(discontInfoTitle)
        discontInfoTitle.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.height.equalTo(14)
            make.top.equalTo(transportAmt.snp_bottom).offset(10)
        }
        
        self.contentView.addSubview(line)
        line.snp.makeConstraints { make in
            make.top.equalTo(discontInfoTitle.snp_bottom).offset(15)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(1)
        }
        
        self.contentView.addSubview(expendTableView)
        expendTableView.snp.makeConstraints { make in
            make.top.equalTo(line.snp_bottom).offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-10)
            make.height.equalTo(34 * discontInfoTitles.count + 44 * 2)
        }
    }
    
}

extension XSShopCartDiscountInfoTableViewCell: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return discontInfoTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XSShopCartMultDiscountTableViewCell.self)
        cell.leftView.text = "新"
        cell.contentlab.text = discontInfoTitles[indexPath.row]
        cell.discountMsglab.text = discontInfoTitles[indexPath.row] + "\(caculateModel.distributionCheapAmt)"
        cell.lastPricelab.text = "-¥\(caculateModel.distributionCheapAmt)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 34
    }
    
    
}
