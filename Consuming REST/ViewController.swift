//
//  ViewController.swift
//  Consuming REST
//
//  Created by Yasin Shamrat on 1/7/20.
//  Copyright © 2020 Yasin Shamrat. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher
import SwiftyJSON

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var items  = JSON()
    
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("View Loaded")
        Alamofire.request("https://picsum.photos/v2/list").responseJSON{ response in
            
            if response.result.isSuccess{
                if let jsonData = response.result.value {
                    self.items = JSON(jsonData)
                    print("Data Fetched Successfully.")
                    
                    self.collectionView.reloadData()
                }else{
                    print("Connection Failed.")
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! CustomCollectionViewCell
        let processor = DownsamplingImageProcessor(size: cell.imageView.frame.size)
        >> RoundCornerImageProcessor(cornerRadius: 20)
        cell.AuthorLabel.text = "by \(items[indexPath.row]["author"].stringValue)"
        cell.imageView.kf.setImage(with : items[indexPath.row]["download_url"].url,options: [.processor(processor),
        .scaleFactor(UIScreen.main.scale)])
        return cell
    }
}

