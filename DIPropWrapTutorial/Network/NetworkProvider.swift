//
//  NetworkProvider.swift
//  DIPropWrapTutorial
//
//  Created by Azizbek Asadov on 02/02/24.
//

import Foundation

protocol NetworkProviding {
    func requestData()
}

struct NetworkProvider: NetworkProviding {
    func requestData() {
        debugPrint("Data requested using the `NetworkProvider`")
    }
}

struct MockNetworkProvider: NetworkProviding {
    func requestData() {
        debugPrint("Data requested using the `MockNetworkProvider`")
    }
}

private struct NetworkProviderKey: InjectionKey {
    static var currentValue: NetworkProviding = NetworkProvider()
}

extension InjectedValues {
    var networkProvider: NetworkProviding {
        get { Self[NetworkProviderKey.self] }
        set { Self[NetworkProviderKey.self] = newValue }
    }
}
