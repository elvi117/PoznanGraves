//
//  HttpExtension.swift
//  PoznanGraves
//
//  Created by Lukasz Matuszczak on 12/05/2017.
//  Copyright © 2017 lm. All rights reserved.
//

import Foundation

extension ViewController{
    
    func makeHttpGetRequest(block: @escaping ([GraveObject])->(), completionWithError: @escaping (errorType)->()){
        var outputArray = [GraveObject]()
        let url = URL(string: "http://www.poznan.pl/featureserver/featureserver.cgi/groby/all.json")
        
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            guard error == nil else {
                completionWithError(.noNetwork)
                return
            }
            guard let data = data else {
                completionWithError(.badData)
                return
            }
            
            do {
                 if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                    let features = json["features"] as? [[String: Any]] {
                    for feature in features {
                        let singleObject = GraveObject(JSON: feature)
                        if singleObject?.print_name != ""{
                        outputArray.append(singleObject!)
                        }
                    }
                   
                }
            } catch {
                completionWithError(.badData)
            }
            
            block(outputArray)
        }
        
        task.resume()
    }
    
    

    
    
    //MARK:- Alert descriptions
    var loadingDataAlert:String{
        get{
            return "Ładowanie"
        }
    }
    
    var badDataAlert:String{
        get{
            return "Błąd danych. Kliknij by załadować ponownie"
        }
    }
    
    var noNetworkAlert:String{
        get{
            return "Brak połączenia. Kliknij by załadować ponownie"
        }
    }
    
    
    //MARK:- Additional enumerates
    enum viewState{
        case loading, error, ready
    }
    
    enum errorType:Error{
        case noNetwork, badData
    }
    
}
