//
//  GlobalValuesDataProvider.swift
//  CriptoCoins
//
//  Created by Marcel Leite de Farias on 02/05/23.
//

import Foundation

protocol GlobalValuesDataProviderDelegate: GenericDataProviderDelegate {}

class GlobalValuesDataProvider: DataProviderManager<GlobalValuesDataProviderDelegate, GlobalModel> {
    
    private let globalStore: GlobalStoreProtocol?
    
    init(globalStore: GlobalStoreProtocol = GlobalStore()) {
        self.globalStore = globalStore
    }
    
    
    func fetchGlobal() {
        globalStore?.fetchGlobal(completion: { result, error in
            if let error = error {
                self.delegete?.errorData(self.delegete, error: error)
            }
            
            if let result = result {
                self.delegete?.success(model: result)
            }
            
        })
    }
}
