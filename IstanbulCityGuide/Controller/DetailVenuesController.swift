//
//  DetailVenuesController.swift
//  IstanbulCityGuide
//
//  Created by Burak Şentürk on 24.02.2018.
//  Copyright © 2018 Burak Şentürk. All rights reserved.
//

import UIKit
import CoreData

protocol FavouritesVenuesDelegate {
    func didFav(favVenue : Favourites)
}

class DetailVenuesController: UIViewController {
    var delegate : FavouritesVenuesDelegate?
    
    var venuesDetail : TouristicVenues?{
        didSet{
            guard let image = venuesDetail?.image else { return }
            //guard let name = venuesDetail?.name else { return}
            guard let detail = venuesDetail?.detail else { return }
            let decodedData : Data = Data(base64Encoded: image, options: .ignoreUnknownCharacters)!
            print(decodedData)
            let decodedImage = UIImage(data: decodedData)
            venuesImageView.image = decodedImage
            
            //navigationItem.title = name
            detailTextView.text = detail
            
            
            
        }
    }
    
    //var venuesDetailFromFav : Favourites? //{
//        didSet{
//            guard let image = venuesDetailFromFav?.image else { return }
//            guard let name = venuesDetailFromFav?.name else { return }
//            guard let detail = venuesDetailFromFav?.detail else { return }
//
//            venuesImageView.image = UIImage(data: image)
//            navigationItem.title = name
//            detailTextView.text = detail
//        }
    //}
    
    var venuesObject = [Favourites]()
   
    
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
    
    let favButton : UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "icons8-star-filled-96-2"), for: .normal)
        button.addTarget(self, action: #selector(handleFav), for: .touchUpInside)
        return button
    }()
    
    @objc func handleShowMap(){
        
    
    UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: .curveEaseOut, animations: {
    self.mapButton.bounds = CGRect(x: self.mapButton.bounds.origin.x - 20, y: self.mapButton.bounds.origin.y, width: self.mapButton.bounds.width + 60, height: self.mapButton.bounds.height)
    
    }) { (_) in
        guard let name = self.venuesDetail?.name else { return}
        guard let lat = self.venuesDetail?.lat else { return }
        guard let lng = self.venuesDetail?.lng else { return }
        
        let mapController = MapController()
        mapController.name = name
        mapController.lat = lat
        mapController.lng = lng
        let backItem = UIBarButtonItem()
        backItem.title = ""
        self.navigationItem.backBarButtonItem = backItem
        self.navigationController?.pushViewController(mapController, animated: true)
        self.mapButton.bounds = CGRect(x: self.mapButton.bounds.origin.x - 20, y: self.mapButton.bounds.origin.y, width: self.mapButton.bounds.width - 60, height: self.mapButton.bounds.height)
    }

    }
    func flashAnimation(){
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.5
        flash.fromValue = 1
        flash.toValue = 0.1
        flash.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = 2
        favButton.layer.add(flash, forKey: nil)
    }

    @objc func handleFav(){
        
        if UserDefaults.isExists(key: (venuesDetail?.name)!){
            flashAnimation()
            favButton.setImage(#imageLiteral(resourceName: "icons8-star-filled-96-2"), for: .normal)
            UserDefaults.standard.removeObject(forKey: (venuesDetail?.name)!)
            
            
            
        }else{
                flashAnimation()
        favButton.setImage(#imageLiteral(resourceName: "icons8-star-filled-96"), for: .normal)
            UserDefaults.standard.set(1, forKey: (venuesDetail?.name)!)
            guard let name = venuesDetail?.name else { return}
            guard let image = venuesDetail?.image else { return }
            guard let detail = venuesDetail?.detail else { return }
            guard let lat = venuesDetail?.lat else { return }
            guard let lng = venuesDetail?.lng else { return }
//            let decodedData : Data = Data(base64Encoded: image, options: .ignoreUnknownCharacters)!
//            let imageData = UIImage(data: decodedData)
            
            let context = CoreDataManager.shared.persistenceContainer.viewContext
            let venues = NSEntityDescription.insertNewObject(forEntityName: "Favourites", into: context)
            
            venues.setValue(name, forKey: "name")
            
            self.delegate?.didFav(favVenue: venues as! Favourites)
            
            //let imageBinaryData = UIImageJPEGRepresentation(imageData!, 0.8)
            venues.setValue(image, forKey: "image")
            venues.setValue(detail, forKey: "detail")
            venues.setValue(lat, forKey: "lat")
            venues.setValue(lng, forKey: "lng")
            do{
             try context.save()
               
                
            }catch let err {
                print(err)
            }
            
        }
    }

    var centerXImageView : NSLayoutConstraint!
    var centerXTextView : NSLayoutConstraint!
    func setupUI(){
        
        view.addSubview(venuesImageView)
        venuesImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
//        centerXImageView = venuesImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
//        centerXImageView?.isActive = true
        venuesImageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        venuesImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
//        venuesImageView.layer.cornerRadius = 150 / 2

        view.addSubview(detailTextView)
        centerXTextView = detailTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        centerXTextView.isActive = true
        detailTextView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        detailTextView.topAnchor.constraint(equalTo: venuesImageView.bottomAnchor).isActive = true
        detailTextView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        detailTextView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true

        view.addSubview(mapButton)
        mapButton.topAnchor.constraint(equalTo: detailTextView.bottomAnchor, constant: 12).isActive = true
        mapButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mapButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        mapButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(favButton)
       
        NSLayoutConstraint.activate([
            favButton.topAnchor.constraint(equalTo: mapButton.bottomAnchor, constant: 8),
            favButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            favButton.widthAnchor.constraint(equalToConstant: 50),
            favButton.heightAnchor.constraint(equalToConstant: 50)
            ])
        
        
    }
    
    func setupAnimation(){
//        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
//            self.venuesImageView.center.x -= self.view.bounds.width
//        }, completion: nil)
//
//        UIView.animate(withDuration: 0.5, delay: 0.3, options: .curveEaseOut, animations: {
//            self.detailTextView.center.x -= self.view.bounds.width
//        }, completion: nil)
        
        
        UIView.animate(withDuration: 0.5, delay: 0.2, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: {(_) in
            let label = UILabel()
            label.text = self.venuesDetail?.name
           
            label.textColor = .white
            label.font = UIFont.boldSystemFont(ofSize: 18)
            
            let fadeTextAnimation = CATransition()
            fadeTextAnimation.duration = 0.5
            fadeTextAnimation.type = kCATransitionFade
            self.navigationController?.navigationBar.layer.add(fadeTextAnimation, forKey: "fadeText")
            
           self.navigationItem.titleView = label
        })
        
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .white
        guard let name = self.venuesDetail?.name else { return }
      //  guard let nameFromFav = self.venuesDetailFromFav?.name else { return }
        
        if UserDefaults.isExists(key: name) {
            favButton.setImage(#imageLiteral(resourceName: "icons8-star-filled-96"), for: .normal)
        }else {
            favButton.setImage(#imageLiteral(resourceName: "icons8-star-filled-96-2"), for: .normal)
        }
        self.venuesObject = CoreDataManager.shared.fetchVenues()
        venuesObject.forEach { (fav) in
            print(fav.name)
        }
        
        
        setupUI()
        setupAnimation()
        
        
        
    }
   
}
