//
//  RealmClient.swift
//  FluxRxSwift
//
//  Created by masaki-shinkawa on 2020/05/13.
//  Copyright © 2020 masaki-shinkawa. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift

final class RealmClient {
    static func getRealmConfig() -> Realm.Configuration {
        return Realm.Configuration(schemaVersion: 1)
    }

    static func createRealm() -> Realm? {
        do {
            return try Realm(configuration: RealmClient.getRealmConfig())
        } catch {
            return nil
        }
    }

    static func insert<T: Object, U: Decodable, V>(request: T, decode: U) -> Single<V> where U.DecodeType == V {
        return Single<V>.create { single -> Disposable in
            guard let realm = RealmClient.createRealm() else {
                single(.error(NSError(domain: "Realmの初期化に失敗しました。", code: 500)))
                return Disposables.create()
            }

            do {
                try realm.write({
                    realm.add(request, update: .error)
                })
                let decodeData = decode.decode(data: request)
                single(.success(decodeData))
            } catch {
                single(.error(NSError(domain: "Realmの書き込みに失敗しました。", code: 500)))
                return Disposables.create()
            }

            return Disposables.create()
        }
    }

    static func update<T: Object>(request: T) -> Single<T> {
        return Single<T>.create { single -> Disposable in
            guard let realm = RealmClient.createRealm() else {
                single(.error(NSError(domain: "Realmの初期化に失敗しました。", code: 500)))
                return Disposables.create()
            }

            do {
                try realm.write({
                    realm.add(request, update: .modified)
                })
                single(.success(request))
            } catch {
                single(.error(NSError(domain: "Realmの書き込みに失敗しました。", code: 500)))
                return Disposables.create()
            }

            return Disposables.create()
        }
    }

    static func delete<T: Object>(request: T) -> Single<T> {
        return Single<T>.create { single -> Disposable in
            guard let realm = RealmClient.createRealm() else {
                single(.error(NSError(domain: "Realmの初期化に失敗しました。", code: 500)))
                return Disposables.create()
            }

            do {
                try realm.write({
                    realm.delete(request)
                })
                single(.success(request))
            } catch {
                single(.error(NSError(domain: "Realmの書き込みに失敗しました。", code: 500)))
                return Disposables.create()
            }

            return Disposables.create()
        }
    }
}
