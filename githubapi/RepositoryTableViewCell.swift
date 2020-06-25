//
//  RepositoryTableViewCell.swift
//  githubapi
//
//  Created by gem on 6/23/20.
//  Copyright © 2020 gem. All rights reserved.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {

    

    @IBOutlet weak var reponame: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var numberStar: UILabel!
    @IBOutlet weak var numberIssue: UILabel!
    @IBOutlet weak var numberWatcher: UILabel!
    @IBOutlet weak var numberFork: UILabel!
    @IBOutlet weak var lastUpdate: UILabel!
    @IBOutlet weak var useravatar: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
