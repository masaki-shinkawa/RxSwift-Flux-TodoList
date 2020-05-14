//
//  Dependencies.swift
//  FluxRxSwift
//
//  Created by masaki-shinkawa on 2020/05/14.
//  Copyright © 2020 masaki-shinkawa. All rights reserved.
//

import Foundation
import RxSwift

final class Dependencies {

    // MARK: - Properties

    let mainScheduler = MainScheduler.instance
    let backgroundScheduler = ConcurrentDispatchQueueScheduler(qos: .background)

    static let shared = Dependencies()

    // MARK: - Initializers

    private init() {}
}
