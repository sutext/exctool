//
//  CTImagePickerController.swift
//  CoreTeahouse
//
//  Created by supertext on 15/3/11.
//  Copyright © 2016年 icegent. All rights reserved.
//

import UIKit

class TMPJImagePickerController: UIImagePickerController{
    fileprivate var completed:((_ image:UIImage?)->Void)?
    convenience init (completed:((UIImage?)->Void)?)
    {
        self.init();
        self.completed = completed;
        
    }
    override func viewDidLoad() {
        super.viewDidLoad();
        self.navigationBar.tintColor = UIColor.white;
        self.allowsEditing = true
        self.delegate = self
    }
    func showIn(_ controller:TMPJBaseViewController)
    {
        popup.action(items: ["拍照","相册"]) { (_, idx) in
            switch idx{
            case 0?:
                if UIImagePickerController.isSourceTypeAvailable(.camera)
                {
                    self.sourceType = .camera;
                    controller.present(self, animated: true, completion: nil);
                }
                else
                {
                    popup.alert(message: "请用户在[系统设置-隐私-相机]里面允许劲乐台访您的相机")
                }
            case 1?:
                if UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
                {
                    self.sourceType = .photoLibrary;
                    controller.present(self, animated: true, completion: nil);
                }
                else
                {
                    popup.alert(message: "请用户在[系统设置-隐私-相机]里面允许劲乐台访您的相册")
                }
            default :
                break
            }
        }
    }
    
}
extension TMPJImagePickerController:UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            self.dismiss(animated: true, completion: nil)
            self.completed?(image)
        }
    }
}
extension TMPJImagePickerController:UINavigationControllerDelegate{}
