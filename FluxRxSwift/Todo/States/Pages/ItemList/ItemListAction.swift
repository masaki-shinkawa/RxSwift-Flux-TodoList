//
//  ItemListAction.swift
//  FluxRxSwift
//
//  Created by masaki-shinkawa on 2020/05/14.
//  Copyright © 2020 masaki-shinkawa. All rights reserved.
//

import Foundation
import RxSwift

protocol TodoActionProtocol {
    func add(title: String)
}

class ItemListActionCreator: TodoActionProtocol {
    fileprivate let repository: TodoRepositoryProtocol
    fileprivate let dispatcher: TodoDispatcher
    fileprivate let disposeBag: DisposeBag = DisposeBag()

    init(repository: TodoRepositoryProtocol, dispatcher: TodoDispatcher) {
        self.repository  = repository
        self.dispatcher  = dispatcher
    }

    func add(title: String) {
        repository.add(parameter: TodoAddItemParameter(title: title))
            .map { (todoItem: TodoItem) -> TodoActions.AddTodo in
                return TodoActions.AddTodo(todoItem: todoItem)
        }
        .subscribeOn(Dependencies.shared.backgroundScheduler)
        .subscribe(
            onSuccess: { [weak self] action in
                self?.dispatcher.action.dispatch(action)
            },
            onError: { [] error in
                print(error)
        }
        ).disposed(by: disposeBag)
    }
}

enum TodoActions {
    struct AddTodo: Action {
        var todoItem: TodoItem
    }
}
