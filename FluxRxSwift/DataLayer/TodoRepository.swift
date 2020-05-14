//
//  TodoRepository.swift
//  FluxRxSwift
//
//  Created by masaki-shinkawa on 2020/05/14.
//  Copyright © 2020 masaki-shinkawa. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift

public protocol TodoRepositoryProtocol {
    func add(parameter: TodoAddItemParameter) -> Single<TodoItem>
}

class TodoRepository: TodoRepositoryProtocol {
    private let dataStore: TodoDataStore

    public init() {
        dataStore = TodoDataStore()
    }

    func add(parameter: TodoAddItemParameter) -> Single<TodoItem> {
        dataStore.add(parameter: parameter)
            .map { data in
                guard let data = data else {
                    throw AppError(message: "add error.")
                }
                return data
        }
    }
}
