//
//  TMPJCityPickerController.swift
//  swifttemplate
//
//  Created by supertext on 2017/11/8.
//  Copyright © 2017年 icegent. All rights reserved.
//

import UIKit

class TMPJCityPickerController: TMPJPickerController {
    fileprivate let pickerView = UIPickerView()
    fileprivate var provinceObjects:[TMPJAreaObject] = []
    fileprivate var currentProvince:TMPJAreaObject?
    var currentCity:TMPJAreaObject?
    var finishBlock:((TMPJAreaObject?)->Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contentView.addSubview(self.pickerView)
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        self.pickerView.translatesAutoresizingMaskIntoConstraints = false
        self.pickerView.adhere(insets: nil)
        self.completeButton.clickedAction = {[weak self] _ in
            guard let wself = self else {
                return
            }
            wself.dismiss(animated: true, completion: {
                wself.finishBlock?(wself.currentCity)
            })
        }
        self.reloadData()
    }
    override func reloadData() {
        TMPJModelService.default.areas(for: nil){(areas,err) in
            if let areas = areas{
                self.provinceObjects = areas
                self.pickerView.reloadComponent(0)
                if let area = self.currentCity
                {
                    let parea = area.parent ?? areas.first(where: { (obj) -> Bool in
                        return obj.id == area.pid
                    })
                    
                    if let parea = parea,
                        let idx = self.provinceObjects.index(of: parea)
                    {
                        self.pickerView.selectRow(idx, inComponent: 0, animated: true)
                        self.currentProvince = parea
                        TMPJModelService.default.areas(for: parea){subareas,suberr in
                            if let subareas = subareas,subareas.count>0{
                                self.pickerView.reloadComponent(1)
                                if let aidx = subareas.index(of: area){
                                    self.pickerView.selectRow(aidx, inComponent: 1, animated: true)
                                }else{
                                    self.pickerView.selectRow(0, inComponent: 1, animated: true)
                                    self.currentCity = subareas[0]
                                }
                            }
                        }
                        return
                    }
                    self.pickerView.selectRow(0, inComponent: 0, animated: true)
                    self.currentProvince = self.provinceObjects[0]
                    self.reloadCities()
                }
            }
        }
    }
    func reloadCities(){
        guard let currentProvence = self.currentProvince else {
            return
        }
        TMPJModelService.default.areas(for: currentProvence){areas,err  in
            if let areas = areas,areas.count>0{
                self.pickerView.reloadComponent(1)
                self.pickerView.selectRow(0, inComponent: 1, animated: true)
                self.currentCity = areas[0]
            }
        }
    }
}
extension TMPJCityPickerController:UIPickerViewDataSource,UIPickerViewDelegate{
    func createLabel(text:String?) -> UILabel {
        let label = UILabel()
        label.font = .size17
        label.textColor = UIColor(0x333333)
        label.textAlignment = .center
        label.text = text
        return label
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return self.provinceObjects.count
        default:
            return self.currentProvince?.children?.count ?? 0
        }
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var areaObject:TMPJAreaObject?
        switch component {
        case 0:
            areaObject = self.provinceObjects[row]
        case 1:
            areaObject = self.currentProvince?.children?.object(at: row) as? TMPJAreaObject
        default:
            break
        }
        guard let label = view as? UILabel else {
            return self.createLabel(text: areaObject?.name)
        }
        label.text = areaObject?.name
        return label
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            self.currentProvince = self.provinceObjects[row]
            self.reloadCities()
        case 1:
            self.currentCity = self.currentProvince?.children?.object(at: row) as? TMPJAreaObject
        default:
            break
        }
    }
}
