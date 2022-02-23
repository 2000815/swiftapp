//
//  singnUpViewController.swift
//  TennisAnalysis
//
//  Created by 市田圭司 on 2021/11/25.
//

import UIKit
import NCMB

class SignUpViewController: UIViewController,UITextFieldDelegate{
    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var mailAddressTextField: UITextField!
    @IBOutlet var passWordTextField: UITextField!
    @IBOutlet var confirmTextField: UITextField!
    var alertController: UIAlertController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //キーボードを閉じる
        textField.resignFirstResponder()
        return true
    }

    @IBAction func signUp(){
        //どれか一つでもTextFieldが埋まっていなければ、サインアップの処理を行わない。
        if  userNameTextField.text?.count == 0 || mailAddressTextField.text?.count == 0 || passWordTextField.text!.count <= 3 || confirmTextField.text!.count <= 4 || (passWordTextField.text != confirmTextField.text) {
            return
        }else if mailAddressTextField.text?.contains("@") == false{
            //@が入っていなければアラートを出す
            alertController = UIAlertController(title: "入力された文字の中に@が入っていません",
                                                message: "メールアドレスを入力してください!",
                                                preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            }
            alertController.addAction(okAction)
            present(alertController, animated: true)
            return
        }
        let user = NCMBUser()
        user.userName = userNameTextField.text!
        user.mailAddress = mailAddressTextField.text!
        user.password = passWordTextField.text!
        var acl = NCMBACL()
        //読み込み・検索を全開放(ACLの設定で全員から参照できるようにする)
        acl.setPublicReadAccess(true)
        acl.setPublicWriteAccess(true)
        user.acl = acl
        //ユーザーが退会済みかを判定する。falseなら退会済み
        user.setObject(true, forKey: "active")
        user.setObject("", forKey: "displayName")
        user.signUpInBackground { (error) in
            if error != nil{
                print(error)
            }else{
                //ログインしたら、画面遷移
                let storyboard = UIStoryboard(name: "Main",bundle: Bundle.main)
                let rootViewController = storyboard.instantiateViewController(withIdentifier: "RootTabBarController")
                UIApplication.shared.windows.first { $0.isKeyWindow }?.rootViewController = rootViewController
                //ログイン状態を保持
                let ud = UserDefaults.standard
                ud.set(true, forKey: "isLogin")
                
            }

        }
    }
}
