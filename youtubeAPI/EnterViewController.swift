//
//  EnterViewController.swift
//  youtubeAPI
//
//  Created by Douglas Voss on 8/17/15.
//  Copyright (c) 2015 VossWareLLC. All rights reserved.
//

import UIKit

let segueId = "segue.to.list"

class EnterViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.text = "KYVdf5xyD8I"
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // dismiss keyboard when return is hit
        textField.resignFirstResponder()
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destinationViewController = segue.destinationViewController as? ViewController {
            
            destinationViewController.videoId = textField.text
        }
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
