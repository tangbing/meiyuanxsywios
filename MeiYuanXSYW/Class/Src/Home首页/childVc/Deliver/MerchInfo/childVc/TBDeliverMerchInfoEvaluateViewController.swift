//
//  TBDeliverMerchInfoEvaluateViewController.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/8.
//

import UIKit

class TBDeliverMerchInfoEvaluateViewController: TBBasePageScrollViewController {
    
    var sections = [TBMerchInfoModelProtocol]()
    
    var evaluateModel: TBMerchantCommentModel!

    
    lazy var evaluateTableView: UITableView = {
        let tableV = TBBaseTableView(frame: .zero, style: .plain)
        tableV.backgroundColor = .background
        tableV.tableFooterView = UIView(frame: CGRect.zero)
        //tableV.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0.1))
        tableV.separatorStyle = .none
        tableV.dataSource = self
        tableV.delegate = self
        tableV.register(cellType: TBMerchInfoEvalateTableCellTop.self)
        tableV.register(cellType: TBMerchInfoEvaluateTableCell.self)
        return tableV
    }()
    
    override func initSubviews() {
        super.initSubviews()
        self.view.addSubview(evaluateTableView)
        evaluateTableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
    }
    
    override func initData() {
        
        MerchantInfoProvider.request(.getMerchantCommentPageResult(merchantId, page: 1, pageSize: 10, bizType: 0, commentType: self.showHomeStyle.rawValue), model: TBMerchantCommentModel.self) { [weak self] returnData in
            
            guard let model = returnData,
                 model.code == 0 else {
                return
            }
            
            self?.evaluateModel = model
  
            self?.setupModelData(model: model)
            self?.evaluateTableView.reloadData()
            
            
        } errorResult: { errorMsg in
            uLog(errorMsg)
            XSTipsHUD.showText(errorMsg)
        }

        

        
    }
    
