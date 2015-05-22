import UIKit

class MemeTableViewController: UIViewController, UITableViewDataSource
{
    var memes:[Meme]!
    var currentMemesCount:Int = 0

    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(animated:Bool)
    {
        super.viewWillAppear(animated)
        memes = AppDelegate.getMemes()
        if self.currentMemesCount < memes.count
        {
            self.currentMemesCount = memes.count
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad()
    {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem:UIBarButtonSystemItem.Add,
                                                                              target:self,
                                                                              action:Selector("plusButtonTapped:"))
        self.currentMemesCount = AppDelegate.getMemes().count
        self.tableView.separatorInset = UIEdgeInsetsZero
    }
    
    func plusButtonTapped(sender:AnyObject)
    {
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! MemeEditorViewController
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.memes.count;
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
