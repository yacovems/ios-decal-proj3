//
//  ImageViewController.swift
//  Photos
//
//  Created by Yacov Shemesh on 11/17/15.
//  Copyright © 2015 iOS DeCal. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

    var liked : Bool = false
    var photo : Photo!
    var image : UIImage!
    
    @IBOutlet weak var like_btn: UIButton!
    @IBOutlet weak var chosenImage: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var num_of_likes: UILabel!
    @IBOutlet weak var date_posted: UILabel!
    @IBAction func like_it(sender: AnyObject) {
        if liked{
            sender.setImage(UIImage(named: "before.png"), forState: UIControlState.Normal)
            self.photo.likes = self.photo.likes - 1
            num_of_likes.text = String(self.photo.likes) + " likes"
            liked = false
            self.photo.heart = false
        }
        else{
            sender.setImage(UIImage(named: "download.png"), forState: UIControlState.Normal)
            self.photo.likes = self.photo.likes + 1
            num_of_likes.text = String(self.photo.likes) + " likes"
            liked = true
            self.photo.heart = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadData() {
        chosenImage.image = image
        if self.photo.heart == true {
            liked = true
            like_btn.setImage(UIImage(named: "download.png"), forState: UIControlState.Normal)
        }
        else{
            liked = false
            like_btn.setImage(UIImage(named: "before.png"), forState: UIControlState.Normal)
        }
        username.text = self.photo.username
        num_of_likes.text = String(self.photo.likes) + " likes"
        let time_result = Double(self.photo.date)
        let date = NSDate(timeIntervalSince1970: time_result!)
        date_posted.text = String(date)
    }
}
