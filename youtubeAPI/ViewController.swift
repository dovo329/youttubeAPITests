//
//  ViewController.swift
//  youtubeAPI
//
//  Created by Douglas Voss on 8/14/15.
//  Copyright (c) 2015 VossWareLLC. All rights reserved.
//

import UIKit

let kVideoId = "KYVdf5xyD8I"
let baseURL = "https://www.googleapis.com/youtube/v3/"
let googleProjectId = "fine-gradient-103823"
let googleProjectNumber = "104439241166"
//let googleAPIKey = "AIzaSyBDTts7_p_IEf1v0sJGGH-t8EfU4B2fCn0"
//let googleAPIKey = "AIzaSyDKqdgKxGSqu2pCwdeI3rzgYEMbGpATzuc"
//let googleAPIKey = "AIzaSyBfxeuH7DEu7RIZ_d6uoc91D7PZIMCJ_ow"
let googleAPIKey = "AIzaSyC24Fn9iz7_iCEwpQTD4TCZfraZRUO5Szk"
let kCellId = "cell.id"
let kSegueId = "segue.to.detail"

class ViewController: UIViewController, UITableViewDataSource {

    var videoId : String = ""
    var commentArray = [Comment]()
    //let commentQuery = baseURL+"commentThreads?part=snippet"+"&videoId="+kVideoId+"&key="+googleAPIKey
    var commentQuery = ""
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        navigationItem.title = "Comments for Video Id "+kVideoId
        
        // example: https://www.googleapis.com/youtube/v3/videos?id=7lCDEYXw3mM&key=YOUR_API_KEY&part=snippet,contentDetails,statistics,status
        
        let testUrl = "https://www.googleapis.com/youtube/v3/videos?id=7lCDEYXw3mM&key=AIzaSyC24Fn9iz7_iCEwpQTD4TCZfraZRUO5Szk&part=snippet,contentDetails,statistics,status"
        
        //queryWithUrlString(baseURL+"/comments"+"?id="+kVideoId+"&key="+googleAPIKey+"&part=contentDetails")
        //queryWithUrlString(testUrl)
        
/*contentDetails: 2
fileDetails: 1
id: 0
liveStreamingDetails: 2
player: 0
processingDetails: 1
recordingDetails: 2
snippet: 2
statistics: 2
status: 2
suggestions: 1
topicDetails: 2*/
        //first query the youtube video
        //let videoQuery = baseURL+"videos?id="+kVideoId+"&key="+googleAPIKey+"&part=contentDetails,fileDetails,id,liveStreamingDetails,player,processingDetails,recordingDetails,snippet,statistics,status,suggestions,topicDetails"
        let videoQuery = baseURL+"videos?id="+kVideoId+"&key="+googleAPIKey+"&part=contentDetails,id,liveStreamingDetails,player,recordingDetails,snippet,statistics,status,topicDetails"
        
        //let commentQuery = baseURL+"comments?parentId="+kVideoId+"&key="+googleAPIKey+"&part=id,snippet"
        
        //GET https://www.googleapis.com/youtube/v3/commentThreads?part=snippet&videoId=KYVdf5xyD8I&key={YOUR_API_KEY}
        
        //queryWithUrlString(videoQuery)
        //queryWithUrlString(commentQuery, completion : {(Void) -> Void in println("query complete!")})
        commentQuery = baseURL+"commentThreads?part=snippet"+"&videoId="+videoId+"&key="+googleAPIKey
        queryWithUrlString(commentQuery, isTest:false, completion : {(Void) -> Void in println("query complete!")})
    }
    
    //func queryWithUrlString(urlString : String)
    func queryWithUrlString(urlString : String, isTest : Bool, completion : (Void -> Void))
    {
        println("urlString=\(urlString)")
        if let nsUrl = NSURL(string: urlString)
        {
            let session = NSURLSession.sharedSession()
            let dataTask = session.dataTaskWithURL(nsUrl, completionHandler:
                {(data, response, error) -> Void in
                    if error == nil
                    {
                        var jsonError : NSError? = nil
                        let jsonObject : AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(0), error:&jsonError)
                        
                        if let jsonObject = jsonObject as? [String:AnyObject]
                        {
                            completion()
                            /*dispatch_async(
                                dispatch_get_main_queue(),
                                { () -> Void in
                                    println("\(jsonObject)")
                                }
                            )*/
                            if let dictArr = jsonObject["items"] as? NSArray
                            {
                                // update UI is on the main thread
                                dispatch_async(
                                    dispatch_get_main_queue(),
                                    { () -> Void in
                                        
                                        self.commentArray = [Comment]()
                                        
                                        for dict in dictArr
                                        {
                                            if let dict = dict as? NSDictionary
                                            {
                                                //println("\(dict)")
                                                let snippet = dict["snippet"] as! NSDictionary;
                                                //println("snippet=\(snippet)")
                                                let topLevelComment = snippet["topLevelComment"] as! NSDictionary
                                                //println("topLevelComment=\(topLevelComment)")
                                                let snippet2 = topLevelComment["snippet"] as! NSDictionary
                                                //println("snippet2=\(snippet2)")
                                                let comment = Comment(author: snippet2["authorDisplayName"] as! String, commentText: snippet2["textDisplay"] as! String)
                                                //comment.print()
                                                self.commentArray.append(comment)
                                            }
                                        }
                                        
                                        //println("comment count=\(self.commentArray.count)")
                                        if (!isTest) {
                                            self.tableView.reloadData()
                                        }
                                    }
                                )
                            } else {
                                // update UI is on the main thread
                                dispatch_async(
                                    dispatch_get_main_queue(),
                                    { () -> Void in
                                        alertWithTitle("JSON Array Cast Failed", message: "", dismissText: "Okay", viewController: self)
                                })
                            }
                        } else {
                            // no data returned from server
                            dispatch_async(
                                dispatch_get_main_queue(),
                                { () -> Void in
                                    alertWithTitle("No results", message: "", dismissText: "Okay", viewController: self)
                            })
                        }
                    } else {
                        dispatch_async(
                            dispatch_get_main_queue(),
                            { () -> Void in
                                alertWithTitle("NSURLSession Error", message: String(format:"Code %@", error), dismissText: "Okay", viewController: self)
                        })
                    }
            })
            dataTask.resume()
        } else {
            alertWithTitle("NSURL Creation Failed", message: "", dismissText: "Okay", viewController: self)
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(kCellId, forIndexPath: indexPath) as? UITableViewCell
        
        cell?.textLabel!.text = commentArray[indexPath.row].author
        cell?.detailTextLabel!.text = commentArray[indexPath.row].commentText
        cell?.layoutSubviews()
        
        return cell!
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destinationViewController = segue.destinationViewController as? DetailViewController {
            
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)!
            let comment = commentArray[indexPath.row]
            destinationViewController.comment = comment
        }
    }
}
