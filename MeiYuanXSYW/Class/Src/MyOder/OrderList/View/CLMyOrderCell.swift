//
//  MyOrderCell.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/11/23.
//

import UIKit
import Kingfisher
import AVFoundation
import JKSwiftExtension


class CLMyOrderCell: XSBaseTableViewCell{
    var type:CLMyOrderShopType = .deliver(status: .waitPay,title: "") {
        didSet {
            switch type {
            case .deliver(let status,let title):
                
                if status == .waitPay {
                    preLabel.text = "需付"
                }
                
                selectView.statusType = type
                statusLabel.text = title
                label.text = "外卖"
                label.backgroundColor = UIColor.link
                
            case .groupBuy:
                return
            case .privateKitchen(let status,let title):
                selectView.statusType = type
                statusLabel.text = title
                label.backgroundColor = UIColor.qmui_color(withHexString: "#FF6E02")
                label.text = "私厨"
            case .member:
                return
            case .allType(status: let status):
                selectView.statusType = type
                statusLabel.text = status
                label.text = "聚合"
                label.backgroundColor = UIColor.qmui_color(withHexString: "#FF6E02")
            }
        }
    }
    
    var model:CLMyOrderListModel? {
        didSet{
            guard let cellModel = model else { return }
            shopName.text = cellModel.merchantName
            orderTime.text = "下单时间:\(cellModel.orderTime)"
            moneyLabel.attributedText = self.attributedString(string: "￥\(cellModel.payAmt)", font: MYBlodFont(size: 12), textColor: .text, lineSpaceing: 0, wordSpaceing: 0)
            goodModel = cellModel.orderGoodsDetailVOList
            collectioniew.reloadData()
        }
    }
    
    var source:String? {
        didSet{
            guard let str = source else { return }
            statusLabel.text = String(format: "待支付,剩余%d分%d秒",(180/60)%60, 180%60)
            self.countDownNotification()
        }
    }
    
    var countDownZero:(()->())?
    
    var goodModel:[CLOrderGoodsDetailVOList] = []
    
    let baseView = UIView().then{
        $0.layer.cornerRadius = 10
        $0.backgroundColor = .white
    }
    
    let label = UILabel().then{
        $0.backgroundColor = UIColor.link
        $0.layer.cornerRadius = 2
        $0.text = "外卖"
        $0.textColor = .white
        $0.font = MYFont(size: 9)
        $0.textAlignment = .center
        $0.layer.cornerRadius = 2
        $0.clipsToBounds = true
    }
    
    let shopName = UILabel().then{
        $0.text = "商家名称"
        $0.textColor = UIColor.text
        $0.font = MYBlodFont(size: 16)
    }

    let statusLabel = UILabel().then{
        $0.text = "待支付"
        $0.textColor = UIColor.king
        $0.font = MYFont(size: 14)
    }
    
    let line = UIView().then{
        $0.backgroundColor = UIColor.borad
    }
    
    var collectioniew : UICollectionView!

    let orderTime = UILabel().then{
        $0.text = "下单时间:2021-09-01 10:23:44"
        $0.textColor = UIColor.twoText
        $0.font = MYFont(size: 12)
    }
    
    let preLabel = UILabel().then{
        $0.text = "合计"
        $0.textColor = UIColor.twoText
        $0.font = MYFont(size: 12)
    }
    
    let moneyLabel = UILabel().then{
        $0.text = "￥520.00"
        $0.textColor = UIColor.text
    }
    
    let selectView = CLMyOrderStatusSelectView()

    func attributedString(string:String,font: UIFont, textColor: UIColor, lineSpaceing: CGFloat, wordSpaceing: CGFloat) -> NSAttributedString {
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = lineSpaceing
        let attributes = [
                NSAttributedString.Key.font             : font,
                NSAttributedString.Key.foregroundColor  : textColor,
                NSAttributedString.Key.paragraphStyle   : style,
                NSAttributedString.Key.kern             : wordSpaceing]
            
            as [NSAttributedString.Key : Any]
        let attrStr = NSMutableAttributedString.init(string:string, attributes: attributes)
        
        attrStr.addAttribute(NSAttributedString.Key.font, value: MYFont(size: 16), range: NSMakeRange(1, string.count - 1))

        return attrStr
    }
    
