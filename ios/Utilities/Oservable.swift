//
//  Oservable.swift
//  AmazonIVSProject
//
//  Created by macmini on 09/01/25.
//

import Foundation

class Observable<T> {
    typealias Observer = (T) -> ()
    private var observer: Observer?

    var value: T {
        didSet {
            observer?(value)
        }
    }

    init(_ v: T) {
        value = v
    }

    func add(_ observer: Observer?) {
        self.observer = observer
    }

    func addAndNotify(_ observer: Observer?) {
        self.observer = observer
        observer?(value)
    }

    func notify() {
        observer?(value)
    }
}
