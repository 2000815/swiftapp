//
//  CustomTableViewCell.swift
//  TennisAnalysis
//
//  Created by 市田圭司 on 2021/12/01.
//

import UIKit


//protocol CustomTableViewCellDelegate{
//    func didTapCustomButton(targetCell: UICollectionViewCell, targetbutton:UIButton)
//}

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet var mygame: UILabel!
    @IBOutlet var enemygame: UILabel!
    @IBOutlet var mypoint: UILabel!
    @IBOutlet var enemypoint: UILabel!
    @IBOutlet var foa :UILabel!
    
  //  var delegate :CustomTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
