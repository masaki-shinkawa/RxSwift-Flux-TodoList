//
//  TodoDataStore.swift
//  FluxRxSwift
//
//  Created by masaki-shinkawa on 2020/05/14.
//  Copyright © 2020 masaki-shinkawa. All rights reserved.
//

import Foundation
import RxSwift

class TodoDataStore {
    init() { }

    func add(parameter: TodoAddItemParameter) -> Single<TodoItem?> {
        let request = TodoRequest.add(parameter: parameter)
        let decode = TodoItemDecoder()
        return RealmClient.insert(request: request, decode: decode)
    }

    func show(parameter: TodoShowItemParameter) -> Single<[TodoItem]?> {
        let request = TodoRequest.show(parameter: parameter)
        let decode = TodoItemListDecoder()
        return RealmClient.select(request: request, decode: decode)
    }
}
