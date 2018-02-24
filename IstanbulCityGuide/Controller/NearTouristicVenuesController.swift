//
//  NearTouristicVenuesController.swift
//  IstanbulCityGuide
//
//  Created by Burak Şentürk on 24.02.2018.
//  Copyright © 2018 Burak Şentürk. All rights reserved.
//

import UIKit
class NearTouristicVenuesController: UIViewController {
    
    private func setupNearestTouristicVenues(){
        
        guard let url = URL(string: Constants.getIns().searchAPI) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let parameters = "categoryId=4deefb944765f83613cdba6e&near=İstanbul&client_id=\(Constants.getIns().CLIENT_ID)&client_secret=\(Constants.getIns().CLIENT_SECRET)&v=20180224"
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
                    let jsonData = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                    
                    print(jsonData)
                    
                }catch let err{
                    print("Failed to fetch json",err)
                }
            }
            
            
        }.resume()
        
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       setupNearestTouristicVenues()
        
    }
}

