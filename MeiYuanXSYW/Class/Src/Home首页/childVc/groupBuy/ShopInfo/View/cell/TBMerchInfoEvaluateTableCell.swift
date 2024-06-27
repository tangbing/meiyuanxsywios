//
//  TBMerchInfoEvaluateTableCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/1.
//

import UIKit


class TBMerchInfoEvaluateRepeatView: UIView {
    
   
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.hex(hexString: "#FCFCFC")
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        
      
       
    
    }
    
}

class TBMerchInfoEvaluateShopInfoView: UIView {
    
    lazy var shopIcon: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "picture14")
        return imgView
    }()
    
    lazy var evaluateMerchName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "商品名称限制1行，超出部分用…显示"
        label.font = MYFont(size: 12)
        label.textColor = .text
        return label
    }()
    
    lazy var evaluateCurrPrice: UILabel = {
        let time = UILabel()
        time.text = "¥28.5"
        time.font = MYBlodFont(size: 14)
        time.textColor = UIColor.hex(hexString: "#E6krepeatMargin16")
        return time
    }()
    
    lazy var evaluateoldPrice: UILabel = {
        let label = UILabel()
        label.text = "¥1krepeatMargin"
        label.font = MYFont(size: krepeatMargin)
        label.textColor = UIColor.hex(hexString: "#B3B3B3")
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.hex(hexString: "#FCFCFC")
        
        setupLayout()
    }
    
    func configData(goodsModel: EvaluationGoods) {
        
        shopIcon.image = UIImage(named: goodsModel.goodsPic)
        
        evaluateMerchName.text = goodsModel.goodsName
        
        evaluateCurrPrice.text = "¥\(goodsModel.finalPrice)"
        evaluateCurrPrice.sizeToFit()

        
        evaluateoldPrice.text = "¥\(goodsModel.originalPrice)"
        evaluateoldPrice.sizeToFit()

    }
    
    func configData(goodsModel: OrderCommentGoodsVOList) {
        
        shopIcon.image = UIImage(named: goodsModel.topPic)
        
        evaluateMerchName.text = goodsModel.goodsName
        
        evaluateCurrPrice.text = "¥\(goodsModel.finalPrice)"
        evaluateCurrPrice.sizeToFit()

        
        evaluateoldPrice.text = "¥\(goodsModel.originalPrice)"
        evaluateoldPrice.sizeToFit()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        shopIcon.frame = CGRect(x: 5, y: 4, width: 30, height: 28)

        evaluateMerchName.frame = CGRect(x: shopIcon.tb_maxX + 5, y: shopIcon.tb_y, width: 300, height: 12)

        evaluateCurrPrice.frame = CGRect(x: shopIcon.tb_maxX + 5, y: evaluateMerchName.tb_maxY + 4, width: 40, height: 16)
        
        evaluateoldPrice.tb_x = evaluateCurrPrice.tb_maxX + 5
        evaluateoldPrice.tb_centerY = evaluateCurrPrice.tb_centerY

    }
    
    func setupLayout() {
        self.addSubview(shopIcon)

        
        self.addSubview(evaluateMerchName)

        
        self.addSubview(evaluateCurrPrice)
        
      
        self.addSubview(evaluateoldPrice)
       
        
    }
    
}

class TBMerchInfoEvaluateTableCell: XSBaseTableViewCell {
    
    var repeatModel: TBRepeatModel?
    var _cellHgieht: CGFloat = 0.0
    

