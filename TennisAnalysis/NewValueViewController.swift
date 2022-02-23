//
//  NewValueViewController.swift
//  TennisAnalysis
//
//  Created by 市田圭司 on 2021/12/07.
//

import UIKit
import NCMB

class NewValueViewController: UIViewController {
    
    var postId : String!
    
  //  @IBOutlet var gamedate : UITextField!
    
    @IBOutlet var gamename : UITextField!
    
    @IBOutlet var myname :UITextField!
    
    @IBOutlet var partnername : UITextField!
    
    @IBOutlet var creativeButton : UIButton!
    
    @IBOutlet var daytextField: UITextField!
    
    var datePicker: UIDatePicker = UIDatePicker()
    
    var alertController: UIAlertController!


    
    override func viewDidLoad() {
        super.viewDidLoad()
        creativeButton.layer.cornerRadius = 15.0

        
        
        
        datePicker.datePickerMode = UIDatePicker.Mode.date
        datePicker.timeZone = NSTimeZone.local
        datePicker.locale = Locale.current
        datePicker.preferredDatePickerStyle = .wheels
        daytextField.inputView = datePicker
        
         
         // 決定バーの生成
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        toolbar.setItems([spacelItem, doneItem], animated: true)
        
        
        
        
        
        
        
        
         
         // インプットビュー設定
        daytextField.inputView = datePicker
        daytextField.inputAccessoryView = toolbar
        // Do any additional setup after loading the view.
        
        if let user = NCMBUser.current(){
            self.myname.text = user.userName
        }
       // myname.text = NCMBUser.current() as? String
    }
    
    @objc func done() {
        daytextField.endEditing(true)
        
        // 日付のフォーマット
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        daytextField.text = "\(formatter.string(from: datePicker.date))"
        
    }
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
    
    
    //postIdを統一する
    @IBAction func save(){
        let newquery = NCMBObject(className:"tennisgame")
        newquery?.setObject(myname.text, forKey: "name")
        newquery?.setObject(NCMBUser.current(), forKey: "user")
        newquery?.setObject(daytextField.text, forKey: "day")
        newquery?.setObject(partnername.text, forKey: "partnerName")
        newquery?.setObject(gamename.text, forKey: "gameName")
        
        if  gamename.text!.count == 0 || myname.text!.count == 0 || partnername.text!.count == 0 || daytextField.text!.count == 0 {
            alertController = UIAlertController(title: "入力されていない項目があります",message: "もう一度見直してください",preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (action) in}
            alertController.addAction(okAction)
            
            alertController.popoverPresentationController?.sourceView = self.view
            let screenSize = UIScreen.main.bounds
                   // ここで表示位置を調整
                   // xは画面中央、yは画面下部になる様に指定
            alertController.popoverPresentationController?.sourceRect = CGRect(x: screenSize.size.width/2, y: screenSize.size.height, width: 0, height: 0)
            self.present(alertController, animated: true)
            return
        }else{
            newquery?.saveInBackground({ error in
                if (error != nil) {
                    print(error)
                } else {
                    print("saved")
                    self.postId = newquery?.objectId
                }
            })
            
            
            
            
            performSegue(withIdentifier: "addScore",sender: nil)
        
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addScore"{
            let scoreVC = segue.destination as! ScoreViewController
            scoreVC.postId = postId
            scoreVC.myName = myname.text
            scoreVC.gameDay = daytextField.text
            scoreVC.partnerName = partnername.text
            scoreVC.gameName = gamename.text
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

}
