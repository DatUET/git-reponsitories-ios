//
//  ViewController.swift
//  githubapi
//
//  Created by gem on 6/23/20.
//  Copyright © 2020 gem. All rights reserved.
//

import UIKit
import SDWebImage

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var reposTableView: UITableView!
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var starSortBtn: UIButton!
    @IBOutlet weak var forkSortBtn: UIButton!
    @IBOutlet weak var descSort: UIImageView!
    
    var curentPage = 1
    let cna = ConnectAPI()
    var mode = 0 // 0 for nomal, 1 for search, 2 for sort star, 3 for fork, 4 for
    var desc = true
    var order = ""
    
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        reposTableView.dataSource = self
        reposTableView.delegate = self
        reposTableView.refreshControl = refreshControl
        cna.getListRepo(page: curentPage, repoTableView: self.reposTableView)
        searchTF.addTarget(self, action: #selector(search), for: .editingDidEndOnExit)
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        starSortBtn.addTarget(self, action: #selector(srarSort), for: .touchUpInside)
        forkSortBtn.addTarget(self, action: #selector(forkSort), for: .touchUpInside)
        starSortBtn.setTitleColor(.black, for: .normal)
        forkSortBtn.setTitleColor(.black, for: .normal)
    }
    
    @objc func srarSort() {
        curentPage = 1
        debugPrint("current page = \(curentPage)")
        if mode == 2 {
            desc = !desc
            debugPrint("\(desc)")
        }
        else {
            desc = true
            mode = 2
            starSortBtn.setTitleColor(.blue, for: .normal)
            forkSortBtn.setTitleColor(.black, for: .normal)
        }
        let searchKey = searchTF.text!
        if desc {
            order = "desc"
            descSort.image = UIImage(named: "down")
        } else {
            order = "asc"
            descSort.image = UIImage(named: "upload")
        }
        cna.sortRepo(page: 1, searchKey: searchKey, typeSort: "stars", order: order, repoTableView: self.reposTableView)
        //cna.sortRepo(page: 1, searchKey: searchKey, typeSort: "stars", order: order, repoTableView: self.reposTableView)
    }
    
    @objc func forkSort() {
        curentPage = 1
        debugPrint("current page = \(curentPage)")
        if mode == 3 {
            desc = !desc
            debugPrint("\(desc)")
        }
        else {
            desc = true
            mode = 3
            forkSortBtn.setTitleColor(.blue, for: .normal)
            starSortBtn.setTitleColor(.black, for: .normal)
        }
        let searchKey = searchTF.text!
        if desc {
            order = "desc"
            descSort.image = UIImage(named: "down")
        } else {
            order = "asc"
            descSort.image = UIImage(named: "upload")
        }
        cna.sortRepo(page: 1, searchKey: searchKey, typeSort: "forks", order: order, repoTableView: self.reposTableView)
    }
    
    @objc func refresh() {
        let searchKey = searchTF.text!
        Contains.arrRepo.removeAll()
        self.reposTableView.reloadData()
        curentPage = 1
        if mode == 0 {
            cna.getListRepo(page: 1, repoTableView: self.reposTableView)
        } else if mode == 1{
            cna.searchKey(page: 1, searchKey: searchKey, repoTableView: reposTableView)
        } else if mode == 2 {
            
            cna.sortRepo(page: 1, searchKey: searchKey, typeSort: "stars", order: order, repoTableView: self.reposTableView)
        } else if mode == 3 {
            
            cna.sortRepo(page: 1, searchKey: searchKey, typeSort: "forks", order: order, repoTableView: self.reposTableView)
        }
        debugPrint("current page   = \(curentPage) and mode = \(mode)")
        self.refreshControl.endRefreshing()
    }
    
    @objc func search() {
        let searchKey = searchTF.text!
        descSort.image = nil
        starSortBtn.setTitleColor(.black, for: .normal)
        forkSortBtn.setTitleColor(.black, for: .normal)
        curentPage = 1
        starSortBtn.setTitleColor(.black, for: .normal)
        forkSortBtn.setTitleColor(.black, for: .normal)
        if !searchKey.isEmpty{
            mode = 1
            cna.searchKey(page: curentPage, searchKey: searchTF.text!, repoTableView: reposTableView)
        } else {
            mode = 0
            Contains.arrRepo.removeAll()
            self.reposTableView.reloadData()
            cna.getListRepo(page: curentPage, repoTableView: self.reposTableView)
        }
    }
    
    @objc func nextPage() {
        debugPrint("\(Contains.arrRepo.count) - \(Contains.total_Repos)")
        Contains.loadMore =  true
        curentPage += 1
        if mode == 0 {
            cna.getListRepo(page: curentPage, repoTableView: self.reposTableView)
        }
        else if mode == 1 {
            cna.searchKey(page: curentPage, searchKey: searchTF.text!, repoTableView: reposTableView)
        } else if mode == 2 {
            cna.sortRepo(page: curentPage, searchKey: searchTF.text!, typeSort: "stars", order: order, repoTableView: reposTableView)
        } else if mode == 3 {
            cna.sortRepo(page: curentPage, searchKey: searchTF.text!, typeSort: "forks", order: order, repoTableView: reposTableView)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //debugPrint(Contains.arrRepo.count)
        return Contains.arrRepo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = reposTableView.dequeueReusableCell(withIdentifier: "repoCell") as! RepositoryTableViewCell
        let repo = Contains.arrRepo[indexPath.row]
        cell.reponame.text = repo.reponame
        cell.username.text = repo.username
        cell.numberStar.text = String(repo.star)
        cell.numberFork.text = String(repo.fork)
        cell.numberWatcher.text = String(repo.watch)
        cell.numberIssue.text = String(repo.issue)
        cell.lastUpdate.text = repo.lastCommit
        cell.useravatar.sd_setImage(with: URL(string: repo.avatar), placeholderImage: UIImage(named: "issue.png"))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let webRepo = storyboard?.instantiateViewController(withIdentifier: "WebRepoViewController") as? WebRepoViewController
        webRepo?.urlRepo = Contains.arrRepo[indexPath.row].url
        self.navigationController?.pushViewController(webRepo!, animated: true)
        
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contenHeight = scrollView.contentSize.height
        //debugPrint("offset y = \(offsetY) and \(contenHeight - scrollView.frame.height)")
        if offsetY > contenHeight - scrollView.frame.height && offsetY > 0 {
            if !Contains.loadMore && Contains.arrRepo.count < Contains.total_Repos {
                nextPage()
            }
        }
    }
}
