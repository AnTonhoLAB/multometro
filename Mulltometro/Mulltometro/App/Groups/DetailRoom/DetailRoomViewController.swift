//
//  DetailRoomViewController.swift
//  Mulltometro
//
//  Created by George Gomes on 23/10/18.
//  Copyright © 2018 CrowCode. All rights reserved.
//

import UIKit
import Rswift

class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailRoomFields: DetailRoomFields!
    @IBOutlet weak var tableView: UITableView!
    
    var room: Room?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapCreateQR))
        
        if let room = room {
            navigationItem.title = room.nameRoom
            
//            detailRoomFields.lbAdmin.text = "OPPPA"
        }
        
    }
    
    @objc func didTapCreateQR() {
        guard let room = room, let id = room.id else { return }
        performSegue(withIdentifier: R.segue.detailViewController.toQRView, sender: id)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationNavigationController = segue.destination as? QRViewController{
                destinationNavigationController.QRString = sender as? String
        }
        
    }
}

extension UINavigationItem {
    func backBarButtonItem() -> UIBarButtonItem {
        return UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}
