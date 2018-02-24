//
//  DetailVenuesController.swift
//  IstanbulCityGuide
//
//  Created by Burak Şentürk on 24.02.2018.
//  Copyright © 2018 Burak Şentürk. All rights reserved.
//

import UIKit
class DetailVenuesController: UIViewController {
    
    let venuesImageView : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .red
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let detailTextView : UITextView = {
       let tv = UITextView()
        tv.backgroundColor = .blue
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    let mapButton : UIButton = {
       let button = UIButton(type: .system)
        button.setTitle("SEE ON THE MAP", for: .normal)
        button.titleLabel?.font = UIFont(name: "Courier-Bold", size: 18)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = Constants.getIns().mainBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    func setupUI(){
        view.addSubview(venuesImageView)
        venuesImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12).isActive = true
        venuesImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        venuesImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        venuesImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        venuesImageView.layer.cornerRadius = 150 / 2
        
        view.addSubview(detailTextView)
        detailTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        detailTextView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        detailTextView.topAnchor.constraint(equalTo: venuesImageView.bottomAnchor, constant: 12).isActive = true
        detailTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        detailTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
        
        view.addSubview(mapButton)
        mapButton.topAnchor.constraint(equalTo: detailTextView.bottomAnchor, constant: 12).isActive = true
        mapButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mapButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        mapButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
         setupUI()
    }
}
