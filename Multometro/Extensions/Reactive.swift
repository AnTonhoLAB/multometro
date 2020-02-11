//
//  Reactive.swift
//  Multometro
//
//  Created by George Gomes on 11/02/20.
//  Copyright © 2020 CrowCode. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base : UIButton {
   public var valid : Binder<Bool> {
        return Binder(self.base) { button, valid in
            button.isEnabled = valid
            button.setTitleColor(valid ? .white : .black, for: .normal)
        }
    }
}
