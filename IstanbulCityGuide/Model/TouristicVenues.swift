//
//  TouristicVenues.swift
//  IstanbulCityGuide
//
//  Created by Burak Şentürk on 3.03.2018.
//  Copyright © 2018 Burak Şentürk. All rights reserved.
//

import Foundation
struct TouristicVenues {
    let name : String
    let image : String
    let detail : String
    let lat : Double
    let lng : Double
    
    init(name : String , image: String , detail : String , lat : Double , lng : Double) {
        self.name = name
        self.image = image
        self.detail = detail
        self.lat = lat
        self.lng = lng
    }
}
