//
//  API.swift
//  CriptoCoins
//
//  Created by Marcel Leite de Farias on 13/04/23.
//  aa

import Foundation

struct API {
    
    static let baseUrl = "https://api.coingecko.com/api/v3"
    static let global = "/global"
    static let coinsById = "/coins/%@"
    static let coinsMarkets = "/coins/markets"
    static let coinsByIdOhlc = "/coins/%@/ohlc"
    static let coinsByIdMarketChart = "/coins/%@/market_chart/range"
    
}
