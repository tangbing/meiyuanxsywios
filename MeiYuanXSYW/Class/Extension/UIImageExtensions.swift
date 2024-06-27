//
//  UIImageExtensions.swift
//  U17
//
//  Created by charles on 2017/10/27.
//  Copyright © 2017年 None. All rights reserved.
//

#if os(iOS) || os(tvOS)

import UIKit

extension UIImage {
    // MARK:- 二、UIColor 生成的图片 和 生成渐变色图片
    public enum JKImageGradientDirection {
        /// 水平从左到右
        case horizontal
        /// 垂直从上到下
        case vertical
        /// 左上到右下
        case leftOblique
        /// 右上到左下
        case rightOblique
        /// 自定义
        case other(CGPoint, CGPoint)
        
        public func point(size: CGSize) -> (CGPoint, CGPoint) {
            switch self {
            case .horizontal:
                return (CGPoint(x: 0, y: 0), CGPoint(x: size.width, y: 0))
            case .vertical:
                return (CGPoint(x: 0, y: 0), CGPoint(x: 0, y: size.height))
            case .leftOblique:
                return (CGPoint(x: 0, y: 0), CGPoint(x: size.width, y: size.height))
            case .rightOblique:
                return (CGPoint(x: size.width, y: 0), CGPoint(x: 0, y: size.height))
            case .other(let stat, let end):
                return (stat, end)
            }
        }
    }

    // MARK: 2.5、生成带圆角渐变色的图片 [UIColor, UIColor, UIColor]
        /// 生成带圆角渐变色的图片 [UIColor, UIColor, UIColor]
        /// - Parameters:
        ///   - colors: UIColor 数组
        ///   - size: 图片大小
        ///   - radius: 圆角
        ///   - locations: locations 数组
        ///   - direction: 渐变的方向
        /// - Returns: 带圆角的渐变的图片
    static func gradient(_ colors: [UIColor],
                         size: CGSize = CGSize(width: 10, height: 10),
                         radius: CGFloat,
                         locations:[CGFloat]? = nil,
                         direction: JKImageGradientDirection = .horizontal) -> UIImage? {
        if colors.count == 0 { return nil }
        if colors.count == 1 {
            return colors[0].image()
        }
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: size.width, height: size.height), cornerRadius: radius)
        path.addClip()
        context?.addPath(path.cgPath)
        guard let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: colors.map{$0.cgColor} as CFArray, locations: locations?.map { CGFloat($0) }) else { return nil
        }
        let directionPoint = direction.point(size: size)
        context?.drawLinearGradient(gradient, start: directionPoint.0, end: directionPoint.1, options: .drawsBeforeStartLocation)
    
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }

    /// EZSE: scales image
    public class func scaleTo(image: UIImage, w: CGFloat, h: CGFloat) -> UIImage {
        let newSize = CGSize(width: w, height: h)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }

    /// EZSE Returns resized image with width. Might return low quality
    public func resizeWithWidth(_ width: CGFloat) -> UIImage {
        let aspectSize = CGSize (width: width, height: aspectHeightForWidth(width))

        UIGraphicsBeginImageContext(aspectSize)
        self.draw(in: CGRect(origin: CGPoint.zero, size: aspectSize))
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return img!
    }

    /// EZSE Returns resized image with height. Might return low quality
    public func resizeWithHeight(_ height: CGFloat) -> UIImage {
        let aspectSize = CGSize (width: aspectWidthForHeight(height), height: height)

        UIGraphicsBeginImageContext(aspectSize)
        self.draw(in: CGRect(origin: CGPoint.zero, size: aspectSize))
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return img!
    }

    /// EZSE:
    public func aspectHeightForWidth(_ width: CGFloat) -> CGFloat {
        return (width * self.size.height) / self.size.width
    }

    /// EZSE:
    public func aspectWidthForHeight(_ height: CGFloat) -> CGFloat {
        return (height * self.size.width) / self.size.height
    }

    /// EZSE: Returns cropped image from CGRect
    public func croppedImage(_ bound: CGRect) -> UIImage? {
        guard self.size.width > bound.origin.x else {
            print("EZSE: Your cropping X coordinate is larger than the image width")
            return nil
        }
        guard self.size.height > bound.origin.y else {
            print("EZSE: Your cropping Y coordinate is larger than the image height")
            return nil
        }
        let scaledBounds: CGRect = CGRect(x: bound.origin.x * self.scale, y: bound.origin.y * self.scale, width: bound.width * self.scale, height: bound.height * self.scale)
        let imageRef = self.cgImage?.cropping(to: scaledBounds)
        let croppedImage: UIImage = UIImage(cgImage: imageRef!, scale: self.scale, orientation: UIImage.Orientation.up)
        return croppedImage
    }

    /// EZSE: Use current image for pattern of color
    public func withColor(_ tintColor: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)

        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: 0, y: self.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        context?.setBlendMode(CGBlendMode.normal)

        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height) as CGRect
        context?.clip(to: rect, mask: self.cgImage!)
        tintColor.setFill()
        context?.fill(rect)

        let newImage = UIGraphicsGetImageFromCurrentImageContext()! as UIImage
        UIGraphicsEndImageContext()

        return newImage
    }

    ///EZSE: Returns the image associated with the URL
    public convenience init?(urlString: String) {
        guard let url = URL(string: urlString) else {
            self.init(data: Data())
            return
        }
        guard let data = try? Data(contentsOf: url) else {
            print("EZSE: No image in URL \(urlString)")
            self.init(data: Data())
            return
        }
        self.init(data: data)
    }

    ///EZSE: Returns an empty image //TODO: Add to readme
    public class func blankImage() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 1, height: 1), false, 0.0)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}

#endif
