//
//  PushNoAnimationSegue.swift
//  PARTY
//
//  Created by Reuben Ukah on 8/7/15.
//  Copyright (c) 2015 Versuvian. All rights reserved.
//

import UIKit

class PushNoAnimationSegue: UIStoryboardSegue {
    override func perform() {
        self.sourceViewController.presentViewController(self.destinationViewController as! UIViewController, animated: false, completion: nil)
        }
}

