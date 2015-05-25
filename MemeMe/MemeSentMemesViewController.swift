import UIKit

/**
*   Handles the sent memes view. This class is a datasource for both the collection view and table view.
*   Initially, I had two separate view controllers: one for the collection view and one for the table view,
*   but the code was nearly identical, so I moved to using just this one view controller.
*/
class MemeSentMemesViewController : UIViewController, UICollectionViewDataSource, UITableViewDataSource
{
    var memes:[Meme]!

    // used to determine when we should refresh the table view and collection view
    var currentMemesCount:Int = 0
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: Overrides

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
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier(CONTROLLER_IDENTIFIER_MEME_EDITOR) as! MemeEditorViewController
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    // MARK: UICollectionViewDataSource
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.memes.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(COLLECTION_VIEW_CELL_REUSE_ID, forIndexPath:indexPath) as! MemeCollectionViewCell
        let meme = self.memes[indexPath.row]
        cell.imageView?.image = meme.memedImage
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath:NSIndexPath)
    {
        let memeDetailViewController = self.storyboard!.instantiateViewControllerWithIdentifier(CONTROLLER_IDENTIFIER_MEME_DETAIL) as! MemeDetailViewController
        memeDetailViewController.meme = self.memes[indexPath.row]
        self.navigationController!.pushViewController(memeDetailViewController, animated: true)
    }
    
    // MARK: UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.memes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier(TABLE_VIEW_CELL_REUSE_ID) as! MemeTableViewCell
        let meme = self.memes[indexPath.row]
        
        // Set the name and image
        cell.memeCellLabel?.text = meme.topText! + meme.bottomText!
        cell.memeCellImageView?.image = meme.memedImage
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let memeDetailViewController = self.storyboard!.instantiateViewControllerWithIdentifier(CONTROLLER_IDENTIFIER_MEME_DETAIL) as! MemeDetailViewController
        memeDetailViewController.meme = self.memes[indexPath.row]
        self.navigationController!.pushViewController(memeDetailViewController, animated: true)
    }
    
}