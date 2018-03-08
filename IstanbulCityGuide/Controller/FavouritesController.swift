//
//  FavouritesController.swift
//  IstanbulCityGuide
//
//  Created by Burak Şentürk on 24.02.2018.
//  Copyright © 2018 Burak Şentürk. All rights reserved.
//

import UIKit
import CoreData
class FavouritesController: UITableViewController , FavouritesVenuesDelegate {
    func didFav(favVenue: Favourites) {
        self.favourites.append(favVenue)
        let indexPath = IndexPath(row: favourites.count - 1, section: 0)
        tableView.insertRows(at: [indexPath], with: .left)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
   var favourites = [Favourites]()
    var venuesDetails = [TouristicVenues]()
    var name : String?
    var image : String?
    var detail : String?
    var lat : Double?
    var lng : Double?
    

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favourites.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = tableView.dequeueReusableCell(withIdentifier: Cell.rowId.rawValue, for: indexPath) as! FavouritesCell
        row.favourites = favourites[indexPath.row]
        
        return row
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (_, indexPath) in
            
           let fav = self.favourites[indexPath.row]
            guard let favName = self.favourites[indexPath.row].name else { return }
            self.favourites.remove(at: indexPath.row)
            
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            
            
            let context = CoreDataManager.shared.persistenceContainer.viewContext
            
            context.delete(fav)
            UserDefaults.standard.removeObject(forKey: favName)
            
            do{
                try context.save()
            }catch let err {
                print(err)
            }
            
        
            
        }
        deleteAction.backgroundColor = .red
        return [deleteAction]
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.2, alpha: 0.2)
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         name = favourites[indexPath.row].name
         image = favourites[indexPath.row].image
        detail = favourites[indexPath.row].detail
        lat = favourites[indexPath.row].lat
        lng = favourites[indexPath.row].lng
        let dict = TouristicVenues(name: name!, image: image!, detail: detail!, lat: lat!, lng: lng!)
        self.venuesDetails.append(dict)
        let detailVenuesController = DetailVenuesController()
        detailVenuesController.venuesDetail = venuesDetails[indexPath.row]
        detailVenuesController.hidesBottomBarWhenPushed = true
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        navigationController?.pushViewController(detailVenuesController, animated: true)
        
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      
            self.tableView.reloadData()
        
      
        
    }
    
    func asd(){
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(FavouritesCell.self, forCellReuseIdentifier: Cell.rowId.rawValue)
        favourites = CoreDataManager.shared.fetchVenues()
             NotificationCenter.default.addObserver(self, selector: #selector(loadTableView), name: NSNotification.Name(rawValue: "load"), object: nil)
        
    }
    @objc func loadTableView(){
        favourites = CoreDataManager.shared.fetchVenues()
        self.tableView.reloadData()
        
    }
}
