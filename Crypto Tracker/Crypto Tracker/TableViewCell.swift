//
//  TableViewCell.swift
//  Crypto Tracker
//
//  Created by Дархан Есенкул on 24.02.2023.
//

import UIKit
import Kingfisher

class TableViewCell: UITableViewCell {

    static let identifier = "TableViewCell"
    
    static func nib() -> UINib{
        return UINib(nibName: "TableViewCell", bundle: nil)
    }
    
    
    @IBOutlet weak var icon: UIImageView!
//    @IBOutlet weak var asset_id: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var coinCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configure(with crypto: CryptoModel){
//        asset_id.text = crypto.asset_id
        name.text = crypto.name
        price.text = "$"+String(crypto.price_usd ?? 0.0)
        coinCount.text = String(crypto.data_symbols_count ?? 0) + " coin"
        
        var icon_id = crypto.id_icon?.split(separator: "-")
        var icon_idString = ""
        for i in 0..<(icon_id?.count ?? 0){
            icon_idString.append(String(icon_id![i]))
        }
        if crypto.name == "Binance Coin"{
            guard let imageUrl = URL(string: "https://upload.wikimedia.org/wikipedia/commons/f/fc/Binance-coin-bnb-logo.png") else{return}
            icon.kf.setImage(with: imageUrl)
        }
        else if crypto.name == "SOL"{
            guard let imageUrl = URL(string: "https://upload.wikimedia.org/wikipedia/en/b/b9/Solana_logo.png") else{return}
            icon.kf.setImage(with: imageUrl)
        }
        else{
            guard let imageUrl = URL(string: "https://s3.eu-central-1.amazonaws.com/bbxt-static-icons/type-id/png_512/\(icon_idString).png") else{return}
            icon.kf.setImage(with: imageUrl)
        }
    }

}
