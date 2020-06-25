//
//  WebRepoViewController.swift
//  githubapi
//
//  Created by gem on 6/25/20.
//  Copyright © 2020 gem. All rights reserved.
//

import UIKit

class WebRepoViewController: UIViewController {
    
    @IBOutlet weak var repoWebView: UIWebView!
    var urlRepo = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        if let url = URL(string: urlRepo) {
            repoWebView.loadRequest(URLRequest(url: url))
        }
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