    func setupModelData(model: TBMerchantCommentModel) {
        
        let topModel = TBRepeatTotalModel(totalScoreItems: model.totalScoreItems, commentScore: model.commentScore, hasTopRadius: true)
//        topModel.totalScoreItems = model.totalScoreItems
//        topModel.commentScore = model.commentScore
        sections.append(topModel)

        
        guard let commentModels = model.data else {
            return
        }
        
        for (index,commentModel) in commentModels.enumerated() {
            
            let bottomRadius: CGFloat = (index == commentModels.count - 1) ? 10.0 : 0.0
            
            let mod = TBRepeatModel(commentModel: commentModel, botttomRadius: bottomRadius)
            
//            let mod = TBRepeatModel(shopIcon: commentModel.merchantLogo, shopName: commentModel.merchantName, shopTime: commentModel.userCommentDate, shopScore: commentModel.commentScore, evaluate: "口味 \(commentModel.tasteComment)  包装 \(commentModel.packComment)", commentContent: commentModel.userComment, repeatPics: commentModel.commentPicStr, shopInfo_curPrice: "¥28.5", shopInfo_oldPrice: "110", shopRepeat: commentModel.merchantReplyComment, shopRepeatDate: commentModel.merchantReplyDate, botttomRadius: bottomRadius)
            sections.append(mod)
            
        }
        
        /*
        let mod = TBRepeatModel(shopIcon: "details_avatar", shopName: "老李家的亲戚", shopTime: "2021-6-9", shopScore: 5.0, evaluate: "非常有格调的小众英伦香氛的味道", commentContent: "非常有格调的小众英伦香氛的味道，威廉梨和小苍兰的结合马克龙遭掌掴一事是法国在国际舞台上的“一个耻辱”遭到一名男子的掌掴。现场视频曝光后，在社交媒体上遭疯传，各国媒体也争相报道了此事。不少法国网民愤怒地表示马克龙遭掌掴一事是法国在国际舞台上的“一个耻辱”遭到一名男子的掌掴。现场视频曝光后，在社交媒体上遭疯传，各国媒体也争相报道了此事。不少法国网民愤怒地表示", repeatPics: ["picture12","picture12"], shopInfo_curPrice: "¥28.5", shopInfo_oldPrice: "110", shopRepeat: "遭到一名男子的掌掴。现场视频曝光后，在社交媒体上遭疯传，各国媒体也争相报道了此事。不少法国网民愤怒地表示，马克龙遭掌掴一事是法国在国际舞台上的“一个耻辱”")
       
        let mod1 = TBRepeatModel(shopIcon: "details_avatar", shopName: "老李家的亲戚", shopTime: "2021-6-9", shopScore: 5.0, evaluate: "非常有格调的小众英伦香氛的味道", commentContent: "非常有格调的小众英伦香氛的味道，威廉梨和小苍兰的结合", repeatPics: ["picture12","picture12","picture12","picture12","picture12","picture12","picture12","picture12","picture12"], shopInfo_curPrice: "¥28.5", shopInfo_oldPrice: "110", shopRepeat: "遭到一名男子的掌掴非常有格调的小众英伦香氛的味道，威廉梨和小苍兰的结合遭到一名男子的掌掴。现场视频曝光后，在社交媒体上遭疯传，各国媒体也争相报道了此事。不少法国网民愤怒地表示，马克龙遭掌掴一事是法国在国际舞台上的“一个耻辱”遭到一名男子的掌掴。现场视频曝光后，非常有格调的小众英伦香氛的味道，威廉梨和小苍兰的结合遭到一名男子的掌掴。现场视频曝光后，在社交媒体上遭疯传，各国媒体也争相报道了此事。不少法国网民愤怒地表示，马克龙遭掌掴一事是法国在国际舞台上的“一个耻辱”遭到一名男子的掌掴。现场视频曝光后，非常有格调的小众英伦香氛的味道，威廉梨和小苍兰的结合遭到一名男子的掌掴。现场视频曝光后，在社交媒体上遭疯传，各国媒体也争相报道了此事。不少法国网民愤怒地表示，马克龙遭掌掴一事是法国在国际舞台上的“一个耻辱”遭到一名男子的掌掴。现场视频曝光后，非常有格调的小众英伦香氛的味道，威廉梨和小苍兰的结合遭到一名男子的掌掴。现场视频曝光后，在社交媒体上遭疯传，各国媒体也争相报道了此事。不少法国网民愤怒地表示，马克龙遭掌掴一事是法国在国际舞台上的“一个耻辱”遭到一名男子的掌掴。现场视频曝光后，。")
       
        let mod2 = TBRepeatModel(shopIcon: "details_avatar", shopName: "老李家的亲戚", shopTime: "2021-6-9", shopScore: 5.0, evaluate: "非常有格调的小众英伦香氛的味道", commentContent: "非常有格调的", repeatPics: nil, shopInfo_curPrice: "¥28.5", shopInfo_oldPrice: "110", shopRepeat: "遭到一名男子的掌掴。")
        
       
       let mod3 = TBRepeatModel(shopIcon: "details_avatar", shopName: "老李家的亲戚", shopTime: "2021-6-9", shopScore: 5.0, evaluate: "非常有格调的小众英伦香氛的味道", commentContent: "非常有格调的小众英伦香氛的味道，威廉梨和小苍兰的结合遭到一名男子的掌掴。现场视频曝光后，在社交媒体上遭疯传，各国媒体也争相报道了此事。不少法国网民愤怒地表示，马克龙遭掌掴一事是法国在国际舞台上的“一个耻辱”遭到一名男子的掌掴。现场视频曝光后，在社交媒体上遭疯传，各国媒体也争相报道了此事。不少法国网民愤怒地表示，马克龙遭掌掴一事是法国在国际舞台上的“一个耻辱”", repeatPics: nil, shopInfo_curPrice: "¥28.5", shopInfo_oldPrice: "110", shopRepeat: nil, botttomRadius: 10.0)
         sections.append([topModel,mod, mod1, mod2, mod3])
        */
        
        
    }
    
    
    
     override func listScrollView() -> UIScrollView {
        return self.evaluateTableView
    }
    
    override func setContentInset(bottomInset: CGFloat){
         self.evaluateTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: bottomInset, right: 0)
     }
    
}

extension TBDeliverMerchInfoEvaluateViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionModel = sections[indexPath.row]
        
        switch sectionModel.style {
        case .evalutateTop:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TBMerchInfoEvalateTableCellTop.self)
            let topModel = sectionModel as! TBRepeatTotalModel
            
            cell.scoreLabel.text = "\(topModel.commentScore)"
            cell.startScore.startView(score: topModel.commentScore.doubleValue)
            if let scoreItems = topModel.totalScoreItems {
                cell.setScoreItems(scoreItems: scoreItems)
            }
            
            
            
            return cell
                                  
        default:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TBMerchInfoEvaluateTableCell.self)
            cell.bindWithData(repeatModel: sectionModel as! TBRepeatModel)
        return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = sections[indexPath.row]
        return model.rowHeight
    }
    
}
