//
//  CryptoModel.swift
//  Crypto Tracker
//
//  Created by Дархан Есенкул on 24.02.2023.
//

import Foundation

struct CryptoModel: Decodable, Hashable{
    let asset_id: String?
    let name: String?
    let price_usd: Float?
    let id_icon: String?
    let date_trade_end: String?
    let data_symbols_count: Int?
    let data_end: String?
}


struct IconModel: Decodable, Hashable{
    let asset_id: String
    let url: String
}
