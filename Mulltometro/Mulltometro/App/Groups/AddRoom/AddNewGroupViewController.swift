//
//  AddNewGroupViewController.swift
//  Mulltometro
//
//  Created by George Gomes on 18/10/18.
//  Copyright © 2018 CrowCode. All rights reserved.
//

import UIKit
import Rswift

class AddNewGroupViewController: UIViewController {
    
    @IBOutlet weak var btCancel: UIBarButtonItem! { didSet { btCancel.title = R.string.localizable.cancel() } }
    @IBOutlet weak var btCreate: UIBarButtonItem! { didSet { btCreate.title = R.string.localizable.create() } }
    
    @IBOutlet weak var lbRoomName: UILabel!{ didSet { lbRoomName.text = R.string.localizable.roomName() } }
    @IBOutlet weak var lbParticipate: UILabel!{ didSet { lbParticipate.text = R.string.localizable.willParticipate()} }
    @IBOutlet weak var lbDueDate: UILabel!{ didSet { lbDueDate.text = R.string.localizable.dueDate() } }
    
    @IBOutlet weak var tfRoomName: UITextField!
    @IBOutlet weak var stParticipate: UISwitch!
    
    @IBOutlet weak var dayPicker: UIPickerView!{
        didSet{
            dayPicker.dataSource = self
            dayPicker.delegate = self
            dayPicker.selectRow(4, inComponent: 0, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didTapCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapCreate(_ sender: Any) {
        
        guard let roomName = tfRoomName.text else { return }
        let dueDate = dayPicker.selectedRow(inComponent: 0) - 1

        let room = stParticipate.isOn ? Room(likeUserTo: roomName, dueDate: dueDate)
                                      : Room(name: roomName, dueDate: dueDate)
        
        RoomRequester.addRoom(with: room.toData())
    }
}

extension AddNewGroupViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 30
    }
}

extension AddNewGroupViewController: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label = view as? UILabel
        
        if label == nil {
            
            let width = pickerView.rowSize(forComponent: component).width
            let height = pickerView.rowSize(forComponent: component).height
            
            label = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: width , height: height))
            label?.textAlignment = .center
            label?.font = UIFont(name: "ArialMT", size: 30)
            label?.textColor = UIColor.white
            label?.text = String(row + 1)
        }
        
        return label!
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
}
