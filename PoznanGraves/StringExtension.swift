
//
//  StringExtension.swift
//  PoznanGraves
//
//  Created by Lukasz Matuszczak on 13/05/2017.
//  Copyright © 2017 lm. All rights reserved.
//

import Foundation

extension String {
    var first: String {
        return String(characters.prefix(1))
    }
    
    var uppercaseFirst: String {
        return first.uppercased() + String(characters.dropFirst())
    }
}
