//
//  CoinStore.swift
//  CriptoCoins
//
//  Created by Marcel Leite de Farias on 25/04/23.
//

import Foundation

protocol CoinsStoreProtocol: GerericStoreProtocol {
    func fetchLisCoins(by vsCurrency: String,
                       with crytocurrency: [String]?,
                       orderBy order: String,
                       total parPage: Int,
                       page: Int,
                       percentagePrice: String,
                       completion: @escaping completion<[CoinModel]?>)
    func fetchHistorical(by id: String,
                         currency vsCurrency: String,
                         from: String,
                         to: String,
                         completion: @escaping completion<CoinsMarketChartModel?>)
    func fetchHistorical(by id: String,
                         currency vsCurrency: String,
                         of days: String,
                         completion: @escaping completion<[GraphicDataModel]?>)
    func fetchCoin(by id: String, completion: @escaping completion<CurrentDataModel?>)
}



class CoinsStore: GenericStoreRequest, CoinsStoreProtocol {
    
    func fetchLisCoins(by vsCurrency: String,
                       with crytocurrency: [String]?,
                       orderBy order: String,
                       total parPage: Int,
                       page: Int,
                       percentagePrice: String,
                       completion: @escaping completion<[CoinModel]?>) {
        
        do {
            guard let url = try CoinsRouter.coinsMarket(currency: vsCurrency,
                                                        criptocurrency: crytocurrency,
                                                        order: order,
                                                        parPage: parPage,
                                                        page: page,
                                                        percantage: percentagePrice).asURLRequest() else {
                return completion(nil, error)
            }
            request(url: url, completion: completion)
        } catch let error {
            completion(nil, error)
        }
    }
    
    func fetchHistorical(by id: String,
                         currency vsCurrency: String,
                         from: String,
                         to: String,
                         completion: @escaping completion<CoinsMarketChartModel?>) {
        
        do {
            guard let url = try CoinsRouter.coinsMarketChart(id: id, currency: vsCurrency, from: from, to: to).asURLRequest() else {
                return completion(nil, error)
            }
            request(url: url, completion: completion)
        } catch let error {
            completion(nil, error)
        }
    }
    
    func fetchHistorical(by id: String,
                         currency vsCurrency: String,
                         of days: String,
                         completion: @escaping completion<[GraphicDataModel]?>) {
        
        do {
            guard let url = try CoinsRouter.coinsMarketOhlc(id: id, currency: vsCurrency, days: days).asURLRequest() else {
                return completion(nil, error)
            }
            request(url: url, completion: completion)
        } catch let error {
            completion(nil, error)
        }
    }
    
    func fetchCoin(by id: String, completion: @escaping completion<CurrentDataModel?>) {
        do {
            guard let url = try CoinsRouter.coinsById(id: id).asURLRequest() else {
                return completion(nil, error)
            }
            request(url: url, completion: completion)
        } catch let error {
            completion(nil, error)
        }
    }
    
}
