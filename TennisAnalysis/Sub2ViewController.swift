

import UIKit
import NCMB
class Sub2ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    

    
    var postId : String?
    var myName : String?
    var gameDay:String?
    var gameName : String?
    var partnerName : String?
    var points = [NCMBObject]()
    var selectedPost = [NCMBObject]()
    var selectetdelete : NCMBObject!
    
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
            let delVC = segue.destination as! ShowEditViewController

                    // タップされたセルが何番目なのかを取得
            let selectedIndex = CustomTableView.indexPathForSelectedRow!

                    // 値渡し先の画面に用意しておいた受け取り用の変数にメモを代入
            delVC.selectdelete = points[selectedIndex.row]
        }
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //loadObjectId()
        loadData()
        
        
//        let appearance = UITabBarAppearance()
//        appearance.configureWithOpaqueBackground()
//        appearance.backgroundColor =  UIColor(red: 157, green: 204, blue: 224, alpha: 1)
//        UITabBar.appearance().standardAppearance = appearance
//        if #available(iOS 15.0, *) {
//            UITabBar.appearance().scrollEdgeAppearance = appearance
//        }
    }
    
    
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//
//        let footerView:UITextView = UINib(nibName: "CustomTableViewCell", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! UITextView
//
//        return footerView
//    }
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
                self.points = result as! [NCMBObject]
                self.CustomTableView.reloadData()
                print(self.points,"ddd")
            }
        })
    }
    
    
    
    
    
    
//    func loadgame(){
//        let query = NCMBQuery(className: "tennisgame")
//        query?.whereKey("postId", equalTo: postId)
//        query?.findObjectsInBackground({ result, error in
//            if error != nil {
//                print(error?.localizedDescription)
//            }else{
//                self.selectetdelete = result as! [NCMBObject]
//            }
//        })
//    }
    
    
    
    @IBAction func delete(){
        
        
        let alert: UIAlertController = UIAlertController(title: "注意", message: "このプロジェクトを消去してもいいですか？", preferredStyle: .actionSheet)
        let canselAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: .cancel) { (UIAlertAction) in
            print("キャンセル")
        }
        let okAction: UIAlertAction = UIAlertAction(title: "削除", style: .destructive) { (UIAlertAction) in
            self.selectetdelete.deleteInBackground{ (error) in
                if error != nil {
                    print(error)
                }else{
                    //self.navigationController?.popViewController(animated: true)
                    self.dismiss(animated: true, completion: nil)
                    self.navigationController?.popViewController(animated: true)
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
    
    
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
