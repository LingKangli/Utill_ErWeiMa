
//
//  ViewController.swift
//  ErWeiMa
//
//  Created by LingKangli on 16/6/16.
//  Copyright © 2016年 凌康丽. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var productBtn: UIButton!
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var loadImage: UIImageView!
    
    @IBOutlet weak var imageFromLocation: UIImageView!
    
    @IBOutlet weak var picImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func picProductBtnAction(sender: AnyObject) {
        
        
//        picImg.image = TCErWeiMaProductFac.facMakeErWeiMaForImage(imageFromLocation.image!)
        
//        picImg.image = imageFromLocation.image
        
        picImg.image = TCErWeiMaProductFac.facMakeErWeiMaForImage((imageFromLocation?.image)!)
    }
    
    @IBAction func productBtnAction(sender: AnyObject) {
        
        self.imageView.backgroundColor = UIColor(red: CGFloat(arc4random() % 4), green:CGFloat(arc4random() % 3), blue:CGFloat(arc4random() % 1), alpha: 1)
        imageView.image = TCErWeiMaProductFac.facMakeErWeiMaForText(textField.text!)
        loadImage.image = TCErWeiMaProductFac.facMakeErWeiMaForImage("bgImg", qrString: textField.text!)
    }
    
    @IBAction func getImage(sender: AnyObject) {
    
        self.imageFromLocation.image = UIImage(named: "bgImg")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

