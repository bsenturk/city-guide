//
//  UserDefaultsManager.swift
//  IstanbulCityGuide
//
//  Created by Burak Şentürk on 5.03.2018.
//  Copyright © 2018 Burak Şentürk. All rights reserved.
//

import Foundation
extension UserDefaults{
    static func isExists(key : String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
}