    @objc private func countDownNotification() {
        
        // 判断是否需要倒计时 -- 可能有的cell不需要倒计时,根据真实需求来进行判断
        guard let str = source else { return }

        // 计算倒计时
        let timeInterval: Int
        timeInterval = CLCountDownManager.sharedManager.timeIntervalWithIdentifier(identifier:str)
        let countDown = 180 - timeInterval
        // 当倒计时到了进行回调
        if (countDown <= 0) {
            self.statusLabel.text = "活动开始"
            guard let action = countDownZero else { return }
            action()
            // 回调给控制器
        }else{
            // 重新赋值
            self.statusLabel.text = String(format: "待支付,剩余%d分%d秒",(countDown/60)%60, countDown%60)
        }

    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func configUI() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.countDownNotification), name: .CLCountDownNotification, object: nil)
        
        contentView.backgroundColor = UIColor.lightBackground
        contentView.addSubview(baseView)
        baseView.addSubviews(views: [label,shopName,statusLabel,line,orderTime,preLabel,moneyLabel,selectView])

        moneyLabel.attributedText = self.attributedString(string: "￥28.5", font: MYBlodFont(size: 12), textColor: .text, lineSpaceing: 0, wordSpaceing: 0)
        
        let layout = UICollectionViewFlowLayout.init()
        layout.itemSize = CGSize(width: 95, height: 104)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0.0
        layout.minimumInteritemSpacing = 0.0
        
        collectioniew = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        collectioniew.register(CLMyOrderCollectViewCell.self, forCellWithReuseIdentifier: "CLMyOrderCollectViewCell")

        collectioniew.contentSize = CGSize(width: screenWidth - 25, height: 104)
//        collectioniew.showsVerticalScrollIndicator = false
        collectioniew.showsHorizontalScrollIndicator = false
//        collectioniew.isScrollEnabled = true
//        collectioniew.isPagingEnabled = true
        collectioniew.backgroundColor = .white
        baseView.addSubview(collectioniew)

        collectioniew.collectionViewLayout = layout
        collectioniew.delegate = self
        collectioniew.dataSource = self
        
        baseView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
        }
        
        label.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(12)
            make.width.equalTo(30)
            make.height.equalTo(15)
        }
        
        shopName.snp.makeConstraints { make in
            make.left.equalTo(label.snp.right).offset(5)
            make.centerY.equalTo(label.snp.centerY)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.centerY.equalTo(shopName.snp.centerY)
        }
        
        line.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(label.snp.bottom).offset(10)
            make.height.equalTo(1)
        }
        
        collectioniew.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(line.snp.bottom)
            make.height.equalTo(104)
        }
        
        orderTime.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalTo(collectioniew.snp.bottom)
        }
        
        moneyLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.centerY.equalTo(orderTime.snp.centerY)
        }
        
        preLabel.snp.makeConstraints { make in
            make.right.equalTo(moneyLabel.snp.left).offset(-10)
            make.centerY.equalTo(moneyLabel.snp.centerY)
        }
        
        selectView.snp.makeConstraints { make in
            make.top.equalTo(orderTime.snp.bottom).offset(13)
            make.right.equalToSuperview().offset(-10)
            make.left.equalToSuperview().offset(10)
            make.height.equalTo(32)
        }
        
    }
}
extension CLMyOrderCell:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    //MARK: --UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return  7
        return  goodModel.count

    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CLMyOrderCollectViewCell", for: indexPath) as! CLMyOrderCollectViewCell
        cell.name.text = goodModel[indexPath.item].goodsName
        cell.image.xs_setImage(urlString: goodModel[indexPath.item].topPic)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
}

