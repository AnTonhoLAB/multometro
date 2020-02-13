//
//  GroupsView.swift
//  Multometro
//
//  Created by George Gomes on 13/02/20.
//  Copyright © 2020 CrowCode. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol GroupsViewComponents: UIView {
    /// To read UI informations
//    var emailObservable: Observable<String> { get }
//    var passwordObservable: Observable<String> { get }
//    var enterObservable: Observable<Void> { get }
//    /// To change UI informations
//    var enterIsValide: Binder<Bool> { get }
}

class GroupsView: UIView, GroupsViewComponents {
//    var emailObservable: Observable<String>
//    var passwordObservable: Observable<String>
//    var enterObservable: Observable<Void>
//    var enterIsValide: Binder<Bool>
    
    //MARK: - Constants
    private let roundRadius: CGFloat = 8.0
    // MARK: - UIComponets
       private lazy var fieldsView: UIView = {
           let view = UIView(frame: .zero)
           view.backgroundColor = .darkGray
           view.roundedCornerColor(radius: roundRadius)
           return view
       }()

    //MARK: - Initializers
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        self.backgroundColor = .yellow
        self.setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GroupsView: CodeView {
    //MARK: - UISetup
    func buildViewHierarchy() {
        self.addSubview(fieldsView)
    }

    func setupConstraints() {

        fieldsView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(16).priority(900)
            make.top.equalToSuperview().offset(16).priority(900)
            make.right.equalToSuperview().inset(16).priority(900)
            make.bottom.equalToSuperview().inset(16).priority(900)
        }

    }

    func setupAdditionalConfiguration() {

    }
}

