//
//  NearTouristicVenuesController.swift
//  IstanbulCityGuide
//
//  Created by Burak Şentürk on 24.02.2018.
//  Copyright © 2018 Burak Şentürk. All rights reserved.
//

import UIKit
class NearTouristicVenuesController: UITableViewController {
    
    var nearVenues = [NearVenues]()
    var nearVen = [TouristicVenues]()
    var name : String?
    var lat : Double?
    var lng : Double?
    
    private func setupNearestTouristicVenues(){
        
        guard let url = URL(string: Constants.getIns().searchAPI) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let parameters = "categoryId=4deefb944765f83613cdba6e,4bf58dd8d48988d181941735&near=İstanbul&client_id=\(Constants.getIns().CLIENT_ID)&client_secret=\(Constants.getIns().CLIENT_SECRET)&v=20180224"
        request.httpBody = parameters.data(using: String.Encoding.utf8)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Failed to request", error)
            }
            
            if let response = response as? HTTPURLResponse {
                if response.statusCode != 200 {
                    print("Status code is not equal to 200")
                    
                }
                else {
                    print("Status code equal to 200")
                }
                guard let data = data else { return }
                
                do{
                    let jsonData = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as AnyObject
                    guard let responseData = jsonData["response"] as? [String : Any] else { return }
                    guard let venues = responseData["venues"] as? [[String : AnyObject]] else { return }
//                    print(venues)
                    for venue:[String : AnyObject] in venues{
                        //print(venue)
                          guard let venueName = venue["name"] as? String else { return }
                        guard let location = venue["location"] as? [String : AnyObject] else { return }
                        guard let lat = location["lat"] as? Double else { return }
                        guard let lng = location["lng"] as? Double else { return }
                    print(venueName,lat,lng)
                        
                        let dict = NearVenues.init(venueName: venueName, lat: lat, lng: lng)
                        self.nearVenues.append(dict)
                        
                        
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                        
                    }
                  
//                    print(jsonData)
                    
                }catch let err{
                    print("Failed to fetch json",err)
                }
            }
            
            
        }.resume()
        
        
        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nearVenues.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.rowId.rawValue, for: indexPath)
        
       cell.textLabel?.text = nearVenues[indexPath.row].name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        name = nearVenues[indexPath.row].name
        lat = nearVenues[indexPath.row].lat
        lng = nearVenues[indexPath.row].lng
        let dict = TouristicVenues(name: name!, image: "", detail: "", lat: lat!, lng: lng!)
        self.nearVen.append(dict)
        let mapController = MapController()
        mapController.hidesBottomBarWhenPushed = true
        mapController.name = nearVenues[indexPath.row].name
        mapController.lat = nearVenues[indexPath.row].lat
        mapController.lng = nearVenues[indexPath.row].lng
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        navigationController?.navigationBar.tintColor = .white
        navigationController?.pushViewController(mapController, animated: true)

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Cell.rowId.rawValue)
       setupNearestTouristicVenues()
        
    }
}

