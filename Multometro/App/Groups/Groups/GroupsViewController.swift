//
//  GroupsViewController.swift
//  Multometro
//
//  Created by George Gomes on 13/02/20.
//  Copyright © 2020 CrowCode. All rights reserved.
//

import UIKit
import RxSwift

protocol GroupsFlowDelegate: class {

}

class GroupsViewController: UpdatableViewController {

    private let disposeBag: DisposeBag = DisposeBag()
    private var groupsView: GroupsViewComponents!
    private var viewModel: GroupsViewModel!

    weak var flowDelegate: GroupsFlowDelegate?

    override func loadView() {
        self.view = groupsView
    }

    init(with view: GroupsView, and viewModel: GroupsViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.groupsView = view
        self.viewModel = viewModel
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

}
