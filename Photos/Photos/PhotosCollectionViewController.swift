//
//  PhotosCollectionViewController.swift
//  Photos
//
//  Created by Gene Yoo on 11/3/15.
//  Copyright © 2015 iOS DeCal. All rights reserved.
//

import UIKit

class PhotosCollectionViewController: UICollectionViewController {
    
    var photos: [Photo]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let api = InstagramAPI()
        api.loadPhotos(didLoadPhotos)
    }

    /* 
     * IMPLEMENT ANY COLLECTION VIEW DELEGATE METHODS YOU FIND NECESSARY
     * Examples include cellForItemAtIndexPath, numberOfSections, etc.
     */
    
    /* Creates a session from a photo's url to download data to instantiate a UIImage. 
       It then sets this as the imageView's image. */
    func loadImageForCell(photo: Photo, imageView: UIImageView) {
        
    }
    
    /* Completion handler for API call. DO NOT CHANGE */
    func didLoadPhotos(photos: [Photo]) {
        self.photos = photos
        self.collectionView!.reloadData()
    }
   
    override func collectionView(collectionView: UICollectionView,
        cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ImageCellView", forIndexPath: indexPath) as! ImageCellView
            let photo = photos[indexPath.row]
            let imgURL: NSURL = NSURL(string: photo.url)!
            
            let request: NSURLRequest = NSURLRequest(URL: imgURL)
            NSURLConnection.sendAsynchronousRequest(
                request, queue: NSOperationQueue.mainQueue(),
                completionHandler: {(response: NSURLResponse?,data: NSData?,error: NSError?) -> Void in
                    if error == nil {
                        cell.imageView.image = UIImage(data: data!)
                    }
            })
            return cell
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if photos == nil {
            return 0
        }
        return photos.count
    }
    
    func collectionView(collection: UICollectionView, selectedItemIndex: NSIndexPath) {
        self.performSegueWithIdentifier("segueImage", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        if let indexPath = self.collectionView?.indexPathForCell(sender as! UICollectionViewCell) {
            let vc = segue.destinationViewController as! ImageViewController
            vc.photo = self.photos[indexPath.row]
            vc.image = sender.imageView!.image
            
        }
    }
}

class ImageCellView: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
}
