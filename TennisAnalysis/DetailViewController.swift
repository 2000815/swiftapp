//
//  DetailViewController.swift
//  TennisAnalysis
//
//  Created by 市田圭司 on 2022/01/05.
//

import UIKit

import NCMB

class DetailViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {
    
    var pickerTag:Int?
    var selectdelete :NCMBObject!
    
    
    @IBOutlet var MypointTextFild : UITextField!
    @IBOutlet var enemypointTextFild : UITextField!
    @IBOutlet var MygameTextFild : UITextField!
    @IBOutlet var enemygameTextFild : UITextField!
    @IBOutlet var foaTextFild : UITextField!
    @IBOutlet var shotTextFild : UITextField!
    @IBOutlet var resultTextFild : UITextField!
    @IBOutlet var updateButton : UIButton!
    @IBOutlet var deleteButton : UIButton!
    @IBOutlet var memoTextView : UITextView!
    
    var alertController: UIAlertController!
    
    
    
    var pickerView : UIPickerView = UIPickerView()
    var pickerView1 : UIPickerView = UIPickerView()
    var pickerView2: UIPickerView = UIPickerView()
    var pickerView3 : UIPickerView = UIPickerView()
    var pickerView4 : UIPickerView = UIPickerView()
    var pickerView5 : UIPickerView = UIPickerView()
    var pickerView6 : UIPickerView = UIPickerView()
    
    
    let point:[String] = ["選択してください","0","15","30","45","A"]
    let game:[String] = ["選択してください","0","1","2","3","4","5","6","7"]
    var foa:[String] = ["選択してください","F(フォアハンド)","B(バックハンド)","その他"]
    let shot:[String] = ["選択してください","S(ストローク)","V(ボレー)","R(リターン)","C(チャンス)","P(パッシング)","L(ロブ)","SV(サーブ)","DF(ダブルフォールト)","Sm(スマッシュ)","Dp(ドロップ)"]
    let result:[String] = ["選択してください","A(エース)","O(アウト)","N(ネット)"]
    
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
        
        updateButton.layer.cornerRadius = 15.0
        deleteButton.layer.cornerRadius = 15.0
        
        
        picker(hav:MypointTextFild)
        picker(hav:enemypointTextFild)
        picker(hav:MygameTextFild)
        picker(hav:enemygameTextFild )
        picker(hav: foaTextFild)
        picker(hav: shotTextFild)
        picker(hav: resultTextFild)
        
        
        MypointTextFild.inputView = pickerView
        enemypointTextFild.inputView = pickerView1
        MygameTextFild.inputView = pickerView2
        enemygameTextFild.inputView = pickerView3
        foaTextFild.inputView = pickerView4
        shotTextFild.inputView = pickerView5
        resultTextFild.inputView = pickerView6
        
        pickerView.tag = 1
        pickerView1.tag = 2
        pickerView2.tag = 3
        pickerView3.tag = 4
        pickerView4.tag = 5
        pickerView5.tag = 6
        pickerView6.tag = 7
        
        pickerView.dataSource = self
        pickerView.delegate = self
        
        pickerView1.dataSource = self
        pickerView1.delegate = self
        
        pickerView2.dataSource = self
        pickerView2.delegate = self
        
        pickerView3.dataSource = self
        pickerView3.delegate = self
        
        pickerView4.dataSource = self
        pickerView4.delegate = self
        
        pickerView5.dataSource = self
        pickerView5.delegate = self
        
