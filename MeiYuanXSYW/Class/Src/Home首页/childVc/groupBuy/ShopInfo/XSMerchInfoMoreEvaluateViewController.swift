//
//  XSMerchInfoMoreEvaluateViewController.swift
//  MeiYuanXSYW
//
//  Created by admin on 2022/1/7.
//

import UIKit
import HMSegmentedControl

struct SegMentModel {
    var mentTitle: String
    var mentBadge: Int
    
    func totalResult() -> String {
        if mentBadge > 0 {
            return "\(mentTitle)(\(mentBadge))"
        } else {
            return mentTitle
        }
    }
    
}

class XSMerchInfoMoreEvaluateViewController: XSBaseViewController {


//    var segMentTitles = [SegMentModel"全部","晒图","获得回复","最新"] {
//        didSet {
//
//        }
//    }
    
    var homeStyle: TBHomeStyle = .delivery
    var merchantId: String = ""
    
    private var moreEvaluates: [TBMerchInfoViewModel] = [TBMerchInfoViewModel]()

    
    lazy var segment: HMSegmentedControl = {
        let segment = HMSegmentedControl(sectionTitles: ["全部","晒图","低分","最新"])
        segment.type = .text
        segment.backgroundColor = .white
        segment.selectionIndicatorHeight = 1.0
        segment.selectionIndicatorLocation = .bottom
        
        segment.selectedTitleTextAttributes = [ NSAttributedString.Key.foregroundColor : UIColor.hex(hexString: "#DDA877"), NSAttributedString.Key.font : MYFont(size: 14)]
        segment.titleTextAttributes = [ NSAttributedString.Key.foregroundColor : UIColor.hex(hexString: "#737373"), NSAttributedString.Key.font : MYFont(size: 14)]
        
        //segment.selectionIndicatorMaxWidth = 24
        segment.selectionIndicatorColor = UIColor.hex(hexString: "#DDA877")
        
        //segment.frame = CGRect(x:0 , y: 0, width: Int(screenWidth), height: 44)
        segment.addTarget(self, action: #selector(segmentValueChanged(segment:)), for: .valueChanged)
        return segment
    }()
    
    lazy var tableView : UITableView = {
        let tableV = UITableView.init(frame: CGRect.zero)
        tableV.backgroundColor = .clear
        tableV.tableFooterView = UIView(frame: CGRect.zero)
        tableV.separatorStyle = .none
        tableV.register(cellType: TBMerchInfoEvalateTableCellTop.self)
        tableV.register(cellType: TBMerchInfoEvaluateTableCell.self)

        tableV.dataSource = self
        tableV.delegate = self
        tableV.showsVerticalScrollIndicator = false
        return tableV;
    }()
    
    init(merchantId: String) {
        self.merchantId = merchantId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupNavigationItems() {
        super.setupNavigationItems()
        navigationTitle = "商品评价"
    }
    
    override func initSubviews() {
        super.initSubviews()
        
        view.addSubview(segment)
        segment.snp.makeConstraints {
            $0.left.right.top.equalToSuperview()
            $0.height.equalTo(44)
        }
        
        view.addSubview(tableView)
        tableView.register(cellType: XSMineEvaluateTableViewCell.self)
        tableView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(0)
            $0.right.equalToSuperview().offset(0)
            $0.top.equalTo(segment.snp_bottom)
            $0.bottom.equalTo(self.view.usnp.bottom)
        }

    }
    
    func initData(page: Int, bizType: Int, commentType: Int) {
        // bizType  业务类型.0，外卖，1 团购，2私厨,3聚合（商家C端传入）
        // 全部评价0，晒图1,2获得回复.3低分，4最新。（012是我的评价，0134是商家评价）,（用户C端传入）
        MerchantInfoProvider.request(.getMerchantCommentPageResult(merchantId, page: page, pageSize: 10, bizType: bizType, commentType: commentType), model: TBMerchantCommentModel.self) { [weak self] returnData in
            
            guard let model = returnData,
                 model.code == 0 else {
                return
            }
            
            self?.moreEvaluates.removeAll()
            

            
            let topModel = TBRepeatTotalModel(totalScoreItems: model.totalScoreItems, commentScore: model.commentScore, hasTopRadius: true, hasBottomRadius: true)
            
            
            let topViewModel = TBMerchInfoViewModel(cellViewModels: [topModel])
            self?.moreEvaluates.append(topViewModel)
            
            
            guard let commentModels = model.data else {
                return
            }
            
//            var all = SegMentModel(mentTitle: "全部", mentBadge: model.allCount)
//            var pic = SegMentModel(mentTitle: "晒图", mentBadge: model.picAccount)
//            var low = SegMentModel(mentTitle: "低分", mentBadge: model.lowCount)
//            var new = SegMentModel(mentTitle: "最新", mentBadge: model.newCount)

           let segmentTitlesArray = [SegMentModel(mentTitle: "全部", mentBadge: model.allCount),
             SegMentModel(mentTitle: "晒图", mentBadge: model.picCount),
             SegMentModel(mentTitle: "低分", mentBadge: model.lowCount),
             SegMentModel(mentTitle: "最新", mentBadge: model.newCount)
            ]
            
            let titles = segmentTitlesArray.map({ segmentModel -> String in
               return segmentModel.totalResult()
            })
            
            self?.segment.sectionTitles = titles

            
            let evaluateVm = TBMerchInfoViewModel()

            for (index,commentModel) in commentModels.enumerated() {
                
                let bottomRadius: CGFloat = (index == commentModels.count - 1) ? 10.0 : 0.0
                
                let mod = TBRepeatModel(commentModel: commentModel, botttomRadius: bottomRadius)
                evaluateVm.cellViewModels.append(mod)

            }
            
            self?.moreEvaluates.append(evaluateVm)

            self?.tableView.reloadData()
            
            
        } errorResult: { errorMsg in
            uLog(errorMsg)
            XSTipsHUD.showText(errorMsg)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initData(page: 1, bizType: 1, commentType: 0)
    }
    
    @objc func segmentValueChanged(segment: HMSegmentedControl){
        var commentType = 0
        if(segment.selectedSegmentIndex == 1) {
            commentType = 1
        } else if(segment.selectedSegmentIndex == 2) {
            commentType = 2
        } else if(segment.selectedSegmentIndex == 3) {
            commentType = 4
        }
        
        initData(page: 1, bizType: 1, commentType: commentType)
    }
    
}

extension XSMerchInfoMoreEvaluateViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return moreEvaluates.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionModel = moreEvaluates[section]
     
        return sectionModel.cellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sectionModel = moreEvaluates[indexPath.section]
        let rowModel = sectionModel.cellViewModels[indexPath.row]
        
        return rowModel.rowCommentHeight
    }

    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let iv = UIView()
        iv.backgroundColor = UIColor.background
        return iv
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let iv = UIView()
        iv.backgroundColor = .red
        return iv
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let sectionModel = moreEvaluates[indexPath.section]
        let rowModel = sectionModel.cellViewModels[indexPath.row]
        
        switch rowModel.style {
        case .evalutateTop:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TBMerchInfoEvalateTableCellTop.self)
            let topModel = rowModel as! TBRepeatTotalModel

            
            cell.scoreLabel.text = "\(topModel.commentScore)"
            cell.startScore.startView(score: topModel.commentScore.doubleValue)
            if let scoreItems = topModel.totalScoreItems {
                cell.setScoreItems(scoreItems: scoreItems)
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                if topModel.hasTopRadius {
                    cell.bgContainer.jk.addCorner(conrners: [UIRectCorner.topLeft, UIRectCorner.topRight], radius: 10)
                }
                
            }
            
            if topModel.hasBottomRadus {
                cell.bgContainer.hg_setCornerOnBottomWithRadius(radius: 10)
            }
            
            return cell
                                  
        default:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TBMerchInfoEvaluateTableCell.self)
            cell.bindWithData(repeatModel: rowModel as! TBRepeatModel)
        return cell
        }
    }
    
}
