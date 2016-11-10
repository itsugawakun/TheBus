//
//  SocketHandlers.swift
//  TheBus
//
//  Created by Jerwyn Feria on 11/8/16.
//  Copyright © 2016 itsugawakun. All rights reserved.
//

import SocketIO

class SocketHandlers {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func searchStop(searchString: String!, callback: @escaping ((Array<NSDictionary>, Int?) -> Void)) -> Int {
        appDelegate.socket.once("stop-search") {data, _ in
            print("Received search results \(type(of: data[0]))")
            
            var results: [NSDictionary] = []
            let stopResults = data[0] as! NSArray
            
            for i in 0 ..< stopResults.count {
                results.append(stopResults[i] as! NSDictionary)
            }
            
            if data.count > 1 {
                callback(results, data[1] as? Int)
            } else {
                callback(results, nil)
            }
        }
        let searchTimestamp = Int(NSDate().timeIntervalSince1970 * 1000)
        //print(searchTimestamp)
        appDelegate.socket.emit("stop-search", searchString as String, searchTimestamp)
        return (searchTimestamp)
    }
    func stopArrival(searchString: String!, callback: @escaping ((Array<NSDictionary>,Array<String>, Int?) -> Void)) -> Int {
        appDelegate.socket.once("stop-arrivals") {data, _ in
            print("Received search results \(type(of: data[0]))")
            //print(data[0])
            
            var results: [NSDictionary] = []
            var routes: [String] = []
            let stopInformation = data[0] as! NSDictionary
            //print(stopInformation.value(forKey: "stop")!)
            let routeNumbers = stopInformation.value(forKey: "Routes") as! NSArray
            let arrivalsResults = stopInformation.value(forKey: "arrival") as! NSArray
            //stopNumber = stopInformation.value(forKey: "stop")! as! String
            //print(stopNumber)
            
            for i in 0 ..< arrivalsResults.count {
                results.append(arrivalsResults[i] as! NSDictionary)
            }
            
            for i in 0 ..< routeNumbers.count {
                routes.append(routeNumbers[i] as! String)
            }
            
            
            if data.count > 1 {
                callback(results,routes, data[1] as? Int)
                print("Passed")
            } else {
                callback(results,routes, nil)
                print("Failed")
            }
        }
        let searchTimestamp = Int(NSDate().timeIntervalSince1970 * 1000)
        appDelegate.socket.emit("stop-arrivals", searchString as String, searchTimestamp)
        
        return searchTimestamp

    }
}