        pickerView6.dataSource = self
        pickerView6.delegate = self
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

    
    @IBAction func update(){
        selectdelete.setObject(MypointTextFild.text, forKey: "mypoint")
        selectdelete.setObject(enemypointTextFild.text, forKey: "enemypoint")
        selectdelete.setObject(MygameTextFild.text, forKey: "Mygame")
        selectdelete.setObject(enemygameTextFild.text, forKey: "enemygame")
        selectdelete.setObject(foaTextFild.text, forKey: "foa")
        selectdelete.setObject(shotTextFild.text, forKey: "shot")
        selectdelete.setObject(resultTextFild.text, forKey: "result")
        selectdelete.setObject(memoTextView.text, forKey: "memo")
        
        if  MypointTextFild.text!.count == 0 || enemypointTextFild.text!.count == 0 || MygameTextFild.text!.count == 0 || enemygameTextFild.text!.count == 0 || foaTextFild.text!.count == 0 || shotTextFild.text!.count == 0 || resultTextFild.text!.count == 0{
            alertController = UIAlertController(title: "入力されていない項目があります",message: "メモ欄以外は必ず記入してください",preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (action) in}
            alertController.addAction(okAction)
            present(alertController, animated: true)
            return
        }else{
            selectdelete.saveInBackground{(error) in
                if error != nil{
                    print(error)
                }else{
                    //self.navigationController?.popViewController(animated: true)
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
        

    }
    
    
    func picker(hav: UITextField){
        // 1. ピッカー設定
        // 2. 選択行をハイライト
        pickerView.showsSelectionIndicator = true
        pickerView1.showsSelectionIndicator = true
        pickerView2.showsSelectionIndicator = true
        pickerView3.showsSelectionIndicator = true
        pickerView4.showsSelectionIndicator = true
        pickerView5.showsSelectionIndicator = true
        pickerView6.showsSelectionIndicator = true
        
        
        // 3. 決定・キャンセル用ツールバーの生成
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        let spaceItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        toolbar.setItems([cancelItem, spaceItem, doneItem], animated: true)
        
        // 4. インプットビュー
        MypointTextFild.inputAccessoryView = toolbar
        enemypointTextFild.inputAccessoryView = toolbar
        MygameTextFild.inputAccessoryView = toolbar
        enemygameTextFild.inputAccessoryView = toolbar
        foaTextFild.inputAccessoryView = toolbar
        shotTextFild.inputAccessoryView = toolbar
        resultTextFild.inputAccessoryView = toolbar
        
        
        // 5. デフォルト設定
        pickerView.selectRow(4, inComponent: 0, animated: false)
        pickerView1.selectRow(4, inComponent: 0, animated: false)
        
        
        func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
             hav.endEditing(true)
         }
        
    }
    
    
    
   
        @objc func done() {
            print(pickerTag)
            if pickerView.selectedRow(inComponent: 0) == 0{
                return
            }else if(pickerTag == 1){
                MypointTextFild.endEditing(true)
                MypointTextFild.text = "\(point[pickerView.selectedRow(inComponent:0)])"
                print(pickerView.selectedRow(inComponent:0))
            }else if(pickerTag == 2){
                enemypointTextFild.endEditing(true)
                enemypointTextFild.text = "\(point[pickerView1.selectedRow(inComponent: 0)])"
                print(2)
            }else if(pickerTag == 3){
                MygameTextFild.endEditing(true)
                MygameTextFild.text = "\(game[pickerView2.selectedRow(inComponent:0)])"
                 print(3)
            }else if(pickerTag == 4){
                enemygameTextFild.endEditing(true)
                enemygameTextFild.text = "\(game[pickerView3.selectedRow(inComponent:0)])"
                print(4)
            }else if(pickerTag == 5) {
                foaTextFild.endEditing(true)
                foaTextFild.text = "\(foa[pickerView4.selectedRow(inComponent: 0)])"
            }else if(pickerTag == 6) {
                shotTextFild.endEditing(true)
                shotTextFild.text = "\(shot[pickerView5.selectedRow(inComponent: 0)])"
            }else if(pickerTag == 7){
                resultTextFild.endEditing(true)
                resultTextFild.text = "\(result[pickerView6.selectedRow(inComponent: 0)])"
            }
                
         }
         // 2. キャンセルボタンのアクション指定
         @objc func cancel(){
            MypointTextFild.endEditing(true)
            enemypointTextFild.endEditing(true)
            MygameTextFild.endEditing(true)
            enemygameTextFild.endEditing(true)
            foaTextFild.endEditing(true)
            shotTextFild.endEditing(true)
            resultTextFild.endEditing(true)
         }
         // 3. 画面タップでテキストフィールドを閉じる
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            MypointTextFild.endEditing(true)
            enemypointTextFild.endEditing(true)
            MygameTextFild.endEditing(true)
            enemygameTextFild.endEditing(true)
            foaTextFild.endEditing(true)
            shotTextFild.endEditing(true)
            resultTextFild.endEditing(true)

        }
    
    
    
    @IBAction func delete(){
        
        
        let alert: UIAlertController = UIAlertController(title: "注意", message: "削除してもいいですか？", preferredStyle: .actionSheet)
        let canselAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: .cancel) { (UIAlertAction) in
            print("キャンセル")
        }
        let okAction: UIAlertAction = UIAlertAction(title: "削除", style: .destructive) { (UIAlertAction) in
            self.selectdelete.deleteInBackground{ (error) in
                if error != nil {
                    print(error)
                }else{
                    //self.navigationController?.popViewController(animated: true)
                    self.dismiss(animated: true, completion: nil)
                }
            }
            
        }
        //アラートに設定を反映させる

        
        
        
        alert.popoverPresentationController?.sourceView = self.view
        let screenSize = UIScreen.main.bounds
               // ここで表示位置を調整
               // xは画面中央、yは画面下部になる様に指定
        alert.popoverPresentationController?.sourceRect = CGRect(x: screenSize.size.width/2, y: screenSize.size.height, width: 0, height: 0)

        alert.addAction(okAction)
        alert.addAction(canselAction)
        
        //アラート画面を表示させる
        present(alert, animated: true, completion: nil)
        //アラートを表示する↑＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
    }
        
        
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ picker: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(picker.tag == 1 || picker.tag == 2){
            return point.count
        }else if(picker.tag == 3 || picker.tag == 4){
            return game.count
        }else if(picker.tag == 5){
            return foa.count
        }else if(picker.tag == 6){
            return shot.count
        }else{
            return result.count
        }
        
    }
    
    func pickerView(_ picker: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(picker.tag == 1 || picker.tag == 2){
            return point[row] as! String
        }else if(picker.tag == 3 || picker.tag == 4){
            return game[row] as String
        }else if(picker.tag == 5){
            return foa[row] as String
        }else if(picker.tag == 6){
            return shot[row] as String
        }else{
            return result[row] as String
        }
    }
    
    
    func pickerView(_ picker: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerTag = picker.tag
        
        if row == 0{
            var str = ""
            if(picker.tag == 1){
                MypointTextFild.text = str
            }else if(picker.tag == 2){
                enemypointTextFild .text = str
            }else if(picker.tag == 3){
                 MygameTextFild.text = str
            }else if(picker.tag == 4){
                enemygameTextFild.text = str
            }else if(picker.tag == 5){
                 foaTextFild.text = str
            }else if(picker.tag == 6){
                shotTextFild.text = str
            }else if(picker.tag == 7){
                resultTextFild.text = str
            }
        }else{
            if(picker.tag == 1){
                MypointTextFild.text = point[row]
            }else if(picker.tag == 2){
                enemypointTextFild .text = point[row]
            }else if(picker.tag == 3){
                 MygameTextFild.text = game[row]
            }else if(picker.tag == 4){
                enemygameTextFild.text = game[row]
            }else if(picker.tag == 5){
                 foaTextFild.text = foa[row]
            }else if(picker.tag == 6){
                shotTextFild.text = shot[row]
            }else if(picker.tag == 7){
                resultTextFild.text = result[row]
            }
        }
       
    }
        
        
 
        
        
    
}
