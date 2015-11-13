//
//  ContentViewController.swift
//  PARTY
//
//  Created by Reuben Ukah on 10/12/15.
//  Copyright © 2015 Versuvian. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {

    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    var pageIndex : Int!
    var titleIndex: String!
    var imageFile: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageview.image = UIImage(named: self.imageFile)
        self.titleLabel.text = self.titleIndex
        
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
