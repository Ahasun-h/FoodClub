//
//  ViewController.swift
//  FoodClub
//
//  Created by Ahasun on 1/27/23.
//

import UIKit
import WebKit
import Network

class ViewController: UIViewController,NetworkCheckObserver {
   
    var networkCheck = Reachability.sharedInstance()

        override func viewDidLoad() {
                super.viewDidLoad()

                if networkCheck.currentStatus == .satisfied{
                    //Do something
                }else{
                    //Show no network alert
                }
                networkCheck.addObserver(observer: self)
        }

        func statusDidChange(status: NWPath.Status) {
            if status == .satisfied {
                //Do something
            }else if status == .unsatisfied {
                //Show no network alert
            }
        }


}
