//
//  signinViewController.swift
//  TennisAnalysis
//
//  Created by 市田圭司 on 2021/11/25.
//
import UIKit
import NCMB
import PKHUD

class SignInViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        userNameTextField.delegate = self
        passwordTextField.delegate = self
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //キーボードを閉じる
        textField.resignFirstResponder()
        return true
    }

    @IBAction func signIn(){
        HUD.show(.progress)
        NCMBUser.logInWithUsername(inBackground: userNameTextField.text!, password: passwordTextField.text!) { user, error in
            if error != nil{
                HUD.hide(animated: true)
                print(error)
            }else{
                HUD.hide(animated: true)
                let storyboard = UIStoryboard(name: "Main",bundle: Bundle.main)
                let rootViewController = storyboard.instantiateViewController(withIdentifier: "RootTabBarController")
                UIApplication.shared.windows.first { $0.isKeyWindow }?.rootViewController = rootViewController
                //ログイン状態を保持する
                let ud = UserDefaults.standard
                ud.set(true, forKey: "isLogin")

            }
        }
    }
}
