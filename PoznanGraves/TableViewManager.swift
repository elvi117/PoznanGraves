//
//  TableViewManager.swift
//  PoznanGraves
//
//  Created by Lukasz Matuszczak on 12/05/2017.
//  Copyright © 2017 lm. All rights reserved.
//

import Foundation
import UIKit

class TableViewManager: NSObject, UITableViewDataSource, UITableViewDelegate {
    var delegateMethod:ViewControllerProtocol?
    var inputArray:[GraveObject]?
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if inputArray != nil{
        return (inputArray?.count)!
        }
        else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let t =  tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! CellObject
        t.name.text =  "\((inputArray?[indexPath.row].g_surname!)?.uppercaseFirst ?? "")  \((inputArray?[indexPath.row].print_name!)?.uppercaseFirst ?? "")"
        
        return t
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            self.delegateMethod?.selectCell(data: (self.inputArray?[indexPath.row])!)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            self.delegateMethod?.scrollTabBar(point: scrollView.contentOffset)
    }
}