    let imageContainer: UIView = UIView()

    
    lazy var evaluateMerchIcon: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imageView?.hg_setAllCornerWithCornerRadius(radius: 17.5)
        imgView.image = UIImage(named: "placheholder_300x300px")
        return imgView
    }()
    
    lazy var evaluateMerchName: UILabel = {
        let label = UILabel()
        label.text = "老李家的亲戚"
        label.font = MYFont(size: 14)
        label.textColor = .text
        return label
    }()
    
    lazy var evaluateTime: UILabel = {
        let time = UILabel()
        time.textAlignment = .right
        time.text = "2021-6-9"
        time.font = MYFont(size: 12)
        time.textColor = UIColor.hex(hexString: "#979797")
        return time
    }()
    
    lazy var startScore: TBStartView = {
        return TBStartView()
    }()
    
    lazy var scoreLabel: UILabel = {
        let label = UILabel()
        label.text = "口味 4.8 环境 4.8 服务 4.8"
        label.font = MYFont(size: 12)
        label.textColor = .twoText
        return label
    }()
    
    
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "非常有格调的小众英伦香氛的味道，威廉梨和小苍兰的结合，与众不同之处就在于它既有梨子酒的清香和威廉梨和小苍兰的结合与众梨子酒的清香......"
        label.font = MYFont(size: 13)
        label.textColor = .text
        return label
    }()
    
    lazy var infoView: TBMerchInfoEvaluateShopInfoView = {
        return TBMerchInfoEvaluateShopInfoView()
    }()
    
    lazy var repeatTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "商家回复（2天后）"
        label.font = MYFont(size: 12)
        label.textColor = .text
        return label
    }()
    
    lazy var repeatContentTitle: UILabel = {
        let content = UILabel()
        content.font = MYBlodFont(size: 12)
        content.numberOfLines = 0
        content.textColor = UIColor.hex(hexString: "#737373")
        return content
    }()
    
   
    lazy var backView: UIView = {
        let iv = UIView()
        iv.backgroundColor = .white
        return iv
    }()
    
    override func configUI() {
        
        self.contentView.backgroundColor = .background
        
        self.contentView.addSubview(backView)
        backView.frame = CGRect(x: krepeatMargin, y: 0, width: screenWidth - 2 * krepeatMargin , height: 0)
        
        backView.addSubview(evaluateMerchIcon)

        backView.addSubview(evaluateMerchName)
       

        backView.addSubview(startScore)
        
        
        backView.addSubview(scoreLabel)
      
        backView.addSubview(evaluateTime)
        
        backView.addSubview(contentLabel)
      
        
        backView.addSubview(infoView)
       // infoView.frame = CGRect(x: krepeatMargin, y: _cellHgieht + 12, width:repeat_width , height: krepeat_infoH)

    }
    
    func configureTopView(evaluatModel:  EvaluationDetail) {
        
        
        evaluateMerchIcon.xs_setImage(urlString: evaluatModel.headImg)
        evaluateMerchIcon.frame = CGRect(x: krepeatMargin, y: 15, width: 35, height: 35)

        evaluateMerchName.tb_x = evaluateMerchIcon.tb_maxX + 5
        evaluateMerchName.tb_y = krepeatMargin
        evaluateMerchName.text = evaluatModel.userName
        evaluateMerchName.sizeToFit()
        
        evaluateTime.frame = CGRect(x: backView.tb_width - 10 - 80, y: 0, width: 80, height: 18)
        evaluateTime.tb_centerY = evaluateMerchName.tb_centerY
        evaluateTime.text = evaluatModel.userCommentDate
        

        startScore.startView(score: evaluatModel.totalComment.doubleValue)
        startScore.frame = CGRect(x: evaluateMerchName.tb_x, y: evaluateMerchName.tb_maxY + 2, width: 80, height: 15)

        let scoreItems = evaluatModel.totalScoreItems.map {
            $0.scoreName + " " + "\($0.scoreNum)"
        }
        
        scoreLabel.text = scoreItems.joined(separator: " ")
        scoreLabel.sizeToFit()
        scoreLabel.tb_x = startScore.tb_right + 4
        scoreLabel.tb_centerY = startScore.tb_centerY
        
        
        contentLabel.text = evaluatModel.userComment
        let content_x = evaluateMerchIcon.tb_x
        let content_y = evaluateMerchIcon.tb_maxY + krepeatMargin
        contentLabel.frame = CGRect(x: content_x, y: content_y, width: repeatContent_width, height: evaluatModel.userCommentH)
        
        repeatTitle.text = "商家回复（\(evaluatModel.merchantReplyComment ?? "")）"
        
        _cellHgieht += contentLabel.tb_maxY
        
    }
    
    func configureTopView(evaluatModel : OrderCommentModel) {
        
        evaluateMerchIcon.xs_setImage(urlString: evaluatModel.headImg)
        evaluateMerchIcon.frame = CGRect(x: krepeatMargin, y: 15, width: 35, height: 35)

        evaluateMerchName.tb_x = evaluateMerchIcon.tb_maxX + 5
        evaluateMerchName.tb_y = krepeatMargin
        evaluateMerchName.text = evaluatModel.userName
        evaluateMerchName.sizeToFit()
        
        evaluateTime.frame = CGRect(x: backView.tb_width - 10 - 80, y: 0, width: 80, height: 18)
        evaluateTime.tb_centerY = evaluateMerchName.tb_centerY
        evaluateTime.text = evaluatModel.userCommentDate
        

        startScore.startView(score: evaluatModel.totalComment.doubleValue)
        startScore.frame = CGRect(x: evaluateMerchName.tb_x, y: evaluateMerchName.tb_maxY + 2, width: 80, height: 15)

        // 外卖，口味，包装
        var scoreLabelText = ""
        if evaluatModel.bizType == 0 {
            scoreLabelText = "口味 \(evaluatModel.tasteComment)" + " " + "包装 \(evaluatModel.packComment)"
        } else if(evaluatModel.bizType == 1){ // 到店， 口味，环境，服务
            scoreLabelText = "口味 \(evaluatModel.tasteComment)" + " " +
            "环境 \(evaluatModel.environmentComment)" + " " + "服务 \(evaluatModel.serviceComment)"
        }

        
        scoreLabel.text = scoreLabelText
        
        scoreLabel.sizeToFit()
        scoreLabel.tb_x = startScore.tb_right + 4
        scoreLabel.tb_centerY = startScore.tb_centerY
        
        
        contentLabel.text = evaluatModel.userComment
        let content_x = evaluateMerchIcon.tb_x
        let content_y = evaluateMerchIcon.tb_maxY + krepeatMargin
        contentLabel.frame = CGRect(x: content_x, y: content_y, width: repeatContent_width, height: evaluatModel.userCommentH)
        
        repeatTitle.text = "商家回复（\(evaluatModel.merchantReplyComment ?? "")）"
        
        _cellHgieht += contentLabel.tb_maxY
        
    }
    
    func configurePics(evaluatModel:  EvaluationDetail) {
        let margin: CGFloat = 5
        let totalColumns = 3
        let itemWidth: CGFloat = (repeat_width - CGFloat((totalColumns - 1)) * margin) / 3
        imageContainer.clearAll()

        backView.addSubview(imageContainer)
        
        var imageView: UIImageView?
        
        for (idx, pic) in evaluatModel.commentPicStr!.enumerated() {
            imageView = UIImageView()
            imageView?.xs_setImage(urlString: pic)
            imageView?.hg_setAllCornerWithCornerRadius(radius: 5)
//            let img = UIImage(named: pic)!
//            imageView!.image = img.jk.isRoundCorner(radius: 5, imageSize: CGSize(width: itemWidth, height: itemWidth))
            let row = idx / totalColumns
            let col = idx % totalColumns
            let cellX = CGFloat(col) * (itemWidth + margin)
            let cellY = CGFloat(row) * (itemWidth + margin)
            imageView!.frame = CGRect(x: cellX, y: cellY, width: itemWidth, height: itemWidth)
            imageContainer.addSubview(imageView!)
            //imageContainer.backgroundColor = .white
        }
        _cellHgieht += 7

        if let imgView = imageView {
            imageContainer.frame = CGRect(x: krepeatMargin, y: _cellHgieht , width: repeat_width, height: imgView.tb_maxY)
            _cellHgieht += imageContainer.tb_height
        }
      
        
    }
    
    func configurePics(evaluatModel : OrderCommentModel) {
        let margin: CGFloat = 5
        let totalColumns = 3
        let itemWidth: CGFloat = (repeat_width - CGFloat((totalColumns - 1)) * margin) / 3
        imageContainer.clearAll()

        backView.addSubview(imageContainer)
        
        var imageView: UIImageView?
        
        for (idx, pic) in evaluatModel.commentPicStr!.enumerated() {
            imageView = UIImageView()
            imageView?.xs_setImage(urlString: pic)
            imageView?.hg_setAllCornerWithCornerRadius(radius: 5)
//            let img = UIImage(named: pic)!
//            imageView!.image = img.jk.isRoundCorner(radius: 5, imageSize: CGSize(width: itemWidth, height: itemWidth))
            let row = idx / totalColumns
            let col = idx % totalColumns
            let cellX = CGFloat(col) * (itemWidth + margin)
            let cellY = CGFloat(row) * (itemWidth + margin)
            imageView!.frame = CGRect(x: cellX, y: cellY, width: itemWidth, height: itemWidth)
            imageContainer.addSubview(imageView!)
            //imageContainer.backgroundColor = .white
        }
        _cellHgieht += 7

        if let img = imageView {
            imageContainer.frame = CGRect(x: krepeatMargin, y: _cellHgieht , width: repeat_width, height: img.tb_maxY)
            _cellHgieht += imageContainer.tb_height
        }
      
        
    }
    
    func configureRepeat(evaluate:  EvaluationDetail) {
        _cellHgieht += 2 * krepeatMargin

        backView.addSubview(repeatTitle)
        repeatTitle.frame = CGRect(x: krepeatMargin, y: _cellHgieht, width: repeat_width, height: 18)
        _cellHgieht += 28

        backView.addSubview(repeatContentTitle)
        repeatContentTitle.text = evaluate.merchantReplyComment
        _cellHgieht += 5

        repeatContentTitle.frame = CGRect(x: krepeatMargin, y: repeatTitle.tb_maxY + 5, width: repeat_width, height: evaluate.merchantReplyCommentH)
        _cellHgieht += evaluate.merchantReplyCommentH

    }
    
    func configureRepeat(evaluate:  OrderCommentModel) {
        _cellHgieht += 2 * krepeatMargin

        backView.addSubview(repeatTitle)
        repeatTitle.frame = CGRect(x: krepeatMargin, y: _cellHgieht, width: repeat_width, height: 18)
        _cellHgieht += 28

        backView.addSubview(repeatContentTitle)
        repeatContentTitle.text = evaluate.merchantReplyComment
        _cellHgieht += 5

        repeatContentTitle.frame = CGRect(x: krepeatMargin, y: repeatTitle.tb_maxY + 5, width: repeat_width, height: evaluate.merchantReplyCommentH)
        _cellHgieht += evaluate.merchantReplyCommentH

    }
    
    func bindWithData(repeatModel: TBRepeatModel) {
        
        guard let evalutateModel = repeatModel.commentModel else { return }
         
         _cellHgieht = 0
                 
        configureTopView(evaluatModel: evalutateModel)
         
         /// 设置底部圆角
         if repeatModel.bottomRadius > 0.0 {
             backView.hg_setCornerOnBottomWithRadius(radius: repeatModel.bottomRadius)
         }
         
         if evalutateModel.commentPicStr != nil {
             imageContainer.isHidden = false
             configurePics(evaluatModel: evalutateModel)
         } else {
             imageContainer.isHidden = true
         }
         
         
         if let goodsModel = evalutateModel.orderCommentGoodsVOList {
             _cellHgieht += krepeatMargin

             infoView.isHidden = false
             infoView.configData(goodsModel: goodsModel)
             infoView.frame = CGRect(x: krepeatMargin, y:_cellHgieht , width: repeat_width, height: krepeat_infoH)
             
             _cellHgieht += krepeat_infoH
         } else {
             infoView.isHidden = true
             infoView.frame = CGRect(x: krepeatMargin, y: _cellHgieht, width: repeat_width, height: 0)
         }
         
         if let _ = evalutateModel.merchantReplyComment {
             repeatTitle.isHidden = false
             repeatContentTitle.isHidden = false
             configureRepeat(evaluate: evalutateModel)
         } else {
             repeatTitle.isHidden = true
             repeatContentTitle.isHidden = true
         }
         
         _cellHgieht += 18

         
         backView.tb_height = _cellHgieht
    }
    
    func configureRepeatModel(repeatModel: TBRepeatModel) {
        
       guard let evalutateModel = repeatModel.evaluationModel else { return }
        
        _cellHgieht = 0
                
        configureTopView(evaluatModel: evalutateModel)
        
        /// 设置底部圆角
        if repeatModel.bottomRadius > 0.0 {
            backView.hg_setCornerOnBottomWithRadius(radius: repeatModel.bottomRadius)
        }
        
        if  evalutateModel.commentPicStr != nil {
            imageContainer.isHidden = false
            configurePics(evaluatModel: evalutateModel)
        } else {
            imageContainer.isHidden = true
        }
        
        
        if let goodsModel = evalutateModel.evaluationGoods {
            _cellHgieht += krepeatMargin

            infoView.isHidden = false
            infoView.configData(goodsModel: goodsModel)
            infoView.frame = CGRect(x: krepeatMargin, y:_cellHgieht , width: repeat_width, height: krepeat_infoH)
            
            _cellHgieht += krepeat_infoH
        } else {
            infoView.isHidden = true
            infoView.frame = CGRect(x: krepeatMargin, y: _cellHgieht, width: repeat_width, height: 0)
        }
        
        if let _ = evalutateModel.merchantReplyComment {
            repeatTitle.isHidden = false
            repeatContentTitle.isHidden = false
            configureRepeat(evaluate: evalutateModel)
        } else {
            repeatTitle.isHidden = true
            repeatContentTitle.isHidden = true
        }
        
        _cellHgieht += 18

        
        backView.tb_height = _cellHgieht
    }
}


