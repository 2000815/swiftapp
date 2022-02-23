//
//  MyUINavigationViewController.swift
//  TennisAnalysis
//
//  Created by 市田圭司 on 2022/01/08.
//

import UIKit

class MyUINavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.navigationBar.backgroundColor = UIColor. // その他UIColor.white等好きな背景色
        // ナビゲーションバーのアイテムの色　（戻る　＜　とか　読み込みゲージとか）
//        tabBarController?.tabBar.layer.borderWidth = 0.50
//        tabBarController?.tabBar.layer.borderColor = UIColor.gray.cgColor
//        tabBarController?.tabBar.backgroundColor = UIColor(red: 87, green: 154, blue: 156, alpha: 0.5)
//        tabBarController?.tabBar.clipsToBounds = true
        navigationBar.titleTextAttributes = [
            // 文字の色
            .foregroundColor: UIColor.darkGray
        ]
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //UITabBar.appearance().barTintColor = UIColor(red: 157, green: 204, blue: 224, alpha: 1)
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
