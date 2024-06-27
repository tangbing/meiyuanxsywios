//
//  TbImageViewContainer.swift
//  MeiYuanXSYW
//
//  Created by Tb on 2021/12/4.
//

import UIKit

class TbImageViewContainer: UIView {

    var images: [String] = [String]()
    var imageViews: [UIImageView] = [UIImageView]()
    let kImageContainerWidth = screenWidth - 20 - 60
    let kPhotoMargin : CGFloat = 5
    var kPhotoSizeW: CGFloat = 0.0

    
    func getMaxColCount() -> Int {
        return images.count == 4 ? 2 : 3
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        for i in 0..<9 {
            let imageView = UIImageView()
            imageView.tag = i
            imageView.isHidden = true
            self.addSubview(imageView)
            imageViews.append(imageView)
        }
        self.backgroundColor = .white
        
        kPhotoSizeW = (kImageContainerWidth - (CGFloat(getMaxColCount() - 1)) * kPhotoMargin) / CGFloat(getMaxColCount())
        
    }
    
    func setData(imageData: [String]?) {
        guard let images = imageData else {
            print("images nil")
            self.imageViews.forEach {
                $0.isHidden = true
            }
            return
        }
        
        self.images = images
        
        for i in 0..<imageViews.count {
            let iv = self.imageViews[i]
            if i < images.count {
                let model = images[i];
                iv.tag = i
                iv.image = UIImage(named: model)
                iv.isHidden = false
                //iv.kf.setImage(with: URL(string: model.imageName ?? "")!)
            } else {
                iv.isHidden = true
            }
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let photosCount = self.images.count
        for i in 0..<photosCount {
            let iv = self.imageViews[i]
            let col = i % getMaxColCount()
            let row = i / getMaxColCount()
            iv.frame = CGRect(x: CGFloat(col) * (kPhotoSizeW + kPhotoMargin), y: CGFloat(row) * (kPhotoSizeW + kPhotoMargin), width: kPhotoSizeW, height: kPhotoSizeW)
        }
    }


}
