//
//  TodoDispatcher.swift
//  FluxRxSwift
//
//  Created by masaki-shinkawa on 2020/05/14.
//  Copyright © 2020 masaki-shinkawa. All rights reserved.
//

import Foundation
import RxSwift

class TodoDispatcher {
    static let shared = TodoDispatcher()
    let action = DispatchSubject<Action>()
}
