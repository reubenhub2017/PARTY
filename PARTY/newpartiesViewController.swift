//
//  newpartiesViewController.swift
//  PARTY
//
//  Created by Reuben Ukah on 9/18/15.
//  Copyright (c) 2015 Versuvian. All rights reserved.
//

import UIKit
import Parse
import Foundation
import CoreLocation

class newpartiesViewController: UIViewController {

    @IBAction func cancelpressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBOutlet weak var titleofparty: UITextField!
    
    @IBOutlet weak var descofparty: UITextView!
    @IBOutlet weak var strtimeofparty: UITextField!
    
    
    
    @IBAction func finishpressed(sender: AnyObject) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
