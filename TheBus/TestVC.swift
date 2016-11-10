//
//  TestVC.swift
//  TheBus
//
//  Created by Jerwyn Feria on 11/8/16.
//  Copyright © 2016 itsugawakun. All rights reserved.
//

import UIKit
import SocketIO

class TestVC: UIViewController {
    
    @IBOutlet weak var searchField: UITextField?
    @IBOutlet weak var stopField: UITextField?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let handlers = SocketHandlers()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnClicked(btn: UIButton) {
        handlers.searchStop(searchString: searchField?.text, callback: self.receivedResults2)
        print("Button clicked! searching \(searchField!.text)")
    }
    
    @IBAction func btnClicked2(btn: UIButton) {
        handlers.stopArrival(searchString: stopField?.text, callback: self.receivedResults)
        print("Button clicked! receiving Arrivals for \(stopField!.text)")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //functions for emits
    func receivedResults(results: Array<NSDictionary>,routes: Array<String>, requestTimestamp: Int?) {
        //print(results)
        print("TestVC")
        print(routes)
    }
    func receivedResults2(results: Array<NSDictionary>, requestTimestamp: Int?) {
        print(results)
    }


}
