//
//  ViewController.swift
//  TennisAnalysis
//
//  Created by 市田圭司 on 2021/11/25.
//

import UIKit
import NCMB
import SwiftUI

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,CustomCollectionViewCellDelegate{


    @IBOutlet var collectionView: UICollectionView!
    
    var objectId: String?
    var testShow = [NCMBObject]()
    var selectedPost:NCMBObject?
    var acounts = [NCMBObject]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView?.delegate = self
        collectionView?.dataSource = self
        
        let nib = UINib(nibName: "CustomCollectionViewCell", bundle: Bundle.main)
        collectionView.register(nib, forCellWithReuseIdentifier: "Cell")
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 150, height: 150)
        collectionView.collectionViewLayout = layout
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadData()
        tabBarController?.tabBar.layer.borderWidth = 0.50
        tabBarController?.tabBar.layer.borderColor = UIColor.gray.cgColor
        tabBarController?.tabBar.clipsToBounds = true
        

    }
    
    
    func loadData(){
        let query = NCMBQuery(className: "tennisgame")
        query?.findObjectsInBackground({ result, error in
            if error != nil {
                print(error?.localizedDescription)
            }else{
                self.acounts = []
                //self.acounts = result as! [NCMBObject]
            //ここで同じ値が
//                for acounts in result as! [NCMBObject] {
//                   // print(acounts[0].object(forKey: "objectId") as! String)
//                    print(acounts.object(forKey: "objectId") as! String)
//                }
                self.acounts = result as! [NCMBObject]
                self.collectionView.reloadData()
                
            }
        })
    }
    
    
//    private func numberOfItemsInRow(_ number: CGFloat) {
//
//            let layout = UICollectionViewFlowLayout()
//            let width = self.view.frame.size.width / number
//            let height = width
//            layout.itemSize = CGSize(width: width, height: height)
//            layout.minimumLineSpacing = 10
//            layout.minimumInteritemSpacing = 0
//
//            collectionView.collectionViewLayout = layout
//        }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return acounts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CustomCollectionViewCell
        
//        if let user = acounts[indexPath.row].object(forKey: "user") as? NCMBUser{
//            //print(user.objectId)
//            if user.objectId == NCMBUser.current().objectId{
//                cell.img.image = UIImage(named: "myf.jpeg")
//            }else{
//              //  cell.img.image = UIImage(named: "f.jpeg")
//            }
//        }else{
//            cell.img.image = UIImage(named: "f.jpeg")
//        }
        //print(acounts[indexPath.row].object(forKey: "day") as! String)
        cell.days.text = acounts[indexPath.row].object(forKey: "day") as! String
        cell.per.text = acounts[indexPath.row].object(forKey: "partnerName") as! String
        cell.gamename.text = acounts[indexPath.row].object(forKey: "gameName") as! String
        cell.layer.cornerRadius = 15
        
        
        
        //cell.backgroundColor = UIColor.gray
        //cell.testShowImage.image = [indexPath.row]
        return cell
    }

    
    
    func collectionView(_ collectionView: UICollectionView,didSelectItemAt indexPath: IndexPath) {
        
        if acounts != nil {
            self.objectId = acounts[indexPath.row].objectId
            // SubViewController へ遷移するために Segue を呼び出す
            performSegue(withIdentifier: "toSub",sender: nil)
        }
 
    }
    
    
    func didTapCustomButton(targetCell targetell: UICollectionViewCell, targetButton button:UIButton){
        selectedPost = acounts[targetell.tag]
        self.performSegue(withIdentifier: "toSub", sender: nil)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if (segue.identifier == "toSub") {
            let subVC = segue.destination as! SubViewController
            
            subVC.postId = objectId
            
          //  subVC.postId = self.acounts as? String
    
            //ここで情報を絞ってsuVCにわたすコードを書く
        }
    }
    
    
   
    

}

