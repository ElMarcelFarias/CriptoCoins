//
//  CoinsListInteractor.swift
//  CriptoCoins
//
//  Created by Marcel Leite de Farias on 02/05/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol CoinsListBusinessLogic {
    func doFethcGlobalValues(request: CoinsList.FetchGlobalValues.Request)
    func doFetchListCoins(request: CoinsList.FetchListCoins.Request)
}

protocol CoinsListDataStore {
  //var name: String { get set }
}

class CoinsListInteractor: CoinsListBusinessLogic, CoinsListDataStore   {
    
    var presenter: CoinsListPresentationLogic?
    var globalValuesWorker: GlobalValuesWorker?
    var coinsListWorker: CoinsListWorker?
  
    init(presenter: CoinsListPresentationLogic = CoinsListPresenter(), globalValuesWorker: GlobalValuesWorker = GlobalValuesWorker(),
         coinsListWorker: CoinsListWorker = CoinsListWorker()) {
        self.presenter = presenter
        self.globalValuesWorker = globalValuesWorker
        self.coinsListWorker = coinsListWorker
    }
    
    func doFethcGlobalValues(request: CoinsList.FetchGlobalValues.Request) {
        globalValuesWorker?.doFetchGlobalValues(completion: { result in
            switch result {
                case .success(let globalModel):
                    self.createGlobalValuesResponse(baseCoin: request.baseCoin, globalModel: globalModel)
                case .failure(let error):
                    self.presenter?.presentError(error: error)
            }
        })
    }
    
    func doFetchListCoins(request: CoinsList.FetchListCoins.Request) {
        let baseCoin = request.baseCoin
        let orderBy = request.orderBy
        let top = request.top
        let percentagePrice = request.pricePercentage
        
        coinsListWorker?.doFetchListCoins(baseCoin: baseCoin,
                                          orderBy: orderBy,
                                          top: top,
                                          percentagePrice: percentagePrice,
                                          completion: { result in
            switch result {
                case .success(let listCoinsModel):
                    self.createListCoinsResponse(request: request, listCoins: listCoinsModel)
                case .failure(let error):
                    self.presenter?.presentError(error: error)
            }
        })
    }
    
    private func createGlobalValuesResponse(baseCoin: String, globalModel: GlobalModel?) {
        if let globalModel = globalModel {
            let totalMarketCap = globalModel.data.totalMarketCap.filter { $0.key == baseCoin }
            let totalVolume = globalModel.data.totalVolume.filter { $0.key == baseCoin }
            
            let response = CoinsList.FetchGlobalValues.Response(
                baseCoin: baseCoin,
                totalMarketCap: totalMarketCap,
                totalVolume: totalVolume
            )
            
            presenter?.presentGlobalValues(response: response)
        } else {
            self.presenter?.presentError(error: .undefinedError)
        }
    }
    
    private func createListCoinsResponse(request: CoinsList.FetchListCoins.Request, listCoins: [CoinModel]?){
        if let listCoins = listCoins {
            func priceChangePercentage(pricePercentage: String, coin: CoinModel) -> Double {
                if pricePercentage == "1h" {
                    return coin.priceChangePercentage1H ?? 0.00
                } else if pricePercentage == "24h" {
                    return coin.priceChangePercentage24H ?? 0.00
                } else if pricePercentage == "7d" {
                    return coin.priceChangePercentage7D ?? 0.00
                } else {
                    return coin.priceChangePercentage30D ?? 0.00
                }
            }
            let response = listCoins.map { coin in
                return CoinsList.FetchListCoins.Response(
                    baseCoin: request.baseCoin,
                    id: coin.id,
                    symbol: coin.symbol,
                    name: coin.name,
                    image: coin.image,
                    currentPrice: coin.currentPrice ?? 0.00,
                    marketCap: coin.marketCap ?? 0.00,
                    marketCapRank: coin.marketCapRank,
                    priceChangePercentage: priceChangePercentage(pricePercentage: request.pricePercentage, coin: coin)
                )
            }
            
            presenter?.presentListCoins(response: response)
        } else {
            self.presenter?.presentError(error: .undefinedError)
        }
        
    }
   
}
