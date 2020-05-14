//
//  Dispatcher.swift
//  FluxRxSwift
//
//  Created by masaki-shinkawa on 2020/05/14.
//  Copyright © 2020 masaki-shinkawa. All rights reserved.
//

import Foundation
import RxSwift

class DispatchSubject<Element>: ObservableType, ObserverType {
    typealias E = Element
    fileprivate let subject = PublishSubject<Element>()

    init() {}

    func dispatch(_ value: Element) {
        on(.next(value))
    }

    func subscribe<O: ObserverType>(_ observer: O) -> Disposable where O.Element == E {
        return subject.subscribe(observer)
    }

    func on(_ event: Event<Element>) {
        subject.on(event)
    }
}
