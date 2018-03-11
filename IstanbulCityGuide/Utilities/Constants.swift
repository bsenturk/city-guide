//
//  Constants.swift
//  IstanbulCityGuide
//
//  Created by Burak Şentürk on 24.02.2018.
//  Copyright © 2018 Burak Şentürk. All rights reserved.
//

import Foundation
import UIKit
class Constants {
    private static var instance : Constants?
    public static func getIns() -> Constants {
        if instance == nil {
            instance = Constants()
        }
        
        return instance!
    }
    
    public let mainBlue = UIColor.init(red: 0/255, green: 191/255, blue: 255/255, alpha: 1)
    public let CLIENT_ID = "XT4XC24Y1MWCY2UDHOLA2WYJD5KA0EDSUYJ5YXDGZQ3DTVU2"
    public let CLIENT_SECRET = "VE4BPGU0Y30ACQDBR0SKMIRY2SFKXVMZVVF3WNBIFEKH1C0K"
    public let searchAPI = "https://api.foursquare.com/v2/venues/search?"
    public let url =  "http://istanbulguide.ga"  //"http://localhost/IstanbulGuide/touristicvenues.php"
}

