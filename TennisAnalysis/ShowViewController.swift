//
//  ShowViewController.swift
//  TennisAnalysis
//
//  Created by 市田圭司 on 2022/01/11.
//

import UIKit

import NCMB

class ShowViewController: UIViewController {
    
    
    var selectdelete :NCMBObject!
    
    
    @IBOutlet var MypointTextFild : UITextField!
    @IBOutlet var enemypointTextFild : UITextField!
    @IBOutlet var MygameTextFild : UITextField!
    @IBOutlet var enemygameTextFild : UITextField!
    @IBOutlet var foaTextFild : UITextField!
    @IBOutlet var shotTextFild : UITextField!
    @IBOutlet var resultTextFild : UITextField!
    @IBOutlet var memoTextView : UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        MypointTextFild.text = selectdelete.object(forKey: "mypoint") as! String
        enemypointTextFild.text = selectdelete.object(forKey: "enemypoint") as! String
        MygameTextFild.text = selectdelete.object(forKey: "Mygame") as! String
        enemygameTextFild.text = selectdelete.object(forKey: "enemygame") as! String
        foaTextFild.text = selectdelete.object(forKey: "foa") as! String
        shotTextFild.text = selectdelete.object(forKey: "shot") as! String
        resultTextFild.text = selectdelete.object(forKey: "result") as! String
        memoTextView.text = selectdelete.object(forKey: "memo") as? String
        
        // Do any additional setup after loading the view.
    }
    
    
    
}


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */



