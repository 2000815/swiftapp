//
//  ScoreViewController.swift
//  TennisAnalysis
//
//  Created by 市田圭司 on 2021/12/23.
//

import UIKit
import NCMB

class ScoreViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{

    
    
    var postId : String?
    var myName : String?
    var gameDay:String?
    var gameName : String?
    var partnerName : String?
    
    var selectedPost : NCMBObject?
    @IBOutlet var introduceTableView: UITableView!
    
    //pointsクラスのpostIdが一致するものを格納する配列
    var points = [NCMBObject]()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        introduceTableView?.dataSource = self
        introduceTableView?.delegate = self
        
        let nib = UINib(nibName: "SyosaiTableViewCell", bundle: Bundle.main)
        introduceTableView?.register(nib, forCellReuseIdentifier: "Cell")
        
        
        // Do any additional setup after loading the view.
        
        UITabBar.appearance().backgroundColor = UIColor(red: 157, green: 204, blue: 224, alpha: 1)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        loadObjectId()
        loadData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPost"{
            let pcVC = segue.destination as! PckerViewController
            pcVC.postId = postId
            
        }
        
        
        
        if segue.identifier == "toDetail" {

                    // 値渡し先の画面を取得
            let delVC = segue.destination as! DetailViewController

                    // タップされたセルが何番目なのかを取得
            let selectedIndex = introduceTableView.indexPathForSelectedRow!

                    // 値渡し先の画面に用意しておいた受け取り用の変数にメモを代入
            delVC.selectdelete = points[selectedIndex.row]

        }
        
        
        
    }
    
    
    
    
    func loadObjectId(){
        let query = NCMBQuery(className: "tennisgame")
        query?.whereKey("day", equalTo: gameDay!)
        query?.whereKey("name", equalTo: myName!)
        query?.whereKey("gameName", equalTo: gameName!)
        query?.whereKey("partnerName", equalTo: partnerName!)
        query?.findObjectsInBackground({ result, error in
            if error != nil {
                print(error?.localizedDescription)
            }else{
                if result?.count != 0{
                    var post = result?.first as! NCMBObject
                    self.postId = post.objectId
                    print(self.postId)
                    print(self.gameDay)
                    print(self.myName)
                }else{
                    print("なし")
                }
            }
        })
            
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

            // 画面遷移を実行(segueのIDが一致している確認)
            self.performSegue(withIdentifier: "toDetail", sender: nil)

        }
    
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
            
        let footerView:UITextView = UINib(nibName: "FooterView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! UITextView
                
        return footerView
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return points.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = introduceTableView.dequeueReusableCell(withIdentifier: "Cell") as! SyosaiTableViewCell
        
        cell.mygame.text = points[indexPath.row].object(forKey: "Mygame") as! String
        cell.enemygame.text = points[indexPath.row].object(forKey: "enemygame") as! String
        cell.mypoint.text = points[indexPath.row].object(forKey: "mypoint") as! String
        cell.enemypoint.text = points[indexPath.row].object(forKey: "enemypoint") as! String
        
        var foa = points[indexPath.row].object(forKey: "foa") as! String
        var shot = points[indexPath.row].object(forKey: "shot") as! String
        var result = points[indexPath.row].object(forKey: "result") as! String
        
        var last = foa+shot+result
        cell.foa.text = last as String
        
        //cell.mygame.text = MyGame[indexPath.row]
        
        
        
        
        
        
        //cell.tag = indexPath.row
       // let user = tennisgame[indexPath.row].object(forKey: "myName") as! NCMBUser
        return cell
    }
    
    
    
    
    
    
    func loadData(){
        let query = NCMBQuery(className: "points")
        query?.whereKey("postId", equalTo: postId)
        query?.order(byAscending: "createDate")
        query?.findObjectsInBackground({ result, error in
            if error != nil {
                print(error?.localizedDescription)
            }else{
                self.points = result as! [NCMBObject]
                print(self.postId)
                
                self.introduceTableView.reloadData()
            }
        })
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
