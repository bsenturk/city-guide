//
//  ViewController.swift
//  IstanbulCityGuide
//
//  Created by Burak Şentürk on 24.02.2018.
//  Copyright © 2018 Burak Şentürk. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupControllers()
        setupNavigationBar(text: "Touristic Venues")
    }

  
    func setupControllers(){
        let layout = UICollectionViewFlowLayout()
        let touristicVenuesController = setupNavigationControllers(image: UIImage(named : "venuesList")!, selectedImage: UIImage(named : "venuesListSelected")!, rootViewController: TouristicVenuesController(collectionViewLayout: layout) )
        let nearTouristicVenuesController = setupNavigationControllers(image: UIImage(named: "nearVenues")!, selectedImage: UIImage(named: "nearVenuesSelected")!, rootViewController: NearTouristicVenuesController())
        let favouritesController = setupNavigationControllers(image: UIImage(named: "favourites")!, selectedImage: UIImage(named: "favouritesSelected")!, rootViewController: FavouritesController())
        
        viewControllers = [
           touristicVenuesController,
           nearTouristicVenuesController,
           favouritesController
        
        ]
        
        guard let items = tabBar.items else { return }
        
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        }
    }
   
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
         guard let items = tabBar.items else { return }
        
        if items.index(of: item) == 0 {
            setupNavigationBar(text: "Touristic Venues")
        }
        else if items.index(of: item) == 1 {
            setupNavigationBar(text: "Near Venues")
        }
        
        else if items.index(of: item) == 2 {
            setupNavigationBar(text: "Favourites Venues")
        }
    }
    
    fileprivate func setupNavigationBar(text: String){
        let label = UILabel()
        label.text = text
        label.textColor = .white
        label.font = UIFont(name: "Remachine Script Personal Use", size: 42)
        
        navigationItem.titleView = label
        
    }
    
    
    fileprivate func setupNavigationControllers(image : UIImage, selectedImage: UIImage,rootViewController : UIViewController = UIViewController()) -> UINavigationController{
        let viewControllers = rootViewController
        let navController = UINavigationController(rootViewController: viewControllers)
        navController.tabBarItem.image = image.withRenderingMode(.alwaysOriginal)
        navController.tabBarItem.selectedImage = selectedImage.withRenderingMode(.alwaysOriginal)
        
        
        return navController
    }
    
   

}

