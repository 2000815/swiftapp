//
//  SubViewController.swift
//  TennisAnalysis
//
//  Created by 市田圭司 on 2021/12/20.
//

import UIKit
import NCMB

class SubViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    var postId : String?
    var myName : String?
    var gameDay:String?
    var gameName : String?
    var partnerName : String?
    var points = [NCMBObject]()
    var selectedPost = [NCMBObject]()
    
    @IBOutlet var CustomTableView: UITableView!
    var acounts : [NCMBObject] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        CustomTableView?.dataSource = self
        CustomTableView?.delegate = self
        
        let nib = UINib(nibName: "CustomTableViewCell", bundle: Bundle.main)
        CustomTableView?.register(nib, forCellReuseIdentifier: "toCustom")
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toShow"{
            let delVC = segue.destination as! ShowViewController

                    // タップされたセルが何番目なのかを取得
            let selectedIndex = CustomTableView.indexPathForSelectedRow!

                    // 値渡し先の画面に用意しておいた受け取り用の変数にメモを代入
            delVC.selectdelete = points[selectedIndex.row]
        }
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //loadObjectId()
        loadData()
//        tabBarController?.tabBar.layer.borderWidth = 0.50
//        tabBarController?.tabBar.layer.borderColor = UIColor.gray.cgColor
//        tabBarController?.tabBar.clipsToBounds = true
//        
        UITabBar.appearance().barTintColor = UIColor.red
        //print("ｗｗｗｗｗｗｗｗｗｗｗｗｗｗｗ")
        //UIColor(red: 87, green: 154, blue: 156, alpha: 0.5)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return points.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CustomTableView.dequeueReusableCell(withIdentifier: "toCustom") as! CustomTableViewCell
        
        cell.mygame.text = points[indexPath.row].object(forKey: "Mygame") as! String
        cell.enemygame.text = points[indexPath.row].object(forKey: "enemygame") as! String
        cell.mypoint.text = points[indexPath.row].object(forKey: "mypoint") as! String
        cell.enemypoint.text = points[indexPath.row].object(forKey: "enemypoint") as! String
        
        var foa = points[indexPath.row].object(forKey: "foa") as! String
        var shot = points[indexPath.row].object(forKey: "shot") as! String
        var result = points[indexPath.row].object(forKey: "result") as! String
        
        var last = foa+shot+result
        cell.foa.text = last as String
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

            // 画面遷移を実行(segueのIDが一致している確認)
        self.performSegue(withIdentifier: "toShow", sender: nil)

    }
    
    
    
    
    
    func loadData(){
        
        let query = NCMBQuery(className: "points")
        query?.whereKey("postId", equalTo:postId)
        //query?.order(byAscending: "createDate")
        print(postId,"bbb")
        query?.findObjectsInBackground({ (result, error) in
            if error != nil {
                print(error?.localizedDescription,"ccc")
            }else{
                if self.postId != nil {
                    self.points = result as! [NCMBObject]
                    self.CustomTableView.reloadData()
                    print(self.points,"ddd")
                
                }
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
