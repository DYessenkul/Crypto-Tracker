//
//  NetworkManager.swift
//  Crypto Tracker
//
//  Created by Дархан Есенкул on 24.02.2023.
//

import Foundation
import Alamofire

protocol CryptoNetworkManagerDelegate{
    func didUpdateCrypto(with crypto: [CryptoModel])
}
protocol CryptoIconNetworkManagerDelegate{
    func didUpdateCryptoIcon(with icons: [IconModel])
}

struct NetworkManager{
    var cryptoDelegate: CryptoNetworkManagerDelegate?
    var cryptoIconDelegate: CryptoIconNetworkManagerDelegate?
    
    
//    https://rest.coinapi.io/v1/assets/?apikey=F11E7A28-5417-4053-88EF-7D916D7CCEF7
    
    func getCrypto(){
        let urlString = "https://rest.coinapi.io/v1/assets/?apikey=F11E7A28-5417-4053-88EF-7D916D7CCEF7"
        AF.request(urlString).responseDecodable(of: [CryptoModel].self) { response in
            switch response.result{
            case.success(let results):
                var someResult = [CryptoModel]()
                for i in 0..<results.count{
                    if results[i].data_symbols_count ?? 0 > 500{
                        someResult.append(results[i])
                cryptoDelegate?.didUpdateCrypto(with: someResult.sorted{ first, second -> Bool in
                    return first.price_usd ?? 0.0 > second.price_usd ?? 0.0
                })    }
                }
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
//    func getIcon(){
//        let urlString = "https://rest.coinapi.io/v1/assets/icons/55?apikey=2365EB53-C1D2-4765-A671-1111698437C0"
//        AF.request(urlString).responseDecodable(of: [IconModel].self) { response in
//            switch response.result{
//            case.success(let results):
//                cryptoIconDelegate?.didUpdateCryptoIcon(with: results)
//            case.failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
}

//F11E7A28-5417-4053-88EF-7D916D7CCEF7
//6412D165-A401-475F-BED8-B3752F9B4063
//2365EB53-C1D2-4765-A671-1111698437C0
