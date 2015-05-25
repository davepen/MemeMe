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
        if currentMemesCount < memes.count
        {
            currentMemesCount = memes.count
            tableView?.reloadData()
            collectionView?.reloadData()
        }
    }
    
    override func viewDidLoad()
    {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem:UIBarButtonSystemItem.Add,
            target:self,
            action:Selector("plusButtonTapped:"))
        currentMemesCount = AppDelegate.getMemes().count
    }
    
    func plusButtonTapped(sender:AnyObject)
    {
        let memeEditorViewController = storyboard?.instantiateViewControllerWithIdentifier(controllerIdentifierMemeEditor) as! MemeEditorViewController
        presentViewController(memeEditorViewController, animated: true, completion: nil)
    }
    
    // MARK: UICollectionViewDataSource
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return memes.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(collectionViewCellReuseId, forIndexPath:indexPath) as! MemeCollectionViewCell
        let meme = memes[indexPath.row]
        cell.imageView?.image = meme.memedImage
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath:NSIndexPath)
    {
        let memeDetailViewController = storyboard!.instantiateViewControllerWithIdentifier(controllerIdentifierMemeDetail) as! MemeDetailViewController
        memeDetailViewController.meme = memes[indexPath.row]
        navigationController!.pushViewController(memeDetailViewController, animated: true)
    }
    
    // MARK: UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return memes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier(tableViewCellReuseId) as! MemeTableViewCell
        let meme = memes[indexPath.row]
        cell.memeCellImageView?.image = meme.memedImage
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let memeDetailViewController = storyboard!.instantiateViewControllerWithIdentifier(controllerIdentifierMemeDetail) as! MemeDetailViewController
        memeDetailViewController.meme = memes[indexPath.row]
        navigationController!.pushViewController(memeDetailViewController, animated: true)
    }
    
}