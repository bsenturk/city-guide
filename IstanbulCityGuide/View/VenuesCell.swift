//
//  VenuesCell.swift
//  IstanbulCityGuide
//
//  Created by Burak Şentürk on 24.02.2018.
//  Copyright © 2018 Burak Şentürk. All rights reserved.
//

import UIKit
class VenuesCell: UICollectionViewCell {
    
    
    let venueImages : UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .blue
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.clipsToBounds = true
        return iv
    }()
    
    let venueNameLabel : UILabel = {
       let label = UILabel()
        label.text = "Ayasofya"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    
    lazy var favouritesButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "favStar"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleFav), for: .touchUpInside)
        return button
    }()
    
    let seperatorLine : UIView = {
       let view = UIView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    @objc func handleFav(){
        print("Handling like...")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(venueImages)
        venueImages.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        venueImages.widthAnchor.constraint(equalToConstant: 50).isActive = true
        venueImages.heightAnchor.constraint(equalToConstant: 50).isActive = true
        venueImages.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        venueImages.layer.cornerRadius = 50 / 2
        
        addSubview(venueNameLabel)
        venueNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        venueNameLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        venueNameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        venueNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        addSubview(favouritesButton)
        favouritesButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        favouritesButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        favouritesButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        favouritesButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        addSubview(seperatorLine)
        seperatorLine.topAnchor.constraint(equalTo: bottomAnchor).isActive = true
        seperatorLine.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        seperatorLine.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        seperatorLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
