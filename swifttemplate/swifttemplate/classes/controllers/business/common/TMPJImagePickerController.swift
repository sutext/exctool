//
//  CTImagePickerController.swift
//  CoreTeahouse
//
//  Created by supertext on 15/3/11.
//  Copyright © 2016年 mding. All rights reserved.
//

import UIKit

class CTImagePickerController: UIImagePickerController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    class ActionItem: TMPJNameConvertibale {
        var name:String!
        init(name:String)
        {
            self.name = name;
        }
    }
    var completed:((image:UIImage?)->Void)!
    convenience init (completed:(image:UIImage?)->Void)
    {
        self.init();
        self.completed = completed;
    }
    override func viewDidLoad() {
        super.viewDidLoad();
        self.navigationBar.tintColor = UIColor.whiteColor();
        self.allowsEditing = true;
        self.delegate = self;
    }
    func showIn(controller:TMPJBaseViewController)
    {
        let action = CTActionController(items: [ActionItem(name:"拍照"),ActionItem(name: "相册")]) { (sender, item, index) -> Void in
            if index == 0
            {
                if UIImagePickerController.isSourceTypeAvailable(.Camera)
                {
                    self.sourceType = .Camera;
                    controller.presentViewController(self, animated: true, completion: nil);
                }
                else
                {
                    kTMPJAlertManager.showAlert(message:"请用户在[系统设置-隐私-相机]里面允许美加美云商访您的相机");
                }
            }
            else
            {
                if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary)
                {
                    self.sourceType = .PhotoLibrary;
                    controller.presentViewController(self, animated: true, completion: nil);
                }
                else
                {
                    kTMPJAlertManager.showAlert(message:"请用户在[系统设置-隐私-相机]里面允许美加美云商访您的相册");
                }
            }
        }
        action.addAction("取消")
        action.show();
    }
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent;
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        picker.dismissViewControllerAnimated(true, completion: nil);
        self.completed(image: image);
    }
//    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
//        let img = info[UIImagePickerControllerEditedImage] as? UIImage;
//        self.completed(image: img);
//    }
}
