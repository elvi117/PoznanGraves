//
//  ViewControllerProtocol.swift
//  PoznanGraves
//
//  Created by Lukasz Matuszczak on 13/05/2017.
//  Copyright © 2017 lm. All rights reserved.
//

import Foundation
import UIKit

protocol ViewControllerProtocol {
    func scrollTabBar(point: CGPoint)
    func selectCell(data: GraveObject)
    
}
