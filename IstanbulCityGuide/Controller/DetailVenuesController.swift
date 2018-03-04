//
//  DetailVenuesController.swift
//  IstanbulCityGuide
//
//  Created by Burak Şentürk on 24.02.2018.
//  Copyright © 2018 Burak Şentürk. All rights reserved.
//

import UIKit
class DetailVenuesController: UIViewController {
    
    var venuesDetail : TouristicVenues?{
        didSet{
            guard let image = venuesDetail?.image else { return }
            guard let name = venuesDetail?.name else { return}
            guard let detail = venuesDetail?.detail else { return }
            let decodedData : Data = Data(base64Encoded: image, options: .ignoreUnknownCharacters)!
            print(decodedData)
            let decodedImage = UIImage(data: decodedData)
            venuesImageView.image = decodedImage
            
            navigationItem.title = name
            detailTextView.text = detail
            
            
            
        }
    }
   
    
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
        tv.backgroundColor = Constants.getIns().mainBlue
        tv.textColor = .white
        tv.font = UIFont.boldSystemFont(ofSize: 14)
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    let mapButton : UIButton = {
       let button = UIButton(type: .system)
        button.setTitle("SEE ON THE MAP", for: .normal)
        button.titleLabel?.font = UIFont(name: "Courier", size: 18)
        button.addTarget(self, action: #selector(handleShowMap), for: .touchUpInside)
        button.setTitleColor(Constants.getIns().mainBlue, for: .normal)
        button.layer.borderColor = Constants.getIns().mainBlue.cgColor
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func handleShowMap(){
        let mapController = MapController()
        mapController.touristicVenues = venuesDetail
        navigationController?.pushViewController(mapController, animated: true)
        
    }
    
    
    func setupUI(){
        
       
        

        view.addSubview(venuesImageView)
        venuesImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12).isActive = true
        venuesImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        venuesImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        venuesImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        venuesImageView.layer.cornerRadius = 150 / 2

        view.addSubview(detailTextView)
        detailTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        detailTextView.heightAnchor.constraint(equalToConstant: 300).isActive = true
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
