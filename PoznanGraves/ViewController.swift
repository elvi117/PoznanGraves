//
//  ViewController.swift
//  PoznanGraves
//
//  Created by Lukasz Matuszczak on 12/05/2017.
//  Copyright © 2017 lm. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ViewControllerProtocol {
    
    
    //MARK:- Constraints
    @IBOutlet var topBarHeight: NSLayoutConstraint!
    
    //MARK:- Outlets
    @IBOutlet var simpleTableView: UITableView!
    @IBOutlet var alertData: UILabel!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var loadingView: UIView!
    
    //MARK:- Objects
    var tableManager:TableViewManager?
    var viewCurrentState:viewState = .loading
    
    //MARK:- Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableManager = TableViewManager()
        self.tableManager?.delegateMethod = self
        
        self.simpleTableView.dataSource = tableManager
        self.simpleTableView.delegate = tableManager
        
        self.getDataFromRemote()
    }
    
    func getDataFromRemote(){
        makeHttpGetRequest(block: { (gravesArray:[GraveObject]) in
            DispatchQueue.main.async {
                self.tableManager?.inputArray = gravesArray
                self.simpleTableView.reloadData()
                self.viewCurrentState = .ready
                UIView.animate(withDuration: 2, animations: {
                    self.loadingView.alpha = 0
                }, completion: { (Bool) in
                    self.loadingView.removeFromSuperview()
                })
                
            }
        }) { (er: ViewController.errorType) in
            DispatchQueue.main.async {
                self.viewCurrentState = .error
                self.activityIndicator.stopAnimating()
                switch er{
                case .badData:
                    self.alertData.text = self.badDataAlert
                    
                case .noNetwork:
                    self.alertData.text = self.noNetworkAlert
                    
                }
            }
        }
    }
    
    func scrollTabBar(point: CGPoint){
        //81 - max height
        //45 - min height
        
        if 81.0 - point.y < 45.0{
            self.topBarHeight.constant = 45.0
        }
        else{
            self.topBarHeight.constant = 81.0 - point.y
        }
    }
    
    func selectCell(data: GraveObject){
        performSegue(withIdentifier: "detailsViewController", sender: data)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationViewController = segue.destination as! DetailsViewController
        destinationViewController.dataValues = sender as? GraveObject
    }

    //MARK:- Outlet Methods
    @IBAction func loadingViewTapGesture(_ sender: Any) {
        if self.viewCurrentState == .error{
            self.getDataFromRemote()
            self.activityIndicator.startAnimating()
            self.viewCurrentState = .loading
            self.alertData.text = self.loadingDataAlert
        }
    }
}

