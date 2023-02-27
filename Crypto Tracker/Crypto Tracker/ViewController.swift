//
//  ViewController.swift
//  Crypto Tracker
//
//  Created by Дархан Есенкул on 22.02.2023.
//

import UIKit


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,UICollectionViewDelegate, UICollectionViewDataSource, CryptoNetworkManagerDelegate {
 
    
    

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dateLabel: UILabel!
    
    var mainCrypto = [CryptoModel]()
    var crypto: Set<CryptoModel> = []
    var someArray2 = [CryptoModel]()
    var filteredCrypto:Set<CryptoModel> = []
    var someArray = [CryptoModel]()
    
    var networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isTranslucent = true
        tableView.delegate = self
        tableView.dataSource = self
        collectionView.delegate = self
        collectionView.dataSource = self
        networkManager.cryptoDelegate = self
        networkManager.getCrypto()
    }
    
    func didUpdateCrypto(with crypto: [CryptoModel]) {
        self.mainCrypto = crypto
            for i in 0..<self.mainCrypto.count{
                if self.mainCrypto[i].data_symbols_count ?? 0>10000 && self.mainCrypto[i].price_usd ?? 0.0>0.1 && self.crypto.count<4{
                    self.crypto.insert(self.mainCrypto[i])
                }
                else if self.mainCrypto[i].data_symbols_count ?? 0<10000{
                    self.filteredCrypto.insert(self.mainCrypto[i])
                }
            }
        someArray = Array(filteredCrypto)
        someArray2 = Array(self.crypto)
        someArray = someArray.sorted(by: { first, second -> Bool in
            return first.price_usd ?? 0.0 > second.price_usd ?? 0.0
        })
        someArray2 = someArray2.sorted(by: { first, second -> Bool in
            return first.price_usd ?? 0.0 > second.price_usd ?? 0.0
        })
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.tableView.reloadData()
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
        
        cell.configure(with: someArray[indexPath.section])
        cell.layer.cornerRadius = 10
        cell.clipsToBounds = true
        return cell
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return " "
    }
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 0
//    }
  
    func numberOfSections(in tableView: UITableView) -> Int {
        return someArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return someArray2.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as! CollectionViewCell

        switch indexPath.item {
        case 0:
          cell.colors = [UIColor(red: 255/255, green: 217/255, blue: 1/255, alpha: 1), UIColor(red: 255/255, green: 168/255, blue: 0/255, alpha: 1)]
        case 1:
          cell.colors = [UIColor(red: 88/255, green: 194/255, blue: 216/255, alpha: 1), UIColor(red: 101/255, green: 163/255, blue: 224/255, alpha: 1)]
        case 2:
          cell.colors = [UIColor(red: 165/255, green: 129/255, blue: 229/255, alpha: 1), UIColor(red: 245/255, green: 122/255, blue: 185/255, alpha: 1)]
        case 3:
          cell.colors = [UIColor(red: 7/255, green: 223/255, blue: 173/255, alpha: 1), UIColor(red: 67/255, green: 229/255, blue: 72/255, alpha: 1)]
        default:
          cell.colors = [UIColor.white, UIColor.gray]
        }
        cell.layer.cornerRadius = 10
        cell.clipsToBounds = true
        cell.configure(with: someArray2[indexPath.row])
        dateLabel.text = "Trade date: " + (someArray2[1].data_end ?? "")
        
        return cell
    }
    
    //https://rest-sandbox.coinapi.io/v1/assets/?apikey=2365EB53-C1D2-4765-A671-1111698437C0
    //https://rest.coinapi.io/v1/assets/?apikey=2365EB53-C1D2-4765-A671-1111698437C0

}





