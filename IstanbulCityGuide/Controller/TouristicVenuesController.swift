//
//  TouristicVenuesController.swift
//  IstanbulCityGuide
//
//  Created by Burak Şentürk on 24.02.2018.
//  Copyright © 2018 Burak Şentürk. All rights reserved.
//

import UIKit
class TouristicVenuesController: UICollectionViewController , UICollectionViewDelegateFlowLayout {
    
    var venues = [TouristicVenues]()
    
     func fetchVenues(){
        guard let url = URL(string: Constants.getIns().url) else { return}
       
       print(url)
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let err = error{
                print("Failed to request",err)
            }
            
            
            if let response = response as? HTTPURLResponse{
                if response.statusCode != 200 {
                    print("Status code is not equal to 200")
                    print(response.statusCode)
                }
                else{
                    print("Status code is equal to 200")
                }
            }
            guard let data = data else { return }
            do {
                 let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as AnyObject
            
               
                guard let venues = json["venues"] as? [[String : AnyObject]] else { return }
           
                for venue : [String : AnyObject] in venues {
                    guard let name = venue["name"] as? String  else { return}
                     guard let image = venue["image"] as? String  else { return}
                     guard let detail = venue["detail"] as? String  else { return}
                     guard let lat = venue["lat"] as? String  else { return}
                     guard let lng = venue["lng"] as? String  else { return}
                    let dict = TouristicVenues(name: name, image: image, detail: detail, lat: Double(lat)!, lng: Double(lng)!)
                    self.venues.append(dict)
                }

                
                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                }
                
            }catch let err{
                print("Failed to fetch ",err)
            }
            }.resume()
        
    }
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
      
     
      fetchVenues()
        collectionView?.backgroundColor = .white
        collectionView?.register(VenuesCell.self, forCellWithReuseIdentifier: Cell.cellId.rawValue)
        
       
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return venues.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        
        return CGSize(width: view.frame.size.width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.cellId.rawValue, for: indexPath) as! VenuesCell
        cell.venues = venues[indexPath.item]
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVenuesController = DetailVenuesController()
        detailVenuesController.venuesDetail = venues[indexPath.item]
        detailVenuesController.hidesBottomBarWhenPushed = true
        navigationController?.navigationBar.tintColor = .black
       let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        
        navigationController?.pushViewController(detailVenuesController, animated: true)
    }
  
}
