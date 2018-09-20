//
//  TMPJScanCodeController.swift
//  swifttemplate
//
//  Created by supertext on 15/3/11.
//  Copyright © 2015年 icegent. All rights reserved.
//


import UIKit
import AVFoundation
import CoreImage

class TMPJScanCodeController: TMPJBaseViewController {
    let session = AVCaptureSession()
    let maskView = TMPJView()
    let boxView = TMPJImageView(image: #imageLiteral(resourceName: "common_scan_box"))
    let lineView = TMPJImageView(image: #imageLiteral(resourceName: "common_scan_line"))
    var finish:((String)->Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "扫一扫"
        self.setLeftbar(title: "关闭")
        self.setRightbar(title: "相册")
        
        guard let device = AVCaptureDevice.default(for: .video) else{return}
        guard let input = try? AVCaptureDeviceInput(device: device) else{return}
        let output = AVCaptureMetadataOutput()
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        output.rectOfInterest = CGRect(x: 0, y: 0, width: 1, height: 1)
        if session.canAddInput(input){
            session.addInput(input)
        }
        if session.canAddOutput(output){
            session.addOutput(output)
        }
        output.metadataObjectTypes = [.qr]
        let layer = AVCaptureVideoPreviewLayer(session: session)
        layer.frame = self.view.bounds
        layer.videoGravity = .resizeAspectFill
        self.view.layer.addSublayer(layer)
        self.session.startRunning()
        let maskView = MaskView(frame: self.view.bounds)
        self.view.addSubview(maskView)
        maskView.start()
    }
    override func leftItemAction(_ sender: AnyObject?) {
        self.dismiss(animated: true, completion: nil)
    }
    override func rightItemAction(_ sender: AnyObject?) {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            pop.alert("请用户在[系统设置-隐私-相机]里面允许锅大侠访您的相册")
            return
        }
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        picker.navigationBar.tintColor = .black
        self.present(picker, animated: true, completion: nil)
    }
    func detect(_ image:UIImage?)->String?{
        guard let image = image else {
            return nil
        }
        guard let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy:CIDetectorAccuracyHigh]) else {
            return nil
        }
        guard let ciimg = CIImage(image: image) else {
            return nil
        }
        guard let feature = detector.features(in: ciimg).first as? CIQRCodeFeature else{
            return nil
        }
        return feature.messageString
    }
}
extension TMPJScanCodeController:AVCaptureMetadataOutputObjectsDelegate{
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        guard let first = metadataObjects.first,
            let string = first.stringValue else {
                return
        }
        self.session.stopRunning()
        self.dismiss(animated: true) {[weak self] in
            self?.finish?(string)
        }
    }
}
extension TMPJScanCodeController:UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerControllerEditedImage] as? UIImage  else{
            return
        }
        guard let result = self.detect(image) else{
            return
        }
        self.session.stopRunning()
        self.dismiss(animated: true) {[weak self] in
            self?.finish?(result)
        }
    }
}
extension TMPJScanCodeController:UINavigationControllerDelegate{}
extension TMPJScanCodeController{
    class MaskView: UIView {
        private let boxRect:CGRect
        private let scaner = UIImageView(image: #imageLiteral(resourceName: "common_scan_line"))
        private let animator:CABasicAnimation
        override init(frame: CGRect) {
            
            let width = 2*frame.width/3
            let left = frame.width/6
            let top = frame.height/2 - width/2
            self.boxRect = CGRect(x: left, y: top, width: width, height: width)
            
            let ani = CABasicAnimation(keyPath: "transform.translation.y")
            ani.byValue = width-5
            ani.duration = 1.5
            ani.repeatCount = Float(Int.max)
            self.animator = ani
            
            super.init(frame: frame)
            self.scaner.frame = CGRect(x: left, y: top, width: width, height: self.scaner.height*width/self.scaner.width)
            self.addSubview(self.scaner)
            self.backgroundColor = .clear
        }
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        override func draw(_ rect: CGRect) {
            UIColor(white: 0, alpha: 0.4).setFill()
            UIRectFill(rect)
            UIColor.clear.setFill()
            UIRectFill(boxRect)
            let boxImage:UIImage = #imageLiteral(resourceName: "common_scan_box")
            boxImage.draw(in: boxRect)
        }
        func start(){
            self.scaner.layer.add(self.animator, forKey: nil)
        }
    }
}
extension AVMetadataObject{
    @NSManaged var stringValue:String?
}
