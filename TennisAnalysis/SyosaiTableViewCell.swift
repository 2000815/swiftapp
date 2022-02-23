//
//  SyosaiTableViewCell.swift
//  TennisAnalysis
//
//  Created by 市田圭司 on 2021/12/01.
//

import UIKit

class SyosaiTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet var mygame: UILabel!
    @IBOutlet var enemygame: UILabel!
    @IBOutlet var mypoint: UILabel!
    @IBOutlet var enemypoint: UILabel!
    @IBOutlet var foa :UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
}
