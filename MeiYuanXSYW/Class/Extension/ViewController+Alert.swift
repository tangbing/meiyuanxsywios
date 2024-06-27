//
//  ViewController+Alert.swift
//  TICProject
//
//  Created by Tb on 2021/5/17.
//

import UIKit

enum AlertType {
    case alert
    case actionSheet
}

extension UIViewController {
    
    func showAlert(title: String?, message: String? = nil,sureAlertActionText: String = "确定",
                   cancelAlertActionText: String? = "取消",alertType: AlertType,
                   sureBlock: (() -> Void)?,cancelBlock: (() -> Void)? ) {
      
        let alert = TbAlertController(textTitle: title ?? "", message: message ?? "", preferredStyle: .preferredStyleAlert)
        alert.titleColor = UIColor.hex(hexString: "#060607")
        alert.titleFont = .systemFont(ofSize: 16, weight: .semibold)
        alert.separatorlLneColor = UIColor.hex(hexString: "#D8D8D8")
        alert.contentWidth = FMScreenScaleFrom(311)
        alert.contentViewRadius = 10
        

        if let cancelText = cancelAlertActionText {
            let cancelAction = TbAlertAction(textTitle: cancelText, alertActionStyle: .TbAlertActionStyleCancel) { action in
                guard let cancelBlock = cancelBlock else { return }
                cancelBlock()
            }
            cancelAction.setTitleColor(titleColor: UIColor.hex(hexString: "#262626"), forState: .normal)

            alert.addAction(action: cancelAction)
        }
        
        let alertAction = TbAlertAction(textTitle: sureAlertActionText, alertActionStyle: .TbAlertActionStyleDefault) { action in
            guard let sureBlock = sureBlock else { return }
            sureBlock()
        }
        alertAction.setTitleColor(titleColor: UIColor.king, forState: .normal)
        alert.addAction(action: alertAction)

        self.present(alert, animated: true, completion: nil)
    }
    
    func showSelectImageViewActionSheet(actionSheetHandler: [(String , (() -> Void))]) {
        let alert = TbAlertController(textTitle: "", message: "", preferredStyle: .preferredStyleActionSheet)
        alert.contentWidth = 347
        
        let takePhtoto = actionSheetHandler[0]
        let alertAction = TbAlertAction(textTitle: takePhtoto.0, alertActionStyle: .TbAlertActionStyleDefault) { action in
            //guard let sureBlock = takePhtoto.1 else { return }
            let sureBlock = takePhtoto.1
            sureBlock()
        }
        alertAction.textFont = .systemFont(ofSize: 17)
        alertAction.titleColorDict = [.normal : UIColor.hex(hexString: "titleColorDict")]
        
        let photoLibrary = actionSheetHandler[1]
        let otherAction = TbAlertAction(textTitle: photoLibrary.0, alertActionStyle: .TbAlertActionStyleCancel) { action in
            //guard let photoLibraryBlock = photoLibrary.1 else { return }
            let photoLibraryBlock = photoLibrary.1
            photoLibraryBlock()
            print(action.titleColorForState(forState: .normal))
        }
        otherAction.textFont = .systemFont(ofSize: 17)
        otherAction.titleColorDict = [.normal : UIColor.hex(hexString: "titleColorDict")]
        
        
        let cancel = actionSheetHandler[2]
        let cancelAction = TbAlertAction(textTitle: cancel.0, alertActionStyle: .TbAlertActionStyleCancel) { action in
//            guard let cancelBlock = cancelBlock else { return }
            let cancelBlock = cancel.1
            cancelBlock()
            print(action.titleColorForState(forState: .normal))
        }
        cancelAction.textFont = .systemFont(ofSize: 17)
        cancelAction.titleColorDict = [.normal : UIColor.hex(hexString: "titleColorDict")]
        
        

       
        alert.addAction(action: alertAction)
        alert.addAction(action: otherAction)
        alert.addAction(action: cancelAction)


        self.present(alert, animated: true, completion: nil)
    }
}
