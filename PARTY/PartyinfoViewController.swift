//
//  PartyinfoViewController.swift
//  PARTY
//
//  Created by Reuben Ukah on 9/7/15.
//  Copyright © 2015 Versuvian. All rights reserved.
//

import UIKit

class PartyinfoViewController: UIViewController {
    
    let partyinfoSegueIdentifier = "cellpartysegue"
    
    @IBOutlet weak var testvalue: UILabel!

    
    var value = String()
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        testvalue.text = value
        
        self.navigationController?.popToRootViewControllerAnimated(true)
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
