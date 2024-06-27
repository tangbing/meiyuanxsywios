//
//  XSDiscoverSectionViewModel.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/12/2.
//

import UIKit


class XSDiscoverSectionViewModel: NSObject {
    let sectionTitles = ["吃货研究所","吃货推荐"]

    public var sectionHeaderTitle: String?
    var sections = [XSDiscoverSectionViewModel]()

    public var cellViewModels: [XSDiscoverModelProtocol] = [XSDiscoverModelProtocol]()

    init(cellViewModels: [XSDiscoverModelProtocol]) {
        self.cellViewModels = cellViewModels
        super.init()
    }

    override init() {
        super.init()
    }

    func fetchData(){
        sections.removeAll()
        
        let top1 = XSDiscoverStudySpaceModel()
        let vm = XSDiscoverSectionViewModel(cellViewModels: [top1])
        vm.sectionHeaderTitle = sectionTitles[0]
        sections.append(vm)
        
        let recommand1 = XSDiscoverRecomandModel(content: "非常有格调的小众英伦香氛的味道，威廉梨和非常有格调的小众英伦香氛的味道，威廉梨和非常有格调的小众英伦香氛的味道，威廉梨和非常有格调的小众英伦香氛的味道，威廉梨和", pics: nil)
        let recommand2 = XSDiscoverRecomandModel(content: "非常有格调的小众英伦香氛的味道，威廉梨和", pics: ["picture12"])
        let recommand3 = XSDiscoverRecomandModel(content: "非常有格调的小众英伦香氛的味道，威廉梨和", pics: ["picture12","picture12"])
        let recommand4 = XSDiscoverRecomandModel(content: "非常有格调的小众英伦香氛的味道，威廉梨和", pics: ["picture12","picture12","picture12"])
        
        let recommand5 = XSDiscoverRecomandModel(content: "非常有格调的小众英伦香氛的味道，威廉梨和", pics: ["picture12","picture12","picture12","picture12"])
        
        let recommand6 = XSDiscoverRecomandModel(content: "非常有格调的小众英伦香氛的味道，威廉梨和", pics: ["picture12","picture12","picture12","picture12","picture12","picture12"])
        let recommand7 = XSDiscoverRecomandModel(content: "非常有格调的小众英伦香氛的味道，威廉梨和", pics: ["picture12","picture12","picture12","picture12","picture12","picture12","picture12","picture12","picture12"])
        
        let vm1 = XSDiscoverSectionViewModel(cellViewModels: [recommand1,recommand2,recommand3,recommand4,recommand4,recommand5,recommand6,recommand7])
        sections.append(vm1)
        
        

    }
    
}


