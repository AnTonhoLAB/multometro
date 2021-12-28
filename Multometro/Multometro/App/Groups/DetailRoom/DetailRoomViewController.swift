//
//  DetailRoomViewController.swift
//  Multometro
//
//  Created by George Gomes on 23/10/18.
//  Copyright © 2018 CrowCode. All rights reserved.
//

import UIKit
import Rswift

class DetailViewController: UIViewController {

    @IBOutlet weak var detailRoomFields: DetailRoomFields!
    @IBOutlet weak var detailTransparent: UIView! {
        didSet {
           detailTransparent.frame.size = detailRoomFields.frame.size
        }
    }
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            let nib = UINib(nibName: HeaderCell.identifier, bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: HeaderCell.identifier)
            tableView.estimatedRowHeight = 180
            tableView.rowHeight = UITableView.automaticDimension
            tableView.tableFooterView = UIView()
       }
    }
    
    var room: Room?
    var admin: MultometroUser?
    var tableViewData: [TableViewData]?
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
//      let image = UIImage()
//     image.large
        let image = UIImage()
        navigationController?.navigationBar.backIndicatorImage = image
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = image
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(image: UIImage(named: "backArrow"), style: .plain, target: self, action: nil)
//        self.navigationController?.navigationBar.backIndicatorImage?.large
        
        if let room = room {
            admin = room.admin.mulltometroUser
        
            self.room?.userInRooms = room.userInRooms.filter{ $0.userType != .ADMIN}
            navigationItem.title = room.name
            tableViewData = [TableViewData(opened: true, title: "Participants", sectionData: room.userInRooms),
                             TableViewData(opened: false,title: R.string.localizable.rules(), sectionData: room.rules)]
            detailRoomFields.roomFields = room
            detailRoomFields.setupFields()
        }
        
        if room?.admin.mulltometroUserId == AuthManager.getCurrentUserId() {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapCreateQR))
        }
    }
    
    @objc func didTapCreateQR() {
        guard let room = room, let id = room.id else { return }
        performSegue(withIdentifier: R.segue.detailViewController.toQRView, sender: String(id))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationNavigationController = segue.destination as? QRViewController {
            destinationNavigationController.QRString = sender as? String
        }
    
        if let destinationNavigationController = segue.destination as? ApplyFeeViewController, let room = room, let user = sender as? MultometroUser{
//            destinationNavigationController.QRString = sender as? String
            destinationNavigationController.fees = room.rules
            destinationNavigationController.user = user
        }
    }
}

extension DetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let tableViewData = tableViewData else { return 0 }
        
        if tableViewData[section].opened == true {
            guard let sectionData = tableViewData[section].sectionData else { return 0}
            return sectionData.count + 1
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tableViewData = tableViewData else { return UITableViewCell() }
    
        if indexPath.row == 0 { // "HEADER"
            let cell = Bundle.main.loadNibNamed(HeaderCell.identifier, owner: self, options: nil)?.first as! HeaderCell
            cell.title = tableViewData[indexPath.section].title
            cell.setup()
            return cell
        } else {
            
            if let users = tableViewData[indexPath.section].sectionData as? [UserInRoom] {
                let cell = Bundle.main.loadNibNamed(UserCell.identifier, owner: self, options: nil)?.first as! UserCell
            cell.setup(with: users[indexPath.row - 1], admin: room?.admin.mulltometroUser, on: self)
                return cell
            }
        
            if let fees = tableViewData[indexPath.section].sectionData as? [Rule] {
                let cell = Bundle.main.loadNibNamed(FeeCell.identifier, owner: self, options: nil)?.first as! FeeCell
                cell.setup(with: fees[indexPath.row - 1])
                return cell
            }
        
            let cell = Bundle.main.loadNibNamed(HeaderCell.identifier, owner: self, options: nil)?.first as! HeaderCell
            cell.setup()
            return cell
        }
    }
}

extension DetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

       guard var tableViewData = tableViewData else { return }
    
       if indexPath.row == 0 {
       
          if tableViewData[indexPath.section].opened {
             tableViewData[indexPath.section].opened = false
             self.tableViewData = tableViewData
             let sections = IndexSet.init(integer: indexPath.section)
             tableView.reloadSections(sections, with: .none)
          } else {
             tableViewData[indexPath.section].opened = true
             self.tableViewData = tableViewData
             let sections = IndexSet.init(integer: indexPath.section)
             tableView.reloadSections(sections, with: .none)
          }
       }
    }
}

extension DetailViewController: ApplyFeeDelegate {
    func applyFee(in user: MultometroUser) {
        performSegue(withIdentifier: "toApplyFee", sender: user)
    }
}

extension UINavigationItem {
    func backBarButtonItem() -> UIBarButtonItem {
        return UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}

struct TableViewData {
    var opened: Bool!
    var title: String!
    var sectionData: [Any]?
}
