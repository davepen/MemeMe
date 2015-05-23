import Foundation
import UIKit

class MemeSentMemesViewController: UIViewController, UICollectionViewDataSource, UITableViewDataSource
{
    var memes:[Meme]!
    var currentMemesCount:Int = 0
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewWillAppear(animated:Bool)
    {
        super.viewWillAppear(animated)
        memes = AppDelegate.getMemes()
        if self.currentMemesCount < memes.count
        {
            self.currentMemesCount = memes.count
            self.tableView?.reloadData()
            self.collectionView?.reloadData()
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
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath:NSIndexPath)
    {
        let memeDetailViewController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        memeDetailViewController.meme = self.memes[indexPath.row]
        self.navigationController!.pushViewController(memeDetailViewController, animated: true)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.memes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("MemeTableViewCell") as! MemeTableViewCell
        let meme = self.memes[indexPath.row]
        
        // Set the name and image
        cell.memeCellLabel?.text = meme.topText! + meme.bottomText!
        cell.memeCellImageView?.image = meme.memedImage
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let memeDetailViewController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        memeDetailViewController.meme = self.memes[indexPath.row]
        self.navigationController!.pushViewController(memeDetailViewController, animated: true)
    }
    
}