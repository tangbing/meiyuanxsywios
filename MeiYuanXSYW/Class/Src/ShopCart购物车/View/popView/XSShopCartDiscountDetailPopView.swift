//
//  XSShopCartDiscountDetailPopView.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/12/1.
//

import UIKit

class XSShopCartDiscountDetailPopView: TBBaseView {
    
    var container: UIView?
    
    lazy var overlayView: UIControl = {
        let control = UIControl(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight - 183))
        control.backgroundColor = UIColor(r: 0, g: 0, b: 0, a: 0.6)
        control.addTarget(self, action: #selector(fadeOut), for: .touchUpInside)
        control.isHidden = true
        return control
    }()
    
    lazy var moneyDetailLabel: UILabel = {
        let moneyDetail = UILabel()
        moneyDetail.text = "金额明细"
        moneyDetail.textColor = .text
        moneyDetail.textAlignment = .center
        moneyDetail.font = MYFont(size: 16)
        return moneyDetail
    }()

    lazy var msgLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "实际优惠以订单页为主"
        label.textColor = .twoText
        label.font = MYFont(size: 12)
        return label
    }()
    
    lazy var selectProductView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        let itemWidth: CGFloat = FMScreenScaleFrom(80)
        let itemHeight = itemWidth * 0.75 + 20
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.register(cellType: XSShopCartDiscountDetailCollectionViewCell.self)

        return collectionView
    }()
    
    lazy var ticketTableView: TBBaseTableView = {
        let ticketView = TBBaseTableView(frame: .zero, style: .plain)
        ticketView.register(cellType: XSShopCartMultDiscountTableViewCell.self)
//        ticketView.register(cellType: XSQuestSelectTypeTableViewCell.self)
//        ticketView.register(cellType: TBMerchInfoCompainTextViewCell.self)
//        ticketView.register(cellType: TBMerchInfoCompainUploadPicCell.self)
        ticketView.backgroundColor = .white
        ticketView.rowHeight = 34
        ticketView.dataSource = self
        ticketView.delegate = self
        return ticketView
    }()
    
    override func configUI() {
        super.configUI()
        self.backgroundColor = UIColor.white

        self.addSubview(moneyDetailLabel)
        moneyDetailLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(6)
            make.centerX.equalToSuperview()
            make.height.equalTo(24)
        }
        
        self.addSubview(msgLabel)
        msgLabel.snp.makeConstraints { make in
            make.top.equalTo(moneyDetailLabel.snp_bottom).offset(0)
            make.centerX.equalToSuperview()
            make.height.equalTo(16.5)
        }
        
        self.addSubview(selectProductView)
        selectProductView.snp.makeConstraints { make in
            make.height.equalTo(94)
            make.top.equalTo(msgLabel.snp_bottom).offset(19.5)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        
        self.addSubview(ticketTableView)
        ticketTableView.snp.makeConstraints { make in
            make.top.equalTo(selectProductView.snp_bottom).offset(8)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview()
        }
        
      

    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: screenWidth, height: 304)
    }
    
}

extension XSShopCartDiscountDetailPopView {
    // MARK: - public event
    func show(showSuperView: UIView? = nil,locationView: UIView){
        let container: UIView! = showSuperView == nil ? UIApplication.shared.keyWindow : showSuperView
        container.addSubview(overlayView)
        container.addSubview(self)
        
        container.bringSubviewToFront(locationView)
        
        self.container = locationView
        self.frame = CGRect(x: 0, y: screenHeight, width: screenWidth, height: intrinsicContentSize.height)
        self.hg_setCornerOnTopWithRadius(radius: 12)
        fadeIn()
    }
    
    func fadeIn() {
     
        UIView.animate(withDuration: 0.25, delay: 0, options: UIView.AnimationOptions.curveEaseOut) {
            self.overlayView.isHidden = false
            self.frame = CGRect(x: 0, y:self.container!.tb_minY - self.intrinsicContentSize.height , width: screenWidth, height: self.intrinsicContentSize.height)
        }
    }
    
    @objc func fadeOut() {
        UIView.animate(withDuration: 0.25, delay: 0, options: UIView.AnimationOptions.curveEaseOut) {
            self.overlayView.isHidden = true
            self.frame = CGRect(x: 0, y: screenHeight, width: screenWidth, height: self.intrinsicContentSize.height)
        } completion: { (finish) in
            self.overlayView.removeFromSuperview()
            self.removeFromSuperview()
        }
    }
    
}



// MARK: - UICollectionViewDataSource & UICollectionViewDelegate
extension XSShopCartDiscountDetailPopView : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        if indexPath.item == 3 {
//            return CGSize(width: itemWidth + 18, height: itemHeight)
//        }
//        return CGSize(width: itemWidth, height: itemHeight)
//    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 12
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
//        return 0
//    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(for: indexPath, cellType: XSShopCartDiscountDetailCollectionViewCell.self)
//        if indexPath.item != 3 {
//            item.rightNumView.snp.updateConstraints { make in
//                make.width.equalTo(0)
//            }
//            item.rightNumView.isHidden = true
//        } else {
//            item.rightNumView.snp.updateConstraints { make in
//                make.width.equalTo(18)
//            }
//            item.rightNumView.isHidden = false
//        }
        return item
    }
    
}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension XSShopCartDiscountDetailPopView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XSShopCartMultDiscountTableViewCell.self)
        if (indexPath.row == 3) {
            cell.configImageViewDataUI(isHidden: true)

        }
        return cell
    }
    
    
}
