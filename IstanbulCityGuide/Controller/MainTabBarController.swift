//
//  ViewController.swift
//  IstanbulCityGuide
//
//  Created by Burak Şentürk on 24.02.2018.
//  Copyright © 2018 Burak Şentürk. All rights reserved.
//

import UIKit
import UserNotifications
class CustomNavigationController: UINavigationController {
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
}

class MainTabBarController: UITabBarController {
    
    func setupLocalNotifications(){
        let content = UNMutableNotificationContent()
        content.title = "Continue to explore Istanbul"
        content.body = "Let's go to learn that beauty of this city! "
        content.badge = 1
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60 * 60, repeats: false)
        let request = UNNotificationRequest(identifier: "deneme", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
    }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupControllers()
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound , .badge]) { (isAllow, err) in
            if let err = err {
                print(err)
            }
            
            if isAllow == true {
                self.setupLocalNotifications()
            }
        }
        
        
    }

  
    func setupControllers(){
        let layout = UICollectionViewFlowLayout()
        let touristicVenuesController = setupNavigationControllers(image: UIImage(named : "venuesList")!, selectedImage: UIImage(named : "venuesListSelected")!, rootViewController: TouristicVenuesController(collectionViewLayout: layout), title: "Touristic Venues" )
        let nearTouristicVenuesController = setupNavigationControllers(image: UIImage(named: "nearVenues")!, selectedImage: UIImage(named: "nearVenuesSelected")!, rootViewController: NearTouristicVenuesController(), title: "Near Venues")
        let favouritesController = setupNavigationControllers(image: UIImage(named: "favourites")!, selectedImage: UIImage(named: "favouritesSelected")!, rootViewController: FavouritesController(), title: "Favourites Venues")
        
        
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
   
  

 
    
    fileprivate func setupNavigationControllers(image : UIImage, selectedImage: UIImage,rootViewController : UIViewController = UIViewController() , title : String) -> UINavigationController{
        
        let viewControllers = rootViewController
         let navController = CustomNavigationController(rootViewController: viewControllers)
        navController.tabBarItem.image = image.withRenderingMode(.alwaysOriginal)
        navController.tabBarItem.selectedImage = selectedImage.withRenderingMode(.alwaysOriginal)
        let label = UILabel()
        label.text = title
        label.textColor = .white
        label.font = UIFont(name: "Remachine Script Personal Use", size: 42)
        navController.navigationBar.topItem?.titleView = label

        return navController
        
    }
    
   

}

