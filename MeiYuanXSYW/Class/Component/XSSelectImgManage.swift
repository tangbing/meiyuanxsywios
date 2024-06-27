//
//  XSSelectImgManage.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/9/1.
//

import UIKit
import QMUIKit

/// 添加cell点击代理方法
protocol XSSelectImgManageDelegate:NSObjectProtocol {
    func XSSelectImgManageFinsh(images: [UIImage])
}

class XSSelectImgManage: NSObject{
    weak var delegate : XSSelectImgManageDelegate?
    
    enum XSSelectImgType {
        case XSSelectImgTypeDefault
        case XSSelectImgTypeAblum
        case XSSelectImgTypeCarmea
    }
    func showImagePicker(controller:UIViewController,soureType:XSSelectImgType,maxItemCount:Int) {
        if soureType == .XSSelectImgTypeDefault {
            let action1 = QMUIAlertAction(title: "取消", style: .cancel, handler: nil)
            let action2 = QMUIAlertAction(title: "拍照", style: .default) { alert, action in
                self.clickCamera(controller: controller)
            }
            let action3 = QMUIAlertAction(title: "从相册选择", style: .default) { alert, action in
                self.clickAblum(controller: controller,maxItemCount: maxItemCount)
            }
            let alert = QMUIAlertController(title: "请选择照片", message: "", preferredStyle:.actionSheet)
            alert.addAction(action1)
            alert.addAction(action2)
            alert.addAction(action3)
            alert.showWith(animated: true)
        }
        else if(soureType == .XSSelectImgTypeAblum){
            clickAblum(controller: controller,maxItemCount: maxItemCount)
        }
        else if(soureType == .XSSelectImgTypeCarmea){
            clickCamera(controller: controller)
        }
    }
    func clickAblum(controller:UIViewController,maxItemCount:Int) {
        let config = ZLPhotoConfiguration.default()
        config.canSelectAsset = { (asset) -> Bool in
            return true
        }
        config.maxSelectCount = maxItemCount
        config.noAuthorityCallback = { (type) in
            switch type {
            case .library:
                debugPrint("No library authority")
            case .camera:
                debugPrint("No camera authority")
            case .microphone:
                debugPrint("No microphone authority")
            }
        }
        let ac = ZLPhotoPreviewSheet(selectedAssets:[])
        ac.showPhotoLibrary(sender: controller)
        ac.selectImageBlock = { (images, assets, isOriginal) in
//            guard let self = self else {
//                debugPrint("self 为nil！！！！")
//                return
//            }
            
            let asset = assets.first
            let fileName = asset?.value(forKeyPath: "filename")
            let directory = asset?.value(forKeyPath: "directory")
            if let fileName = fileName, let directory = directory {
                let path  = "file:///var/mobile/Media/\(directory)/\(fileName)"
                debugPrint("文件名字\(fileName),directory ==\(directory),path==\(path)")
            }
            debugPrint("\(images)   \(assets)   \(isOriginal)")
            
            self.delegate?.XSSelectImgManageFinsh(images: images)
            debugPrint("\(images)   \(assets)   \(isOriginal)")
        }
        ac.cancelBlock = {
            debugPrint("cancel select")
        }
        ac.selectImageRequestErrorBlock = { (errorAssets, errorIndexs) in
            debugPrint("fetch error assets: \(errorAssets), error indexs: \(errorIndexs)")
        }

    }
    func clickCamera(controller:UIViewController) {
        let camera = ZLCustomCamera()
        
        camera.takeDoneBlock = { (image, videoUrl) in
            let img : UIImage = image ?? UIImage()
            self.delegate?.XSSelectImgManageFinsh(images: [img])
            //self.save(image: image, videoUrl: videoUrl)
        }
        controller.showDetailViewController(camera, sender: nil)
    }
    
    deinit {
        debugPrint("XSSelectImgManage deinit....")
    }

}
