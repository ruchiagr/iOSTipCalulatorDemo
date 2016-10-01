//
//  SettingsViewController.swift
//  TipCalculator
//
//  Created by Ruchi Agrawal on 9/23/16.
//  Copyright © 2016 Ruchi Agrawal. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

 
    @IBOutlet weak var defaultTipText: UITextField!
    
    @IBOutlet weak var minTipText: UITextField!
    @IBOutlet weak var maxTipText: UITextField!
    
    var minTip : Double = 15
    var maxTip : Double = 25
    var defaultTip: Double = 20

    
    override func viewDidLoad() {
        super.viewDidLoad()

        print ("settings view did load")
        // Do any additional setup after loading the view.
        
        // set the saved values for tip
        let defaults = NSUserDefaults.standardUserDefaults()
       
        minTip = defaults.doubleForKey("minTipPercent")
        defaultTip = defaults.doubleForKey("midTipPercent")
        maxTip = defaults.doubleForKey("maxTipPercent")
        defaultTipText.text = String(Int(defaultTip))
        minTipText.text = String(Int(minTip))
        maxTipText.text = String(Int(maxTip))
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

    @IBAction func onDefaultChange(sender: AnyObject) {
        defaultTip = Double(defaultTipText.text!) ?? 0
        print("On default changed \(defaultTip)")
        saveChange(defaultTip, key:"midTipPercent")
    }
    


    @IBAction func onMinChange(sender: AnyObject) {
        minTip = Double(minTipText.text!) ?? 0
        print("On min changed \(minTip)")
        saveChange(minTip, key:"minTipPercent")
    }
    

    
    
    @IBAction func onMaxChange(sender: AnyObject) {
        maxTip = Double(maxTipText.text!) ?? 0
        print("On max changed \(maxTip)")
        saveChange(maxTip, key:"maxTipPercent")
    }

    
       // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    
    
    func saveChange(tip: Double, key: String)
    {
        print("saving tips \(key)" , tip)
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setDouble(tip, forKey: key)
        defaults.synchronize()
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        print("settings view will disappear")
        saveChange(defaultTip, key:"midTipPercent")
        saveChange(minTip, key:"minTipPercent")
        saveChange(maxTip, key:"maxTipPercent")
    }

    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        print("settings view did disappear")
        
    }

    
}
