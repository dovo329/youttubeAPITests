//
//  DetailViewController.swift
//  youtubeAPI
//
//  Created by Douglas Voss on 8/14/15.
//  Copyright (c) 2015 VossWareLLC. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var comment : Comment!
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        textView.text = comment.commentText
        //textView.setContentOffset(CGPoint(x:0.0, y:0.0), animated:false)
        //textView.scrollRangeToVisible(NSRange(location:0, length:0))
        textView.scrollRangeToVisible(NSRange(location:0, length:0))
        
        navigationItem.title = comment.author!
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
