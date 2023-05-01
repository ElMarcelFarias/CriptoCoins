//
//  GenericDataProvider.swift
//  CriptoCoins
//
//  Created by Marcel Leite de Farias on 13/04/23.
//
//  Provedor de dados genérico

import Foundation

protocol GenericDataProviderDelegate {
    func success(model: Any)
    func errorData(_ provider: GenericDataProviderDelegate?, error: Error)
}

class DataProviderManager<T, S> {
    var delegete: T?
    var model: S?
}
