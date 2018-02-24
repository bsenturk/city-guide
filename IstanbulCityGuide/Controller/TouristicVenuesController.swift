//
//  TouristicVenuesController.swift
//  IstanbulCityGuide
//
//  Created by Burak Şentürk on 24.02.2018.
//  Copyright © 2018 Burak Şentürk. All rights reserved.
//

import UIKit
class TouristicVenuesController: UICollectionViewController , UICollectionViewDelegateFlowLayout {
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        collectionView?.register(VenuesCell.self, forCellWithReuseIdentifier: Values.cellId.rawValue)
        
       
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Values.cellId.rawValue, for: indexPath) as! VenuesCell
       
        
        
        return cell
    }
  
}
