//
//  InjectionKey.swift
//  DIPropWrapTutorial
//
//  Created by Azizbek Asadov on 02/02/24.
//

import Foundation

public protocol InjectionKey {
    associatedtype Value
    
    static var currentValue: Self.Value { get set }
}

// Acts as a dependency resolver.
struct InjectedValues {
    private static var current = InjectedValues()
    
    static subscript<Key>(key: Key.Type) -> Key.Value where Key : InjectionKey {
        get { key.currentValue }
        set { key.currentValue = newValue }
    }
    
    static subscript<T>(_ keyPath: WritableKeyPath<InjectedValues, T>) -> T {
        get { current[keyPath: keyPath] }
        set { current[keyPath: keyPath] = newValue }
    }
}

@propertyWrapper
struct Injected<T> {
//    class WritableKeyPath<Root, Value> -> A key path that supports reading from and writing to the resulting value.
//    ReferenceWritableKeyPath -> A key path that supports reading from and writing to the resulting value with reference semantics.
    private let keyPath: WritableKeyPath<InjectedValues, T>
    
    var wrappedValue: T {
        get { InjectedValues[keyPath] }
        set { InjectedValues[keyPath] = newValue }
    }
    
    init(keyPath: WritableKeyPath<InjectedValues, T>) {
        self.keyPath = keyPath
    }
}
