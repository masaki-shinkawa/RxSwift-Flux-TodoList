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
        return Realm.Configuration(schemaVersion: 2)
    }

    static func createRealm() -> Realm? {
        do {
            return try Realm(configuration: RealmClient.getRealmConfig())
        } catch {
            return nil
        }
    }

    static func insert<T: RealmBaseObject, U: Decodable, V>(request: T, decode: U) -> Single<V> where U.DecodeType == V {
        return Single<V>.create { single -> Disposable in

            guard let result = request.insert() else {
                single(.error(NSError(domain: "Realmの書き込みに失敗しました。", code: 500)))
                return Disposables.create()
            }
            let decodeData = decode.decode(data: result)
            single(.success(decodeData))

            return Disposables.create()
        }
    }

    static func select<T: RealmBaseObject, U: Decodable, V>(request: T, decode: U) -> Single<V> where U.DecodeType == V {
        return Single<V>.create { single -> Disposable in
            //            guard let realm = RealmClient.createRealm() else {
            //                single(.error(NSError(domain: "Realmの初期化に失敗しました。", code: 500)))
            //                return Disposables.create()
            //            }
            //            let result = realm.objects(T.self)
            let result = request.select()
            let decodeDaga = decode.decode(data: result)
            single(.success(decodeDaga))
            return Disposables.create()
        }
    }
}
