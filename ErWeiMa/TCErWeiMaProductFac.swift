//
//  TCErWeiMaProductFac.swift
//  ErWeiMa
//
//  Created by LingKangli on 16/6/16.
//  Copyright © 2016年 凌康丽. All rights reserved.
//

import UIKit

class TCErWeiMaProductFac: UIControl {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    class func facMakeErWeiMaForText(str:String) -> UIImage {

        let filter = CIFilter(name: "CIQRCodeGenerator")
    
        filter?.setDefaults()
        filter?.setValue(str.dataUsingEncoding(NSUTF8StringEncoding), forKey: "inputMessage")
//        从滤镜中取出生成的图片
        let ciImage = filter?.outputImage
        print("\(filter)")
        let bgImage = self.createNonInterpolatedUIImageFormCIImage(ciImage!, size: 150.0)
        return bgImage
    }
    
    class func facMakeErWeiMaForImage(image:UIImage) -> UIImage {

//        print("\(image.CIImage)")
        let filter = CIFilter(name: "CIQRCodeGenerator")
        filter?.setDefaults()
        filter?.setValue(UIImagePNGRepresentation(image)!, forKey: "inputMessage")
//        filter?.setValue("H", forKey: "inputCorrectionLevel")

//        从滤镜中取出生成的图片
        let outputImage = filter?.outputImage
        
//        let content = CIContext(options: nil)//创建基于GPU的CIContext对象
        
//        let cgimg:CGImageRef = content.createCGImage(outputImage!, fromRect: (outputImage?.extent)!)
//        let newImg = UIImage(CGImage: cgimg)
//        print("\(filter)")
//        let codeImage = UIImage(CIImage: filter!.outputImage!
//            .imageByApplyingTransform(CGAffineTransformMakeScale(5, 5)))
//        return newImg
//        return image
        
        return UIImage(data:UIImagePNGRepresentation(image)!)!
        
    }
    
    class func facMakeErWeiMaForImage(qrImageName:String,qrString:String) -> UIImage {
        
        if let sureQRString:String = qrString {
            let stringData = sureQRString.dataUsingEncoding(NSUTF8StringEncoding,
                                                            allowLossyConversion: false)
            // 创建一个二维码的滤镜
            let qrFilter = CIFilter(name: "CIQRCodeGenerator")!
            qrFilter.setValue(stringData, forKey: "inputMessage")
            qrFilter.setValue("H", forKey: "inputCorrectionLevel")
            let qrCIImage = qrFilter.outputImage
            // 创建一个颜色滤镜,黑白色
            let colorFilter = CIFilter(name: "CIFalseColor")!
            colorFilter.setDefaults()
            colorFilter.setValue(qrCIImage, forKey: "inputImage")
            colorFilter.setValue(CIColor(red: 0, green: 0, blue: 0), forKey: "inputColor0")
            colorFilter.setValue(CIColor(red: 1, green: 1, blue: 1), forKey: "inputColor1")
            // 返回二维码image
            let codeImage = UIImage(CIImage: colorFilter.outputImage!
                .imageByApplyingTransform(CGAffineTransformMakeScale(5, 5)))

            // 通常,二维码都是定制的,中间都会放想要表达意思的图片
            if let iconImage = UIImage(named:qrImageName) {
                let rect = CGRectMake(0, 0, codeImage.size.width, codeImage.size.height)
                UIGraphicsBeginImageContext(rect.size)
                codeImage.drawInRect(rect)
                let avatarSize = CGSizeMake(rect.size.width * 0.25, rect.size.height * 0.25)
                let x = (rect.width - avatarSize.width) * 0.5
                let y = (rect.height - avatarSize.height) * 0.5
                iconImage.drawInRect(CGRectMake(x, y, avatarSize.width, avatarSize.height))
                let resultImage = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                return resultImage
            }
            return codeImage
        }
    }
    
    //MARK: - 根据CIImage生成指定大小的高清UIImage
    class private func createNonInterpolatedUIImageFormCIImage(image: CIImage, size: CGFloat) -> UIImage {
        
        let extent: CGRect = CGRectIntegral(image.extent)
        let scale: CGFloat = min(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent))
        
        let width = CGRectGetWidth(extent) * scale
        let height = CGRectGetHeight(extent) * scale
        let cs: CGColorSpaceRef = CGColorSpaceCreateDeviceGray()!
        let bitmapRef = CGBitmapContextCreate(nil, Int(width), Int(height), 8, 0, cs, 0)!
        
        let context = CIContext(options: nil)
        let bitmapImage: CGImageRef = context.createCGImage(image, fromRect: extent)
        
        CGContextSetInterpolationQuality(bitmapRef,  CGInterpolationQuality.None)
        CGContextScaleCTM(bitmapRef, scale, scale);
        CGContextDrawImage(bitmapRef, extent, bitmapImage);
        let scaledImage: CGImageRef = CGBitmapContextCreateImage(bitmapRef)!
        return UIImage(CGImage: scaledImage)
    }
    
    //MARK: - 字符串转图片
//    class func UIImageTOString(image:UIImage) -> NSData {
    
//        let data = UIImagePNGRepresentation(image)
//        let str = data!.base64EncodedStringWithOptions(.allZeros)
//        return String(str)
//    }
}
