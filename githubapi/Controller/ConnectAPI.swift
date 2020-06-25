//
//  ConnectAPI.swift
//  githubapi
//
//  Created by gem on 6/23/20.
//  Copyright © 2020 gem. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ConnectAPI{
    let URL = "https://api.github.com/search/repositories?q="
    let parameters: Parameters = ["foo": "bar"]
    
    public func getListRepo(page: Int, repoTableView: UITableView!) {
        Alamofire.request(self.URL + "language:&per_page=50&page=\(page)")
            .responseJSON { response in
                if response.result.isSuccess {
                    do {
                        let json = try JSON(data: response.data!)
                        let totalItem = json["total_count"].intValue
                        if totalItem > 1000 {
                            Contains.total_Repos = 1000
                        } else {
                            Contains.total_Repos = totalItem
                        }
                        if let items = json["items"].array {
                            for item in items {
                                let repo = self.pareJson(json: item)
                                Contains.arrRepo.append(repo)
                            }
                        }
                        repoTableView.reloadData()
                        Contains.loadMore = false
                    } catch {
                        debugPrint(error)
                    }
                }
        }
    }
    
    public func searchKey(page: Int, searchKey: String, repoTableView: UITableView!) {
        if page == 1 {
            Contains.arrRepo.removeAll()
            repoTableView.reloadData()
        }
        
        Alamofire.request(self.URL + "\(searchKey)&language:&per_page=50&page=\(page)")
            .responseJSON { response in
                if response.result.isSuccess {
                    do {
                        let json = try JSON(data: response.data!)
                        let totalItem = json["total_count"].intValue
                        if totalItem > 1000 {
                            Contains.total_Repos = 1000
                        } else {
                            Contains.total_Repos = totalItem
                        }
                        if let items = json["items"].array {
                            for item in items {
                                let repo = self.pareJson(json: item)
                                Contains.arrRepo.append(repo)
                            }
                        }
                        repoTableView.reloadData()
                        Contains.loadMore = false
                    } catch {
                        debugPrint(error)
                    }
                }
        }
    }
    
    public func sortRepo(page: Int, searchKey: String, typeSort: String, order: String, repoTableView: UITableView!) {
        if page == 1 {
            Contains.arrRepo.removeAll()
            repoTableView.reloadData()
        }
        
        // build url
        var urlAPI = self.URL
        if !searchKey.isEmpty {
            urlAPI += searchKey + "&per_page=50&page=\(page)"
        }
        else {
            urlAPI += "language:&per_page=50&page=\(page)"
        }
        urlAPI += "&sort=\(typeSort)&order=\(order)"
        
        Alamofire.request(urlAPI)
            .responseJSON { response in
                if  response.result.isSuccess {
                    do {
                        let json = try JSON(data: response.data!)
                        let totalItem = json["total_count"].intValue
                        if totalItem > 1000 {
                            Contains.total_Repos = 1000
                        } else {
                            Contains.total_Repos = totalItem
                        }
                        if let items = json["items"].array {
                            for item in items {
                                let repo = self.pareJson(json: item)
                                Contains.arrRepo.append(repo)
                            }
                        }
                        repoTableView.reloadData()
                        Contains.loadMore = false
                    } catch {
                        debugPrint(error)
                    }
                }
        }
    }
    
    func pareJson(json: JSON) -> Repository {
        let avatar = json["owner"]["avatar_url"].stringValue
        let username = json["owner"]["login"].stringValue
        let reponame = json["name"].stringValue
        let url = json["html_url"].stringValue
        let star = json["stargazers_count"].intValue
        let watch = json["watchers_count"].intValue
        let fork = json["forks_count"].intValue
        let issue = json["open_issues_count"].intValue
        let lastCommit = json["updated_at"].stringValue
        return Repository.init(avatar: avatar, username: username, reponame: reponame, url: url, star: star, watch: watch, fork: fork, issue: issue, lastCommit: lastCommit)
    }
}
