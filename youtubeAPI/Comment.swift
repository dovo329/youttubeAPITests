//
//  Comment.swift
//  youtubeAPI
//
//  Created by Douglas Voss on 8/14/15.
//  Copyright (c) 2015 VossWareLLC. All rights reserved.
//

import Foundation

class Comment: NSObject {

    var author : String?
    var commentText : String?
    
    init(author: String, commentText: String) {
        self.author = author
        self.commentText = commentText
    }
    
    func print() {
        println("author: \(author)")
        println("comment: \(commentText)")
    }
    
}
