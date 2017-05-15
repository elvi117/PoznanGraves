
//
//  DetailsViewController.swift
//  PoznanGraves
//
//  Created by Lukasz Matuszczak on 13/05/2017.
//  Copyright © 2017 lm. All rights reserved.
//

import UIKit
import MapKit
class DetailsViewController: UIViewController, MKMapViewDelegate {
    
    //MARK:- Annotations Class
    class MyAutoPin:NSObject, MKAnnotation{
        let title:String?
        let coordinate: CLLocationCoordinate2D
        
        init(title:String, coordinate:CLLocationCoordinate2D) {
            self.title = title
            self.coordinate = coordinate
            
            super.init()
        }
    }
    
    //MARK:- Objects
    var dataValues:GraveObject?
    var latitude:Double?
    var longitude:Double?
    
    //MARK:- Outlets
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var surnameLabel: UILabel!
    @IBOutlet var birthDateLabel: UILabel!
    @IBOutlet var deatchDateLabel: UILabel!
    @IBOutlet var placeLabel: UILabel!
    @IBOutlet var quorterLabel: UILabel!
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var openInMapsButtonOutlet: UIButton!
    
    
    //MARK:- Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fillLabels()
        
        if let coordinates = self.checkCoordinates(coordinates: (self.dataValues?.geometry)!) {
            self.latitude = coordinates.latitude
            self.longitude = coordinates.longitude
            self.reloadMap(title: "Śp. \(self.dataValues?.print_name ?? "") \(self.dataValues?.g_surname?.uppercaseFirst ?? "")")
        }
    }
    
    func fillLabels(){
        self.nameLabel.text = self.dataValues?.print_name
        self.surnameLabel.text = self.dataValues?.g_surname?.uppercaseFirst
        self.birthDateLabel.text = self.dataValues?.g_date_birth
        self.deatchDateLabel.text = self.dataValues?.g_date_death
        self.placeLabel.text = self.dataValues?.g_place
        self.quorterLabel.text = self.dataValues?.g_quarter
        
        if self.dataValues?.g_date_death == "0001-01-01"{
            self.deatchDateLabel.text = "n.d"}
        else{
            self.deatchDateLabel.text = self.dataValues?.g_date_death
        }
    }

    //MARK:- Methods related to MapKit
    func checkCoordinates(coordinates:[Any]) -> (latitude: Double, longitude: Double)?{
        var arrayOfSplittedCoordinates = String(describing: coordinates[0]).components(separatedBy: "\"")
        
        guard let latitude = Double(arrayOfSplittedCoordinates[3]) , let longitude = Double(arrayOfSplittedCoordinates[1]) else{
            self.mapView.isHidden = true
            self.openInMapsButtonOutlet.isHidden = true
            return nil
        }
        
        return (latitude, longitude)
    }
    
    func reloadMap(title:String){
        if self.latitude != nil && self.longitude != nil{
        
            let annotation = MyAutoPin(title: title, coordinate: CLLocationCoordinate2D(latitude: CLLocationDegrees.init(exactly: self.latitude!)!, longitude: CLLocationDegrees.init(exactly:self.longitude! )!))
            let span = MKCoordinateSpan(latitudeDelta: mapView.region.span.latitudeDelta / 2150, longitudeDelta: mapView.region.span.latitudeDelta  / 2150)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: CLLocationDegrees.init(exactly: self.latitude!)!, longitude: CLLocationDegrees.init(exactly: self.longitude!)!), span: span)
        
            self.mapView.addAnnotation(annotation)
            self.mapView.setRegion(region, animated: true)
        }
    }
    
    //MARK:- Outlets actions
    @IBAction func backButtonClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func openInMapsApp(_ sender: Any) {
        UIApplication.shared.open(URL(string: "http://maps.apple.com/?daddr=\(latitude!),\(self.longitude!)")!, options: [:], completionHandler: nil)
    }
}

