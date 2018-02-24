//
//  NearVenues.swift
//  IstanbulCityGuide
//
//  Created by Burak Şentürk on 24.02.2018.
//  Copyright © 2018 Burak Şentürk. All rights reserved.
//

import Foundation
struct NearVenues {
    let name : String
    let lat : Double
    let lng : Double
    
    init(venueName : String , lat : Double , lng : Double) {
        self.name = venueName
        self.lat = lat
        self.lng = lng
    }
}
