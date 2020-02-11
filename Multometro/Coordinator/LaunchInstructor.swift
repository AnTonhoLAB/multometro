//
//  LaunchInstructor.swift
//  Multometro
//
//  Created by George Gomes on 07/02/20.
//  Copyright © 2020 CrowCode. All rights reserved.
//

import Foundation

fileprivate var onboardingWasShown = false
fileprivate var isAutorized = false

enum LaunchInstructor {

    case main
    case auth
    case onboarding

    // MARK: - Public methods

    static func configure( tutorialWasShown: Bool = onboardingWasShown, isAutorized: Bool = isAutorized) -> LaunchInstructor {

        switch (tutorialWasShown, isAutorized) {
        case (true, false), (false, false): return .auth
        case (false, true): return .onboarding
        case (true, true): return .main
        }
    }
}
