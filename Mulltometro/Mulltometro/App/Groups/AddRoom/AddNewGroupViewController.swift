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
    
    @IBOutlet weak var btCancel: UIBarButtonItem! {
        didSet {
            btCancel.title = R.string.localizable.cancel()
            btCancel.tintColor = .redSystem
        }
    }
    @IBOutlet weak var btCreate: UIBarButtonItem! {
        didSet {
            btCreate.title = R.string.localizable.create()
            btCreate.tintColor = .redSystem
        }
    }
    
    @IBOutlet weak var registerTableView: UITableView! {
        didSet {
            registerTableView.dataSource = self
            registerTableView.delegate = self
            registerTableView.estimatedRowHeight = 100
            registerTableView.rowHeight = UITableView.automaticDimension
        }
    }
    
    @IBOutlet weak var expandedView: UIView!
    
    weak var delegate: RegisterForNewGroup?
    var fees = [Rule]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    
    @IBAction func didTapCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapCreate(_ sender: Any) {
        
        AuthManager.selfUser { response in
            let cell = self.registerTableView.cellForRow(at: IndexPath(item: 0, section: 0)) as! RoomRegisterCell
            let fields = cell.requireNameAndDue()
            
            switch response{
                
            case .success(let admin):
                let room = fields.participate ? Room(likeUserTo: admin, name: fields.name, fees: self.fees, dueDate: fields.due) :
                                                Room(admin: admin, name: fields.name, fees: self.fees, dueDate: fields.due)
                self.showLoader()
                RoomRequester.addRoom(with: room.dictionary) { [weak self] response in
                    guard let self = self else { return }
                    
                    switch response {
                    case .success(let group):
                        if let delegate = self.delegate {
                            delegate.added(new: group)
                            self.dismiss(animated: true, completion: nil)
                        }
                    case .failure(let err):
                        self.alertSimpleWarning(title: "Error", message: err.localizedDescription, action: nil)
                    }
                    self.dismissLoader()
                }
            case .failure(let err):
                self.dismissLoader()
                self.alertSimpleWarning(title: "Error", message: err.localizedDescription, action: nil)
            }
        }
    }
}

extension AddNewGroupViewController: RegisterRequester {
    
    func addFee() {
        self.expandedView.frame.size.height = 1000
        self.registerTableView.reloadData()
        fees.append(Rule())
        
        registerTableView.scrollToRow(at: IndexPath(item: 1, section: 0), at: .top, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            guard let self = self else { return }
            self.registerTableView.beginUpdates()
            self.registerTableView.insertRows(at: [IndexPath(item: 2, section: 0)], with: .automatic)
            self.registerTableView.endUpdates()
        }
    }
    
    func cancelFee() {
        fees.removeLast()
        registerTableView.deleteRows(at: [IndexPath(item: 2, section: 0)], with: .automatic)
        closeFees()
    }
    
    func saveFee() {
        let cell = registerTableView.cellForRow(at: IndexPath(item: 2, section: 0)) as! AddFeeRegisterCelll
        let newFee = cell.createFee()
        fees[fees.count - 1] = newFee
        cell.animationSave(with: registerTableView)
        closeFees()
    }
    
    func closeFees() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) { [weak self] in
            guard let self = self else { return }
            self.registerTableView.scrollToRow(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
            self.expandedView.frame.size.height = 1
            self.registerTableView.reloadData()
        }
    }
}

extension AddNewGroupViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fees.count + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 
        switch indexPath.row {
        case 0:
            return tableView.dequeueReusableCell(withIdentifier: "roomRegisterCell", for: indexPath) as! RoomRegisterCell
        case 1:
            let addFeeHeaderCell = tableView.dequeueReusableCell(withIdentifier: "addFeeHeaderCell", for: indexPath) as! AddFeeHeaderCell
            addFeeHeaderCell.delegate = self
            return addFeeHeaderCell
        default:
            return tableView.dequeueReusableCell(withIdentifier: "addFeeRegisterCell", for: indexPath) as! AddFeeRegisterCelll
        }
    }
    
}

extension AddNewGroupViewController: UITableViewDelegate {
    
}
