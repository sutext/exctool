//
//  CTImagePickerController.swift
//  CoreTeahouse
//
//  Created by supertext on 15/3/11.
//  Copyright © 2016年 mding. All rights reserved.
//

import UIKit

class TMPJImagePickerController: UIImagePickerController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    class ActionItem: TMPJNameConvertibale {
        var name:String!
        init(name:String)
        {
            self.name = name;
        }
    }
    var completed:((_ image:UIImage?)->Void)?
    convenience init (completed:@escaping (_ image:UIImage?)->Void)
    {
        self.init();
        self.completed = completed;
        
    }
    override func viewDidLoad() {
        super.viewDidLoad();
        self.navigationBar.tintColor = UIColor.white;
        self.allowsEditing = true;
        self.delegate = self;
    }
    func showIn(_ controller:TMPJBaseViewController)
    {
        let action = CTActionController(items: [ActionItem(name:"拍照"),ActionItem(name: "相册")]) { (sender, item, index) -> Void in
            if index == 0
            {
                if UIImagePickerController.isSourceTypeAvailable(.camera)
                {
                    self.sourceType = .camera;
                    controller.present(self, animated: true, completion: nil);
                }
                else
                {
                    kTMPJAlertManager.showAlert(message:"请用户在[系统设置-隐私-相机]里面允许美加美云商访您的相机");
                }
            }
            else
            {
                if UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
                {
                    self.sourceType = .photoLibrary;
                    controller.present(self, animated: true, completion: nil);
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
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent;
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        picker.dismiss(animated: true, completion: nil);
        self.completed!(image);
    }
}
