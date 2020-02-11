//
//  ViewController+Presentable.swift
//  Multometro
//
//  Created by George Gomes on 11/02/20.
//  Copyright © 2020 CrowCode. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension UIViewController: Presentable {
    func toPresent() -> UIViewController {
        return self
    }
}
