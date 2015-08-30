//
//  FirstViewController.swift
//  PARTY
//
//  Created by Reuben Ukah on 6/28/15.
//  Copyright (c) 2015 Versuvian. All rights reserved.
//

import UIKit
import Foundation
import Parse

class FirstViewController: UIViewController {
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.hidden = true
        // Do any additional setup after loading the view, typically from a nib.
     
        
       
        }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.hidden = true
    }
    
        
        
       
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
       
       
    }


}

