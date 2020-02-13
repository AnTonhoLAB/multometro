//
//  GroupsUseCase.swift
//  Multometro
//
//  Created by George Gomes on 13/02/20.
//  Copyright © 2020 CrowCode. All rights reserved.
//

import Foundation



class GroupsUseCase {
    private var authRequester: AuthRequestable

    init(authRequester: AuthRequestable) {
        self.authRequester = authRequester
    }
}
