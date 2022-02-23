//
//  userPageViewController.swift
//  TennisAnalysis
//
//  Created by 市田圭司 on 2021/12/01.
//

import UIKit

import NCMB

import PKHUD
import SwiftUI

class userPageViewController:UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,CustomCollectionViewCellDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    

    

    
    
    
    @IBOutlet var userImageView : UIImageView!
    @IBOutlet var userIdTextField : UITextField!
    @IBOutlet var userPasTextField : UITextField!
    @IBOutlet var collectionView: UICollectionView!
    
    var acounts = [NCMBObject]()
    var selectedPost:NCMBObject?
    var objectId : String?
//    let Resize:CGSize = CGSize.init(width: 128, height:128)
//    let userImageView = self().userImageView.Resize(size : Resize)

    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        userImageView.layer.cornerRadius = userImageView.frame.height / 1.3
//        userImageView.layer.cornerRadius = userImageView.bounds.height / 1
 
        userImageView.frame = CGRect(x:25, y: 65, width: 110, height: 110)
//        userImageView.size.width = 128
//        userImageView.size.height = 128
        userImageView.contentMode = .scaleAspectFill
        userImageView.clipsToBounds = true
        userImageView.layer.cornerRadius = userImageView.frame.height / 2.0


   //     userImageView.circle()
        
        
        
        
        collectionView?.delegate = self
        collectionView?.dataSource = self
        
        let nib = UINib(nibName: "CustomCollectionViewCell", bundle: Bundle.main)
        collectionView.register(nib, forCellWithReuseIdentifier: "Cell")
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 150, height: 150)
        collectionView.collectionViewLayout = layout
        
        
        userImageView.isUserInteractionEnabled = true
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadDate()
//        if #available(iOS 15.0, *) {
//            let appearance = UITabBarAppearance()
//            appearance.backgroundColor =  UIColor(red: 157, green: 204, blue: 224, alpha: 1)
//            UITabBar.appearance().scrollEdgeAppearance = appearance
//        }
    }

    func collectionView(_ collectionView: UICollectionView,didSelectItemAt indexPath: IndexPath) {
        
        if acounts != nil {
            self.objectId = acounts[indexPath.row].objectId
            
            self.selectedPost = acounts[indexPath.row]
            // SubViewController へ遷移するために Segue を呼び出す
            performSegue(withIdentifier: "toSub2",sender: nil)
        }
 
    }

    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CustomCollectionViewCell
        
        cell.days.text = acounts[indexPath.row].object(forKey: "day") as! String
        cell.per.text = acounts[indexPath.row].object(forKey: "partnerName") as! String
        cell.gamename.text = acounts[indexPath.row].object(forKey: "gameName") as! String
        cell.layer.cornerRadius = 15
        cell.delegate = self
        //cell.backgroundColor = UIColor.gray
        //cell.testShowImage.image = [indexPath.row]
        return cell
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return acounts.count
    }
    
        

        
    
    func didTapCustomButton(targetCell targetell: UICollectionViewCell, targetButton button:UIButton){
//        selectedPost = acounts[targetell.tag]
//        self.performSegue(withIdentifier: "toUser", sender: nil)
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)

            // ユーザー情報をNCMBUserから取得
            // .currentが期限切れか判定
            if let user = NCMBUser.current() {
                // navigationBarのタイトルにuserIdを反映
    //            self.navigationItem.title = user.object(forKey: "userName") as? String
                self.userIdTextField.text = user.userName
                self.userPasTextField.text = user.mailAddress

                // NCMBFileからuserIdが結合しているimageFileをgetする(クエリを投げる方法もある)
                let file = NCMBFile.file(withName: (user.objectId)!, data: nil) as! NCMBFile
                file.getDataInBackground { (data, error) in
                    if error != nil {
                        print(error.debugDescription)
                        return
                    }

                    // 取得したimageを反映
                    if let image = UIImage(data: data!) {
                        self.userImageView.image = image
                    }

                }
            } else {
                // NCMBUser.currentがnilの場合=有効期限切れ→ログインし直させる
                // 遷移先ストーリーボードを取得
                let storyboard = UIStoryboard(name: "signin", bundle: .main)
                let rootVC = storyboard.instantiateViewController(identifier: "RootNavigationController")
                // モーダルをフルスクリーン表示
                rootVC.modalPresentationStyle = .fullScreen
                // 画面表示
                self.present(rootVC, animated: true, completion: nil)

                // ログアウト状態を端末に保存
                let ud = UserDefaults.standard
                ud.set(false, forKey: "isLogin")
            }

    }
    
    
        // メニュー表示(ログアウト)
        @IBAction func showMenu(_ sender: Any) {

            let alertController = UIAlertController(title: "メニュー", message: "メニューを選択してください", preferredStyle: .actionSheet)

            // キャンセルシート
            let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel) { (action) in
                self.dismiss(animated: true, completion: nil)
            }

            // ログアウトシート
            let logOutAction = UIAlertAction(title: "ログアウト", style: .default) { (action) in

                // ログアウトを実行
                NCMBUser.logOutInBackground { (error) in
                    if error != nil {
                        print(error.debugDescription)
                        return
                    }

                    // ログアウト成功
                    // 遷移先ストーリーボードを取得
                    let storyboard = UIStoryboard(name: "signin", bundle: .main)
                    let rootVC = storyboard.instantiateViewController(identifier: "RootNavigationController")
                    // モーダルをフルスクリーン表示
                    rootVC.modalPresentationStyle = .fullScreen
                    // 画面表示
                    self.present(rootVC, animated: true, completion: nil)

                    // ログアウト状態を端末に保存
                    let ud = UserDefaults.standard
                    ud.set(false, forKey: "isLogin")
                    ud.synchronize()
                }

            }
            
            
            
            
            
            
            
            
            
            
            
            
            
            

            // 退会シート→アラートの中にアラート
            // 退会→userのactiveがfalseに変更される
            let signOutAction = UIAlertAction(title: "退会", style: .default) { (action) in

                let alert = UIAlertController(title: "会員登録の解除", message: "本当に退会しますか？退会した場合、再度このアカウントをご利用頂くことができません。", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                    // ユーザーのアクティブ状態をfalseに
                    if let user = NCMBUser.current() {
                        HUD.show(.progress, onView: self.view)
                        user.setObject(false, forKey: "active")
                        user.saveInBackground({ (error) in
                            HUD.hide(animated: true)
                            if error != nil {
                                print(error?.localizedDescription)
                                // テキストを指定してエラー内容を表示→1秒後に消える
                                HUD.flash(.labeledError(title: "エラー", subtitle: "退会に失敗しました"), delay: 1)
                            } else {
                                // userのアクティブ状態を変更できたらログイン画面に移動
                                // 遷移先ストーリーボードを取得
                                let storyboard = UIStoryboard(name: "signin", bundle: .main)
                                let rootVC = storyboard.instantiateViewController(identifier: "RootNavigationController")
                                // モーダルをフルスクリーン表示
                                rootVC.modalPresentationStyle = .fullScreen
                                // 画面表示
                                self.present(rootVC, animated: true, completion: nil)

                                // ログアウト状態を端末に保存
                                let ud = UserDefaults.standard
                                ud.set(false, forKey: "isLogin")
                                ud.synchronize()
                            }
                        })
                    } else {
                        // userがnilだった場合ログイン画面に移動
                        // 遷移先ストーリーボードを取得
                        let storyboard = UIStoryboard(name: "signin", bundle: .main)
                        let rootVC = storyboard.instantiateViewController(identifier: "RootNavigationController")
                        // モーダルをフルスクリーン表示
                        rootVC.modalPresentationStyle = .fullScreen
                        // 画面表示
                        self.present(rootVC, animated: true, completion: nil)

                        // ログアウト状態を端末に保存
                        let ud = UserDefaults.standard
                        ud.set(false, forKey: "isLogin")
                        ud.synchronize()
                    }

                })

                let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: { (action) in
                    alert.dismiss(animated: true, completion: nil)
                })

                alert.addAction(okAction)
                alert.addAction(cancelAction)
               // alert.popoverPresentationController?.sourceView = self.view
                
                alert.popoverPresentationController?.sourceView = self.view
                let screenSize = UIScreen.main.bounds
                       // ここで表示位置を調整
                       // xは画面中央、yは画面下部になる様に指定
                alert.popoverPresentationController?.sourceRect = CGRect(x: screenSize.size.width/2, y: screenSize.size.height, width: 0, height: 0)
                self.present(alert, animated: true, completion: nil)

            }
            
            
            
            let CAction = UIAlertAction(title: "アカウント編集", style: .default) { (action) in

                    // ログアウト成功
                    // 遷移先ストーリーボードを取得
                self.performSegue(withIdentifier: "toAcount", sender: nil)
 
            }

            // アラートを表示
            
            alertController.addAction(logOutAction)
            alertController.addAction(signOutAction)
            alertController.addAction(CAction)
            alertController.addAction(cancelAction)
            
            
            alertController.popoverPresentationController?.sourceView = self.view
            let screenSize = UIScreen.main.bounds
                   // ここで表示位置を調整
                   // xは画面中央、yは画面下部になる様に指定
            alertController.popoverPresentationController?.sourceRect = CGRect(x: screenSize.size.width/2, y: screenSize.size.height, width: 0, height: 0)
            self.present(alertController, animated: true, completion: nil)

        }
    
    
    func loadDate(){
        let query = NCMBQuery(className: "tennisgame")
        query?.whereKey("user", equalTo: NCMBUser.current())
        query?.findObjectsInBackground({ result, error in
            if error != nil {
                print(error?.localizedDescription)
            }else{
                self.acounts = result as! [NCMBObject]
                self.collectionView.reloadData()
                
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if (segue.identifier == "toSub2") {
            let subVC = segue.destination as! Sub2ViewController
            
            subVC.postId = objectId
            
            
            subVC.selectetdelete = selectedPost
    
            //ここで情報を絞ってsuVCにわたすコードを書く
        }
    }

    
    
    
 
    
}
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
