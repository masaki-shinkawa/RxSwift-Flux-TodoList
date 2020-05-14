//
//  AppError.swift
//  FluxRxSwift
//
//  Created by masaki-shinkawa on 2020/05/14.
//  Copyright © 2020 masaki-shinkawa. All rights reserved.
//

import Foundation

struct AppError: Error {
    private(set) var message: String?

    init(message: String?) {
        self.message = message
    }
}
