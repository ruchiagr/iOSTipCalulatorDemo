//
//  ViewController.swift
//  TipCalculator
//
//  Created by Ruchi Agrawal on 9/21/16.
//  Copyright © 2016 Ruchi Agrawal. All rights reserved.
//

import UIKit

class TipViewController: UIViewController {
    
    @IBOutlet weak var billField: UITextField!
    
    
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    var minTip : Double = 0.15
    var maxTip : Double = 0.25
    var defaultTip: Double = 0.18
    
    var billAmount: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // to always dispplay cursor at the bill text field
        billField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func onTap(sender: AnyObject) {
       view.endEditing(true)
        
    }
    
    @IBAction func calculateTip(sender: AnyObject) {
    
        let tipPercentage = [minTip, defaultTip, maxTip]
        print(tipPercentage)
        
        let bill =  Double(billField.text!) ?? 0
        
        let tip = bill * tipPercentage[tipControl.selectedSegmentIndex]
        let total = bill + tip
        
        // display the tip and total
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        
        //get the current time
        let currentDateTime = NSDate()
        
        // save the bill amount and time
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setDouble(bill, forKey: "billAmount")
        defaults.setObject(currentDateTime, forKey: "lastTime")
        defaults.synchronize()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        print("tip view will appear")
        
        let currentTime = NSDate()
        
        // read tip values
        let defaults = NSUserDefaults.standardUserDefaults()

        billField.text = String("")
        if (defaults.objectForKey("lastTime") != nil)
        {
            let oldTime = defaults.objectForKey("lastTime") as! NSDate
            let interval = currentTime.timeIntervalSinceDate(oldTime)
            print("the interval is ")
            print (interval)
            
            if (interval < Double(1000))
            {
                if (defaults.doubleForKey("billAmount") > 0)
                {
                    billField.text = String(format: "%.2f", defaults.doubleForKey("billAmount"))
                }
 
            }
        }
        
        
        if (defaults.doubleForKey("minTipPercent") > 0)
        {
            print("minTip")
            print(defaults.doubleForKey("minTipPercent"))
            minTip = (defaults.doubleForKey("minTipPercent") / 100.0)
        }
        
        if (defaults.doubleForKey("maxTipPercent") > 0)
        {
            print(defaults.doubleForKey("maxTipPercent"))
            maxTip = (defaults.doubleForKey("maxTipPercent") / 100.0)
        }
        
        if (defaults.doubleForKey("midTipPercent") > 0)
        {
            print(defaults.doubleForKey("midTipPercent"))
            defaultTip = (defaults.doubleForKey("midTipPercent") / 100)
        }
        
        // update UISegment
        
        tipControl.setTitle(String(Int(minTip * 100)) + "%", forSegmentAtIndex: 0)
        tipControl.setTitle(String(Int(defaultTip * 100)) + "%", forSegmentAtIndex: 1)
        tipControl.setTitle(String(Int(maxTip * 100)) + "%", forSegmentAtIndex: 2)
        
        // for animation
        tipControl.center.x -= view.bounds.width
//        tipLabel.center.y -= view.bounds.width
//        totalLabel.center.y -= view.bounds.width
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
       print("tip view did appear")
        
        UIView.animateWithDuration(1.0, animations: {
            self.tipControl.center.x += self.view.bounds.width
            
//            self.tipLabel.center.y += self.view.bounds.width
//            self.totalLabel.center.y += self.view.bounds.width
        })
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        print("tip view will disappear")
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        print("tip view did disappear")
    }
    
    
}

