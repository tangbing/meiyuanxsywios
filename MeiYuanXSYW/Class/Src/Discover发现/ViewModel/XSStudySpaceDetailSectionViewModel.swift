//
//  XSStudySpaceDetailSectionViewModel.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/12/6.
//

import UIKit


class XSStudySpaceDetailSectionViewModel: NSObject {

    public var sectionHeaderTitle: String?
    var sections = [XSStudySpaceDetailSectionViewModel]()

    public var cellViewModels: [XSStudySpaceDetailProtocol] = [XSStudySpaceDetailProtocol]()

    init(cellViewModels: [XSStudySpaceDetailProtocol]) {
        self.cellViewModels = cellViewModels
        super.init()
    }

    override init() {
        super.init()
    }

    func fetchData(){
        sections.removeAll()
        
//        [studySapceDetailStyle.info],
//
//        [
//        studySapceDetailStyle.content,
//        studySapceDetailStyle.wait,
//        studySapceDetailStyle.merchInfo,
//        studySapceDetailStyle.info,
//        studySapceDetailStyle.content,
//        studySapceDetailStyle.wait,
//        studySapceDetailStyle.merchInfo,
//        studySapceDetailStyle.info,
//        studySapceDetailStyle.content,
//        studySapceDetailStyle.wait,
//        studySapceDetailStyle.merchInfo]
        
        let top1 = XSStudySpaceInfoModel(hasTopRadius: true, hasBottomRadius: false)
        let vm = XSStudySpaceDetailSectionViewModel(cellViewModels: [top1])
        sections.append(vm)
        
        let text = XSStudySpaceContentModel()
        let wait = XSStudySpaceWaitModel()
        let merchInfo = XSStudySpaceMerchInfoModel()
        
        let text1 = XSStudySpaceContentModel()
        let wait1 = XSStudySpaceWaitModel(hasTopRadius: false, hasBottomRadius: true)
        
        let vm1 = XSStudySpaceDetailSectionViewModel(cellViewModels: [text, wait, merchInfo, text1, wait1])
        sections.append(vm1)
        
        
        

        
        

    }
    
}



