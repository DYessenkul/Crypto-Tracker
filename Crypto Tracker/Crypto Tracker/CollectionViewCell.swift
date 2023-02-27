//
//  CollectionViewCell.swift
//  Crypto Tracker
//
//  Created by Дархан Есенкул on 24.02.2023.
//

import UIKit
import Kingfisher

class CollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CollectionViewCell"
    
    static func nib() -> UINib{
        return UINib(nibName: "CollectionViewCell", bundle: nil)
    }
    
    var gradientLayer: CAGradientLayer!

      override func layoutSubviews() {
        super.layoutSubviews()

        
        if gradientLayer == nil {
          gradientLayer = CAGradientLayer()
          layer.insertSublayer(gradientLayer, at: 0)
        }

        
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.frame = bounds
      }

      var colors: [UIColor] = [] {
        didSet {
          setNeedsLayout()
        }
      }
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    func configure(with crypto: CryptoModel){
        name.text = crypto.name
        price.text = "$" + String(crypto.price_usd!)
        
        var icon_id = crypto.id_icon?.split(separator: "-")
        var icon_idString = ""
        for i in 0..<(icon_id?.count ?? 0){
            icon_idString.append(String(icon_id![i]))
        }
        if crypto.name == "Binance Coin"{
            guard let imageUrl = URL(string: "https://upload.wikimedia.org/wikipedia/commons/f/fc/Binance-coin-bnb-logo.png") else{return}
            imageView.kf.setImage(with: imageUrl)
        }
        else if crypto.name == "SOL"{
            guard let imageUrl = URL(string: "https://upload.wikimedia.org/wikipedia/en/b/b9/Solana_logo.png") else{return}
            imageView.kf.setImage(with: imageUrl)
        }
        else{
            guard let imageUrl = URL(string: "https://s3.eu-central-1.amazonaws.com/bbxt-static-icons/type-id/png_512/\(icon_idString).png") else{return}
            imageView.kf.setImage(with: imageUrl)
        }
//        guard let imageUrl = URL(string: "https://s3.eu-central-1.amazonaws.com/bbxt-static-icons/type-id/png_512/\(icon_idString).png") else{return}
//        imageView.kf.setImage(with: imageUrl)
        
    }
}
