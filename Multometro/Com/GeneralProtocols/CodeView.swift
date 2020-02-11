//
//  CodeView.swift
//  Multometro
//
//  Created by George Gomes on 07/02/20.
//  Copyright © 2020 CrowCode. All rights reserved.
//

import Foundation
import SnapKit

protocol CodeView {
    func buildViewHierarchy()
    func setupConstraints()
    func setupAdditionalConfiguration()
    func setupView()
}

//code template
extension CodeView {
    func setupView() {
        buildViewHierarchy()
        setupConstraints()
        setupAdditionalConfiguration()
    }
}
