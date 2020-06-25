//
//  Repository.swift
//  githubapi
//
//  Created by gem on 6/23/20.
//  Copyright © 2020 gem. All rights reserved.
//

import Foundation

class Repository{
    var avatar: String
    var username: String
    var reponame: String
    var url: String
    var star: Int
    var watch: Int
    var fork: Int
    var issue: Int
    var lastCommit: String
    
    init(avatar: String, username: String, reponame: String, url: String, star: Int, watch: Int, fork: Int, issue: Int, lastCommit: String) {
        self.avatar = avatar
        self.username = username
        self.reponame = reponame
        self.url = url
        self.star = star
        self.watch = watch
        self.fork = fork
        self.issue = issue
        self.lastCommit = lastCommit
    }
}

