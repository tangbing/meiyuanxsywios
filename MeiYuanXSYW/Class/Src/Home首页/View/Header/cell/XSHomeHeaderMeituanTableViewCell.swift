//
//  XSHomeHeaderMeituanTableViewCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/9/24.
//

import UIKit
import HMSegmentedControl

class XSHomeHeaderMeituanTableViewCell: XSBaseTableViewCell {

    var shopRecommand: [ProbeShopMerchantDetail] = [ProbeShopMerchantDetail]()
    
    var meituanShopRecommand: XSHomeHeaderShopReommand? {
        didSet {
            guard let recommand = meituanShopRecommand else { return  }
            
            dinnerTypeLabel.text = recommand.timeType
            
            shopRecommand = recommand.probeShopDetails[0].probeShopMerchantDetails
            
            shopProductView.reloadData()
            
        }
    }

    let titles = ["外卖", "团购"]
    
    lazy var backView : UIView={
        let backView = UIView()
        backView.hg_setAllCornerWithCornerRadius(radius: 10)
        backView.backgroundColor = .white
        return backView
    }()
    
    lazy var dinnerTypeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.hex(hexString: "#737373")
        label.font = MYFont(size: 13)
        label.text = "晚餐探店"
        return label
    }()
    
    lazy var segment: HMSegmentedControl = {
        let segment = HMSegmentedControl(sectionTitles: titles)
        segment.type = .text
        segment.backgroundColor = .white
        segment.selectionIndicatorHeight = 3.0
        segment.selectionIndicatorLocation = .bottom
        segment.selectedSegmentIndex = 0
        
        segment.selectedTitleTextAttributes = [ NSAttributedString.Key.foregroundColor : UIColor.text, NSAttributedString.Key.font : MYBlodFont(size: 19)]
        segment.titleTextAttributes = [ NSAttributedString.Key.foregroundColor : UIColor.text, NSAttributedString.Key.font : MYFont(size: 15)]
        
        segment.selectionIndicatorColor = UIColor.hex(hexString: "#DDA877")
        segment.addTarget(self, action: #selector(segmentValueChanged), for: .valueChanged)
        return segment
    }()
    
    lazy var shopProductView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 9
        layout.minimumInteritemSpacing = 0
        let itemW:CGFloat = 108
        let itemH:CGFloat = 120
        layout.itemSize = CGSize(width: itemW, height: itemH)
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.register(UINib(nibName: "XSHeaderMeiTuanCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "XSHeaderMeiTuanCollectionViewCell")

        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupUI()
        
        loadRecommandData(flage: 0)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.backgroundColor = .clear
        // self.contentView.backgroundColor = .purple
        self.contentView.addSubview(backView)
        backView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        backView.addSubview(segment)
        segment.snp.makeConstraints {
            $0.left.equalToSuperview().offset(10)
            $0.top.equalToSuperview().offset(8)
            $0.height.equalTo(28)
            $0.width.equalTo(100)
        }
        
        backView.addSubview(dinnerTypeLabel)
        dinnerTypeLabel.snp.makeConstraints {
            $0.left.equalTo(segment.snp_right).offset(15)
            $0.centerY.equalTo(segment).offset(0)
        }
        
        backView.addSubview(shopProductView)
        shopProductView.snp.makeConstraints { make in
            make.top.equalTo(segment.snp_bottom).offset(8)
            make.right.equalToSuperview()
            make.left.equalTo(segment.snp_left).offset(0)
            make.height.equalTo(120)
            make.bottom.equalToSuperview().offset(-16)
        }
        
        
    }
    
   private func loadRecommandData(flage: UInt) {
        let lat: Double = XSAuthManager.shared.latitude
        let lon: Double = XSAuthManager.shared.longitude
        
        
        MerchantInfoProvider.request(.getFrontPageProbeShopRecommend(lat:lat , lng: lon, flag: Int(flage)), model: XSHomeHeaderShopReommand.self) { returnData in
            
            guard let shopRecommand = returnData else {
                return
            }
            
            self.meituanShopRecommand = shopRecommand
            
        } errorResult: { errorMsg in
            XSTipsHUD.hideAllTips()
            XSTipsHUD.showText(errorMsg)
        }
    }
    
    @objc func segmentValueChanged(){
        let flage = segment.selectedSegmentIndex
        loadRecommandData(flage: flage)
    }
}

extension XSHomeHeaderMeituanTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shopRecommand.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "XSHeaderMeiTuanCollectionViewCell", for: indexPath) as! XSHeaderMeiTuanCollectionViewCell
        cell.merchantDetail = shopRecommand[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let recommand = shopRecommand[indexPath.item]
        if let currentVc = topVC {
            let flage = segment.selectedSegmentIndex
            var navController: XSBaseViewController
            
            if flage == 0 {// 外卖
                navController = TBDeliverMerchanInfoViewController(style: .deliver, merchantId: recommand.merchantId)
            } else { // 团购
                navController = TBGroupBuyMerchInfoViewController(style: .groupBuy, merchantId: recommand.merchantId)
            }
            currentVc.navigationController?.pushViewController(navController, animated: true)
        }
    }
    
    
}

