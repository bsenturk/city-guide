//
//  FavouritesCell.swift
//  IstanbulCityGuide
//
//  Created by Burak Şentürk on 6.03.2018.
//  Copyright © 2018 Burak Şentürk. All rights reserved.
//

import UIKit
class FavouritesCell: UITableViewCell {
    
    var favourites : Favourites? {
        didSet{
            guard let image = favourites?.image else { return }
            guard let name = favourites?.name else { return}
            
            let decodedData : Data = Data(base64Encoded: image, options: .ignoreUnknownCharacters)!
            
            venuesImageView.image = UIImage(data: decodedData)
            venuesName.text = name
            
            }
        }
    
    
    let venuesImageView : UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.clipsToBounds = true
        
        return iv
    }()
    
    let venuesName : UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
        
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(venuesImageView)
        addSubview(venuesName)
        NSLayoutConstraint.activate([
            venuesImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 12),
            venuesImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            venuesImageView.widthAnchor.constraint(equalToConstant: 50),
            venuesImageView.heightAnchor.constraint(equalToConstant: 50),
            
//            venuesName.topAnchor.constraint(equalTo: topAnchor),
            venuesName.leftAnchor.constraint(equalTo: venuesImageView.rightAnchor, constant: 8),
            venuesName.rightAnchor.constraint(equalTo: rightAnchor),
//            venuesName.bottomAnchor.constraint(equalTo: bottomAnchor)
            
            venuesName.heightAnchor.constraint(equalTo: heightAnchor)
            
            ])
        
        venuesImageView.layer.cornerRadius = 50 / 2
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
