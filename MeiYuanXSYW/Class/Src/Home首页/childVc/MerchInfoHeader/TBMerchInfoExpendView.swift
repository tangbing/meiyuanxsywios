//
//  TBMerchInfoExpendView.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/10/29.
//

import UIKit
import QMUIKit

struct ExendViewModel {
    var prefixIcon : String
    var infoStr    : String
   
}


class TBMerchInfoExpendView: UIView {
    
    let sectionContents = ["","商家公告"]
    var exendViewModels: [ExendViewModel] = [ExendViewModel]()
    var model: TBDelieveMerchatInfoModel?
        
    lazy var footerView: UIView = {
        let footer = UIView(frame: CGRect(x: 10, y: 0, width: screenWidth - 20, height: 70))
        footer.addSubview(arrowDownBtn)
        arrowDownBtn.frame = CGRect(x: 30, y: 40, width: 15, height: 15)
        arrowDownBtn.tb_centerX = screenWidth * 0.5
        return footer
    }()

    lazy var expendTableView: TBBaseTableView = {
        let exendTableView = TBBaseTableView(frame: .zero, style: .plain)
        exendTableView.register(cellType: TBMerchInfoExpendDiscountInfoCell.self)
       // exendTableView.register(cellType: TBMerchInfoExpendMerchServiceCell.self)
        exendTableView.register(cellType: TBMerchInfoExpendMerchPublishInfoCell.self)
        exendTableView.backgroundColor = .white
        exendTableView.estimatedRowHeight = 30
        exendTableView.dataSource = self
        exendTableView.delegate = self
        exendTableView.tableFooterView = footerView
        return exendTableView
    }()
    
    var arrowDownBtn : QMUIButton = {
        let arrowBtn = QMUIButton()
        //arrowBtn.imagePosition = QMUIButtonImagePosition.right
        arrowBtn.setImage(UIImage(named: "merch_info_arrow_down"), for: UIControl.State.normal)
        arrowBtn.addTarget(self, action: #selector(arrowDownBtnAction), for: .touchUpInside)
        return arrowBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @objc func arrowDownBtnAction() {
        self.removeFromSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupData(_ dataModel: TBDelieveMerchatInfoModel){
        model = dataModel
        
        exendViewModels.removeAll()
        /// 联盟满减
        if let unionActivity = dataModel.unionActivity {
            let unionActivityModel = ExendViewModel(prefixIcon: "merchInfo_header_meal", infoStr: unionActivity)
            exendViewModels.append(unionActivityModel)
        }
        /// 新客立减
        if let newCustomerFullReduce = dataModel.newCustomerFullReduce {
            let newCustomerFullReduceModel = ExendViewModel(prefixIcon: "merchInfo_header_head", infoStr: newCustomerFullReduce)
            exendViewModels.append(newCustomerFullReduceModel)
        }
        /// 商品满减
        if let goodsFullReduce = dataModel.goodsFullReduce {
            let goodsFullReduceModel = ExendViewModel(prefixIcon: "merchInfo_header_reduce", infoStr: goodsFullReduce)
            exendViewModels.append(goodsFullReduceModel)
        }
        /// 店铺满减
        if let merchantFullReduce = dataModel.merchantFullReduce {
            let merchantFullReduceModel = ExendViewModel(prefixIcon: "merchInfo_header_shop", infoStr: merchantFullReduce)
            exendViewModels.append(merchantFullReduceModel)
        }
        
        expendTableView.reloadData()
    }

    private func setupUI(){
        self.backgroundColor = .white
        self.addSubview(expendTableView)
        expendTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
        }
    }
    
}

extension TBMerchInfoExpendView: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionContents.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 { return exendViewModels.count }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TBMerchInfoExpendDiscountInfoCell.self)
            let model = exendViewModels[indexPath.row]
            cell.contentlab.text = model.infoStr
            cell.leftView.image = UIImage(named: model.prefixIcon)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TBMerchInfoExpendMerchPublishInfoCell.self)
            cell.contentLabel.text = model?.storeNotice
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let dic = self.sectionContents[section]
        if dic.count == 0 { return 0.0001 }
        return 30
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        let titleLabel = UILabel()
        titleLabel.textColor = .text
        titleLabel.font = MYFont(size: 12)
        header.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(header).offset(15)
            make.centerY.equalTo(header)
        }
        let dic = self.sectionContents[section]
        titleLabel.text = dic
        return header
    }
}
