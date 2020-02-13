//
//  GroupsViewModel.swift
//  Multometro
//
//  Created by George Gomes on 13/02/20.
//  Copyright © 2020 CrowCode. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class GroupsViewModel: ViewModelType {

    private var groupsUseCase: GroupsUseCase

    struct Input {
        let name: Observable<String>
        let password: Observable<String>
        let didTapLogin: Observable<Void>
    }

    struct Output {
//        let isValid: Driver<Bool>
//        let networkingStatus: Driver<NetworkingState<MultometroUser>>
    }

    init(_ groupsUseCase: GroupsUseCase) {
        self.groupsUseCase = groupsUseCase
    }

    func transform(input: GroupsViewModel.Input) -> GroupsViewModel.Output {
        return Output()
    }
}
