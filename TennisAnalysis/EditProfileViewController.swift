//
//  EditProfileViewController.swift
//  TennisAnalysis
//
//  Created by 市田圭司 on 2022/01/12.
//

import UIKit
import NCMB

class EditProfileViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    
    
    
    @IBOutlet weak var userImageView :UIImageView!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userIdTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        userNameTextField.delegate = self
        userIdTextField.delegate = self
        // Do any additional setup after loading the view.
        
        
        loadUserData()
        userImageView.frame = CGRect(x:130, y: 170, width: 110, height: 110)
        userImageView.contentMode = .scaleAspectFill
        userImageView.clipsToBounds = true
        userImageView.layer.cornerRadius = userImageView.frame.height / 2.0
        
        let file = NCMBFile.file(withName: (NCMBUser.current()?.objectId)!, data: nil ) as! NCMBFile
        file.getDataInBackground{(data, error) in
            if error != nil{
                print(error.debugDescription)
                return
            }
            
            if let image = UIImage(data: data!){
                self.userImageView.image = image
            }
            
        }

        // Do any additional setup after loading the view.
    }
    
    func loadUserData(){
        
        if let user = NCMBUser.current(){
            userNameTextField.text = user.object(forKey: "userName") as? String
            userIdTextField.text = user.mailAddress
        
        }else{
            
            let storyboard = UIStoryboard(name:"Signin", bundle: .main)
            let rootVC = storyboard.instantiateViewController(identifier: "RootSigninVC")
            
            rootVC.modalPresentationStyle = .fullScreen
            
            self.present(rootVC, animated: true, completion: nil)
            let ud = UserDefaults.standard
            ud.set(false, forKey: "isLogin")
            ud.synchronize()
            
            
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func saveUserInfo(_ sender: Any){
        
        if let user = NCMBUser.current(){
            
            user.setObject(userNameTextField.text, forKey:"userName")
            user.setObject(userIdTextField.text, forKey: "mailAddress")
            
            user.saveInBackground({(error) in
                if error != nil{
                    print(error.debugDescription)
                    return
                }
                
                self.navigationController?.popViewController(animated: true)
                self.dismiss(animated: true, completion: nil)
                
            })
        }else{
            let storyboard = UIStoryboard(name:"Signin", bundle: .main)
            let rootVC = storyboard.instantiateViewController(identifier: "RootSigninVC")
            
            
            rootVC.modalPresentationStyle = .fullScreen
            
            self.present(rootVC, animated: true ,completion: nil)
            
            
            //ログアウト
            let ud = UserDefaults.standard
            ud.set(false, forKey: "isLogin")
            ud.synchronize()
            
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func selectImage(_ sender: Any) {
        
        let actionController = UIAlertController(title: "画像の選択", message: "選択してください", preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "カメラ", style: .default) { (action) in

                    // カメラ起動
            let picker = UIImagePickerController()
            picker.sourceType = .camera
            picker.delegate = self
            picker.allowsEditing = true
            self.present(picker, animated: true, completion: nil)
        }
        
        
        let albumAction = UIAlertAction(title: "アルバム", style: .default) { (action) in

                    // アルバム起動
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.delegate = self
            picker.allowsEditing = true
            self.present(picker, animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel) { (action) in
            self.dismiss(animated: true, completion: nil)
        }

        actionController.addAction(cameraAction)
        actionController.addAction(albumAction)
        actionController.addAction(cancelAction)
        
        
        
        
        
        actionController.popoverPresentationController?.sourceView = self.view
        let screenSize = UIScreen.main.bounds
               // ここで表示位置を調整
               // xは画面中央、yは画面下部になる様に指定
        actionController.popoverPresentationController?.sourceRect = CGRect(x: screenSize.size.width/2, y: screenSize.size.height, width: 0, height: 0)
        self.present(actionController, animated: true, completion: nil)
        
        
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey :Any]) {
        if let pickerImage = info[.editedImage] as? UIImage {
            userImageView.image = pickerImage
            
            picker.dismiss(animated: true, completion: nil)
            
            let imageData = pickerImage.jpegData(compressionQuality: 0.1)
            
            let file = NCMBFile.file(withName: NCMBUser.current()?.objectId, data: imageData) as! NCMBFile
            
            file.saveInBackground{(error) in
                if error != nil {
                    print(error.debugDescription)
                    return
                }else{
                    self.userImageView.image = pickerImage
                }
                
            }progressBlock: { (progress) in
                print(progress)
            }

        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
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



