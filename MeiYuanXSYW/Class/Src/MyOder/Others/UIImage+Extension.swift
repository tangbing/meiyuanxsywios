//
//  UIImage+Extension.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/6.
//

import UIKit

extension UIImage {
    
    ///对指定图片进行拉伸
    func resizableImage(name: String) -> UIImage {
        
        var normal = UIImage(named: name)!
        let imageWidth = normal.size.width * 0.5
        let imageHeight = normal.size.height * 0.5
        normal = resizableImage(withCapInsets: UIEdgeInsets(top: imageHeight, left: imageWidth, bottom: imageHeight, right: imageWidth))
        
        return normal
    }
    
    /**
     *  压缩上传图片到指定字节
     *
     *  image     压缩的图片
     *  maxLength 压缩后最大字节大小
     *
     *  return 压缩后图片的二进制
     */
    func compressImage(image: UIImage, maxLength: Int = 1024 * 200) -> Data? {
    
        
        //let newSize = self.scaleImage(image: image, imageLength: 800)
        let newImage = UIImage.resizeImage(image: image, newSize: image.size)
        
        var compress:CGFloat = 1.0
        var data = newImage.jpegData(compressionQuality:compress)
        
        while (data?.count)! > maxLength && compress > 0.01 {
            compress -= 0.02
            data = newImage.jpegData(compressionQuality:compress)
        }
        
        return data
    }
    
    
//    func compressImage(image: UIImage,) -> Data? {
//
//        //let newSize = self.scaleImage(image: image, imageLength: 800)
//        let newImage = UIImage.resizeImage(image: image, newSize: image.size)
//
//        var compress:CGFloat = 0.9
//        var data = UIImageJPEGRepresentation(newImage, compress)
//
//        while (data?.count)! > 2000 && compress > 0.01 {
//            compress -= 0.02
//            data = UIImageJPEGRepresentation(newImage, compress)
//        }
//
//        return data as Data?
//    }
   
    
    
    func compressImage(str : String, maxLength: Int = 1024 * 200) -> [String:AnyObject]?{
        
        
        let newImage = UIImage.resizeImage(image: self, newSize: self.size)
        var compress:CGFloat = 1.0
        var data = newImage.jpegData(compressionQuality:compress)
        if data!.count > 1000000{
            compress = 0.5
        }
    
        while (data?.count)! > maxLength && compress > 0.01 {
            compress -= 0.05
            data = newImage.jpegData(compressionQuality:compress)
        }
        
        ///
        let documentUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        
        
        let imgSufix = "\(str).jpg"
        
        
        let imgUrl = documentUrl!.appendingPathComponent(imgSufix)
        
        if FileManager.default.fileExists(atPath: imgUrl.absoluteString){
            try? FileManager.default.removeItem(at: imgUrl)
        }
        
        do{
            try data!.write(to: imgUrl)
            
            let img = UIImage(data: data!)

            return ["url" : imgUrl as AnyObject,"image" : img!]
        }catch{
            return nil
        }
        
    }
    
    
    
    
    /**
     *  通过指定图片最长边，获得等比例的图片size
     *
     *  image       原始图片
     *  imageLength 图片允许的最长宽度（高度）
     *
     *  return 获得等比例的size
     */
    func  scaleImage(image: UIImage, imageLength: CGFloat) -> CGSize {
        
        var newWidth:CGFloat = 0.0
        var newHeight:CGFloat = 0.0
//        let image_width = image.size.width
//        let image_height = image.size.height
        
        if (image.size.width > image.size.height || image.size.height > imageLength){
            
            if (image.size.width > image.size.height) {
                
                newWidth = imageLength;
                newHeight = newWidth * image.size.height / image.size.width;
                
            }else if(image.size.height > image.size.width){
                
                newHeight = imageLength;
                newWidth = newHeight * image.size.width / image.size.height;
                
            }else{
                
                newWidth = imageLength;
                newHeight = imageLength;
            }
            
        }
        return CGSize(width: newWidth, height: newHeight)
    }
    
    /**
     *  获得指定size的图片
     *
     *  image   原始图片
     *  newSize 指定的size
     *
     *  return 调整后的图片
     */
    class func resizeImage(image: UIImage, newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(newSize)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        
        guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else {
            return image
        }
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    ///生成条形码
    public class func generateCode128(_ text:String, _ size:CGSize,_ color:UIColor? = nil ) -> UIImage?
    {
        //给滤镜设置内容
        guard let data = text.data(using: .utf8) else {
            return nil
        }
        
        if let filter = CIFilter(name: "CICode128BarcodeGenerator") {
            
            filter.setDefaults()
            
            filter.setValue(data, forKey: "inputMessage")
            
            //获取生成的条形码
            guard let outPutImage = filter.outputImage else {
                return nil
            }
            
            // 设置条形码颜色
            let colorFilter = CIFilter(name: "CIFalseColor", parameters: ["inputImage":outPutImage,"inputColor0":CIColor(cgColor: color?.cgColor ?? UIColor.black.cgColor),"inputColor1":CIColor(cgColor: UIColor.clear.cgColor)])
            
            //获取带颜色的条形码
            guard let newOutPutImage = colorFilter?.outputImage else {
                return nil
            }
            
            let scaleX:CGFloat = size.width/newOutPutImage.extent.width
            
            let scaleY:CGFloat = size.height/newOutPutImage.extent.height
            
            let transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
            
            let output = newOutPutImage.transformed(by: transform)
            
            let barCodeImage = UIImage(ciImage: output)
            
            return barCodeImage
            
        }
        
        return nil
    }
    
    ///生成二维码
    public class func generateQRCode(_ text: String,_ width:CGFloat,_ fillImage:UIImage? = nil, _ color:UIColor? = nil) -> UIImage? {
        
        //给滤镜设置内容
        guard let data = text.data(using: .utf8) else {
            return nil
        }
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            
            // 设置生成的二维码的容错率
            // value = @"L/M/Q/H"
            filter.setValue("H", forKey: "inputCorrectionLevel")
            
            //获取生成的二维码
            guard let outPutImage = filter.outputImage else {
                return nil
            }
            
            // 设置二维码颜色
            let colorFilter = CIFilter(name: "CIFalseColor", parameters: ["inputImage":outPutImage,"inputColor0":CIColor(cgColor: color?.cgColor ?? UIColor.black.cgColor),"inputColor1":CIColor(cgColor: UIColor.clear.cgColor)])
            
            //获取带颜色的二维码
            guard let newOutPutImage = colorFilter?.outputImage else {
                return nil
            }
            
            let scale = width/newOutPutImage.extent.width
            
            let transform = CGAffineTransform(scaleX: scale, y: scale)
            
            let output = newOutPutImage.transformed(by: transform)
            
            let QRCodeImage = UIImage(ciImage: output)
            
            guard let fillImage = fillImage else {
                return QRCodeImage
            }
            
            let imageSize = QRCodeImage.size
            
            UIGraphicsBeginImageContextWithOptions(imageSize, false, UIScreen.main.scale)
            
            QRCodeImage.draw(in: CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height))
            
            let fillRect = CGRect(x: (width - width/5)/2, y: (width - width/5)/2, width: width/5, height: width/5)
            
            fillImage.draw(in: fillRect)
            
            guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else { return QRCodeImage }
            
            UIGraphicsEndImageContext()
            
            return newImage
            
        }
        
        return nil
        
    }
    
    
}



