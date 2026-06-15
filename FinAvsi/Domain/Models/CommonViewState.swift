//
//  CommonViewState.swift
//  FinAvsi
//
//  Created by Arsenii Dorogin on 15/06/2026.
//

import Foundation

enum CommonViewState<T> {
    case loading
    case loaded(T)
    case error(message: String)
}
