
//
//  Sub2ViewController.swift
//  TennisAnalysis
//
//  Created by 市田圭司 on 2022/01/08.
//

//
//  CustomCollectionViewCell.swift
//  TennisAnalysis
//
//  Created by 市田圭司 on 2021/12/01.
//

import UIKit
import NCMB


protocol CustomCollectionViewCellDelegate {
    func didTapCustomButton(targetCell: UICollectionViewCell, targetButton: UIButton)
}


class CustomCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet var per: UILabel!
    @IBOutlet var gamename: UILabel!
    @IBOutlet var days : UILabel!
    @IBOutlet var img: UIImageView!
    
    
    var delegate: CustomCollectionViewCellDelegate?
    //@IBOutlet var Customcellimage : UIImage!
    //@IBOutlet var CustomcellLabel : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
      //  self.backGroundView.backgroundColor = UIColor.red
        
                                            
        // Initialization code

    }

    
    
    //@IBAction func showcontents(button: UIImage){
    //    self.delegate?.didTapimgeButton(targetCell: self, targetButton:button)
    //}
    
    @IBAction func Custom(button: UIButton){
        self.delegate?.didTapCustomButton(targetCell: self, targetButton: button)
    }
    
    
}
