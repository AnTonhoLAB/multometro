//
//  RoomRegisterCell.swift
//  Mulltometro
//
//  Created by George Gomes on 19/10/18.
//  Copyright © 2018 CrowCode. All rights reserved.
//

import UIKit

class RoomRegisterCell: UITableViewCell {
    
    @IBOutlet weak var lbRoomName: UILabel! { didSet { lbRoomName.text = R.string.localizable.roomName() } }
    @IBOutlet weak var lbParticipate: UILabel! { didSet { lbParticipate.text = R.string.localizable.willParticipate() } }
    @IBOutlet weak var lbDueDate: UILabel! { didSet { lbDueDate.text = R.string.localizable.dueDate() } }
    
    
    @IBOutlet weak var tfRoomName: UITextField!
    @IBOutlet weak var stParticipate: UISwitch! {
        didSet {
            stParticipate.onTintColor = .redSystem
        }
    }
    @IBOutlet weak var dayPicker: UIPickerView!{
        didSet{
            dayPicker.dataSource = self
            dayPicker.delegate = self
            dayPicker.selectRow((pickerDataSize/2) + 14, inComponent: 0, animated: true)
            dayPicker.roundedCornerColor(radius: 10)
        }
    }
    
    let pickerDataSize = 100_000
    var pickerValues = [Int]()
    
   
    
    override func awakeFromNib() {
        for i in 1...30 {
            pickerValues.append(i)
        }
    }
}

extension RoomRegisterCell: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSize
    }
}

extension RoomRegisterCell: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label = view as? UILabel
        
        if label == nil {
            
            let width = pickerView.rowSize(forComponent: component).width
            let height = pickerView.rowSize(forComponent: component).height
            
            label = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: width , height: height))
            label?.textAlignment = .center
            label?.font = UIFont(name: "ArialMT", size: 30)
            label?.textColor = UIColor.white
            let value = row % 30
            if pickerValues.count > 0 {
                label?.text = String(pickerValues[value])
            }
        }
        
        return label!
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // do something with the resulting selected row
        
        // reset the picker to the middle of the long list
        let position = pickerDataSize/2 + row
        pickerView.selectRow(position, inComponent: 0, animated: false)
    }
}
