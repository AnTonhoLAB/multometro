//
//  ApplyFeeViewController.swift
//  Mulltometro
//
//  Created by George Gomes on 23/11/18.
//  Copyright © 2018 CrowCode. All rights reserved.
//

import UIKit

class ApplyFeeViewController: UIViewController {
    
    @IBOutlet weak var tvFees: UITableView! {
        didSet {
            tvFees.dataSource = self
            tvFees.delegate = self
            let nib = UINib(nibName: FeeCell.identifier, bundle: nil)
            tvFees.register(nib, forCellReuseIdentifier: FeeCell.identifier)
            tvFees.estimatedRowHeight = 180
            tvFees.rowHeight = UITableView.automaticDimension
        }
    }
    
//    var 
    var user: MulltometroUser?
    var fees: [Fee]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tvFees.reloadData()
    }

    @IBAction func didTapCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension ApplyFeeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let fees = fees else { return 0 }
        return fees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let fees = fees else { return UITableViewCell() }
        let cell = Bundle.main.loadNibNamed(FeeCell.identifier, owner: self, options: nil)?.first as! FeeCell
        cell.setup(with: fees[indexPath.row])
        return cell
    }
}

extension ApplyFeeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
