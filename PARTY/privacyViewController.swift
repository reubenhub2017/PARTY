//
//  privacyViewController.swift
//  PARTY
//
//  Created by Reuben Ukah on 12/18/15.
//  Copyright © 2015 Versuvian. All rights reserved.
//

import UIKit

class privacyViewController: UIViewController {

    @IBOutlet weak var privacywebview: UIWebView!
     var URLPath = "http://www.versuvian.com/privacy/"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Your webView code goes here
        let url = NSURL (string: URLPath);
        let requestObj = NSURLRequest(URL: url!);
        privacywebview.loadRequest(requestObj);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadAddressURL() {
        let requestURL = NSURL(string:
            URLPath)
        let request = NSURLRequest(URL: requestURL!)
        privacywebview.loadRequest(request)
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
