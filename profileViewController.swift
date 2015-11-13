//
//  profileViewController.swift
//  PARTY
//
//  Created by Reuben Ukah on 10/2/15.
//  Copyright © 2015 Versuvian. All rights reserved.
//

import UIKit
import Parse

class profileViewController: UIViewController {
    
    @IBOutlet weak var userprofilename: UILabel!
    
    
    

    
u
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.navigationBarHidden = false
        navigationItem.title =  PFUser.currentUser()?.username
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
