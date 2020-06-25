//
//  ViewControllerSplash.swift
//  githubapi
//
//  Created by gem on 6/24/20.
//  Copyright © 2020 gem. All rights reserved.
//

import UIKit

class ViewControllerSplash: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let cna = ConnectAPI()
        cna.getListRepo(page: 1)

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
