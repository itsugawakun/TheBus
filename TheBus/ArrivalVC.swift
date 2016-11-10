//
//  ArrivalVC.swift
//  TheBus
//
//  Created by Jerwyn Feria on 11/8/16.
//  Copyright © 2016 itsugawakun. All rights reserved.
//

import UIKit
import SocketIO

class ArrivalVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    var app = UIApplication.shared.delegate as! AppDelegate
    var headsigns = [String]()
    var stopTime = [String]()
    var vehicle = [String]()
    let handlers = SocketHandlers()
    let searchController = UISearchController(searchResultsController: nil)
    var passedTimestamp = 0
    var passedValue = String()
    @IBOutlet weak var stopLabel:UILabel?
    @IBOutlet weak var stopName:UILabel?
    @IBOutlet weak var routes:UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //self.tableView!.dataSource = self
        //self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func receivedResults(results: Array<NSDictionary>,routes: Array<String>, requestTimestamp: Int?) {
        print(results)
        headsigns = []
        stopTime = []
        vehicle = []
        print("Table view")
        for i in 0 ..< results.count {
            self.headsigns.append(results[i]["headsign"] as! String)
            self.stopTime.append(results[i]["stopTime"] as! String)
            self.vehicle.append(results[i]["vehicle"] as! String)
        }
        
        //print(self.stopNames)
        //tableView.reloadData()
    }
    
    @IBOutlet weak var realoadButton: UIButton!
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.handlers.stopArrival(searchString: passedValue, callback: self.receivedResults)
        tableView.reloadData()
    }
    override func viewDidAppear(_ animated: Bool) {
        stopLabel?.text = passedValue
        self.handlers.stopArrival(searchString: passedValue, callback: self.receivedResults)
        print(headsigns.description)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = "\(self.headsigns[indexPath.row])"
        cell.detailTextLabel?.text = "Stop \(self.vehicle[indexPath.row])"
        cell.accessoryType = .disclosureIndicator
        //print(self.stopNames[indexPath.row])
        return cell
        
        //return UITableViewCell()
    }
    
    //Use when loading of location
    /*
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }*/

}
