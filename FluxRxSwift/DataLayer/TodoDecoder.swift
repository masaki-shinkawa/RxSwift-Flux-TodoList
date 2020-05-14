//
//  TodoDecoder.swift
//  FluxRxSwift
//
//  Created by masaki-shinkawa on 2020/05/14.
//  Copyright © 2020 masaki-shinkawa. All rights reserved.
//

import Foundation
import RealmSwift

struct TodoItemDecoder: Decodable {
    typealias DecodeType = TodoItem?

    func decode(data: Any?) -> TodoItem? {
        guard let data = data as? TodoItem else { return nil }
        return TodoItem(id: data.id, title: data.title, createdAt: data.createdAt, updatedAt: data.updatedAt)
    }
}
