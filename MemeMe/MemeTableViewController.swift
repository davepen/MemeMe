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
        let cell = tableView.dequeueReusableCellWithIdentifier("MemeTableViewCell") as! UITableViewCell
        let meme = self.memes[indexPath.row]
        
        // Set the name and image
        cell.textLabel?.text = meme.topText! + meme.bottomText!
        cell.imageView?.image = meme.memedImage
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
//        detailController.villain = self.allVillains[indexPath.row]
        self.navigationController!.pushViewController(detailController, animated: true)
        
    }
    
}
