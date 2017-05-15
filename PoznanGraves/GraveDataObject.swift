//
//  GraveDataObject.swift
//  PoznanGraves
//
//  Created by Lukasz Matuszczak on 12/05/2017.
//  Copyright © 2017 lm. All rights reserved.
//

import Foundation
import ObjectMapper

class GraveObject: Mappable {
    var geometry:[Any]?
    var id: Int?
    var g_date_birth: String?
    var g_quarter:String?
    var g_surname:String?
    var print_name:String?
    var g_place:String?
    var g_date_death:String?
    
    required init?(map: Map) {
    }
    
    //Map
    func mapping(map: Map) {
        geometry        <- map["geometry.coordinates"]
        id              <- map["id"]
        g_date_birth    <- map["properties.g_date_birth"]
        g_quarter       <- map["properties.g_quarter"]
        g_surname       <- map["properties.g_surname"]
        print_name      <- map["properties.print_name"]
        g_place         <- map["properties.g_place"]
        g_date_death    <- map["properties.g_date_death"]
    }
}
