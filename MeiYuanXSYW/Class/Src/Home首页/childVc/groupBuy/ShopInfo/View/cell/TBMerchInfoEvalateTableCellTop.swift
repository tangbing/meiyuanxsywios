//
//  TBMerchInfoEvalateTableCellTop.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/1.
//

import UIKit

class TBStackView: UIStackView {

    
    convenience init(topText: String, bottomText: String) {
        self.init(frame: .zero)
        configData(topText: topText, bottomText: bottomText)
    }
    
     func configData(topText: String, bottomText: String){
        topLabel.text = topText
        bottomLabel.text = bottomText
    }
    
    func configBottomData(bottomText: String){
        bottomLabel.text = bottomText
    }
    
    lazy var topLabel: UILabel = {
        let top = UILabel()
        top.textAlignment = .center
        top.textColor = .twoText
        top.font = MYFont(size: 12)
        return top
    }()
    
    lazy var bottomLabel: UILabel = {
        let bottom = UILabel()
        bottom.textAlignment = .center
        bottom.textColor = .text
        bottom.font = MYBlodFont(size: 14)
        return bottom
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        axis = .vertical
        alignment = .fill
        distribution = .fillProportionally
        spacing = 5
        addArrangedSubview(topLabel)
        addArrangedSubview(bottomLabel)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class TBMerchInfoEvalateTableCellTop: XSBaseTableViewCell {
    
    var detailModel: TBRepeatTotalModel? {
        didSet {
            guard let model = detailModel?.evaluationDetails else { return }
            
            var scrore = "\(model.totalComment)"
            if model.totalComment.doubleValue == 0.0 {
                scrore = "暂无评分"
                scoreLabel.textColor = .text
                scoreLabel.font = MYBlodFont(size: 16)
                //bgContainer.hg_setAllCornerWithCornerRadius(radius: 10)
            }
            
            scoreLabel.text = scrore
            
            startScore.startView(score: model.totalComment.doubleValue)
            
            setScoreItems(scoreItems: model.totalScoreItems)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                if self.detailModel?.hasTopRadius ?? false {
                    self.bgContainer.jk.addCorner(conrners: [UIRectCorner.topLeft, UIRectCorner.topRight], radius: 10)
                }
                
            }
            
            if detailModel?.hasBottomRadus ?? false {
                bgContainer.hg_setCornerOnBottomWithRadius(radius: 10)
            }
            
        }
    }
    
    var lastEvaluate: TBStackView?
    
    lazy var bgContainer: UIView = {
        let iv = UIView()
        iv.hg_setCornerOnTopWithRadius(radius: 10)
        iv.backgroundColor = .white
        return iv
    }()

    lazy var startScore: TBStartView = {
        return TBStartView(frame: .zero, score: 0.0)
    }()
    
    lazy var scoreLabel: UILabel = {
        let score = UILabel()
        score.text = "暂无评价"
        score.textColor = UIColor.hex(hexString: "#FF6E02")
        score.font = MYBlodFont(size: 25)
        return score
    }()
    
    override func configUI() {
        self.contentView.backgroundColor = .background
        
        self.contentView.addSubview(bgContainer)
        bgContainer.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(0)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview()
        }
        
        bgContainer.addSubview(scoreLabel)
        scoreLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(12)
            
        }
        
        bgContainer.addSubview(startScore)
        startScore.snp.makeConstraints { make in
            make.left.equalTo(scoreLabel.snp_right).offset(5)
            make.bottom.equalTo(scoreLabel.snp_bottom).offset(-10)
            make.width.equalTo(50)
        }
    }
    
    func setScoreItems(scoreItems: [TBtotalScoreItem]) {
        
        for scoreItem in scoreItems {
            let smell = TBStackView(topText: scoreItem.scoreName, bottomText: "\(scoreItem.scoreNum.doubleValue)")
            bgContainer.addSubview(smell)
            smell.snp.makeConstraints { make in
                if lastEvaluate != nil {
                    make.left.equalTo(lastEvaluate!.snp_right).offset(24)
                } else {
                    make.left.equalTo(startScore.snp_right).offset(60)
                }
                make.top.equalToSuperview().offset(10)
                make.bottom.equalToSuperview()
                make.width.equalTo(34)
            }
           
            lastEvaluate = smell
        }
        
    }
    
    
}
