//
//  Decodable.swift
//  FluxRxSwift
//
//  Created by masaki-shinkawa on 2020/05/14.
//  Copyright © 2020 masaki-shinkawa. All rights reserved.
//

import Foundation

protocol Decodable {
    associatedtype DecodeType
    func decode(data: Any?) -> DecodeType
}
