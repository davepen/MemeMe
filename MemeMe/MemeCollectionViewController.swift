import Foundation

import UIKit

class MemeCollectionViewController: UIViewController, UICollectionViewDataSource
{
    var memes:[Meme]!
    var currentMemesCount:Int = 0
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewWillAppear(animated:Bool)
    {
        super.viewWillAppear(animated)
        memes = AppDelegate.getMemes()
        if self.currentMemesCount < memes.count
        {
            self.currentMemesCount = memes.count
            self.collectionView.reloadData()
        }
    }
    
    override func viewDidLoad()
    {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem:UIBarButtonSystemItem.Add,
            target:self,
            action:Selector("plusButtonTapped:"))
        self.currentMemesCount = AppDelegate.getMemes().count
    }
    
    func plusButtonTapped(sender:AnyObject)
    {
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! MemeEditorViewController
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.memes.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MemeCollectionViewCell", forIndexPath:indexPath) as! MemeCollectionViewCell
        let meme = self.memes[indexPath.row]
        cell.imageView?.image = meme.memedImage
        // Set the name and image
        //cell.nameLabel.text = villain.name
        //cell.villainImageView?.image = UIImage(named: villain.imageName)
        //cell.schemeLabel.text = "Scheme: \(villain.evilScheme)"
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath:NSIndexPath)
    {
        let memeDetailViewController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        memeDetailViewController.meme = self.memes[indexPath.row]
        self.navigationController!.pushViewController(memeDetailViewController, animated: true)
    }
    
}

