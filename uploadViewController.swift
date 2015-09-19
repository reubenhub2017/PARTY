//
//  uploadViewController.swift
//  PARTY
//
//  Created by Reuben Ukah on 8/26/15.
//  Copyright © 2015 Versuvian. All rights reserved.
//

import UIKit
import Parse
import Foundation

class uploadViewController:  UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func cancelpressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var partyname: UITextField!
    
    @IBOutlet weak var addinfo: UITextView!

    @IBOutlet weak var starttime: UITextField!
    @IBOutlet weak var endtime: UITextField!
    @IBOutlet weak var descriptionupload: UITextView!
    
    
    
//    @IBAction func finishpressed(sender: AnyObject) {
//        
//        
//        var queryclass = PFObject(className: "parties")
//        queryclass["title"] =
//        queryclass["host"] =
//        queryclass["location"] =
//        queryclass["start_time"] =
//        
//            queryclass.saveInBackgroundWithBlock {
//                (success: Bool, error: NSError?) -> Void in
//                if(success){
//                
//                }
//                
//                else {
//                    // There was a problem, check error.description
//                }
//    }
    
        //let user : PFUser = PFUser()
        
    
    
    
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
