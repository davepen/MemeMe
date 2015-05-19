import UIKit

class MemeDetailViewController : UIViewController
{
    @IBOutlet weak var imageView: UIImageView!
    
    var meme:Meme? = nil
    
    override func viewDidLoad()
    {
        self.imageView.image = meme?.memedImage
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.hidden = true

/*
        self.label.text = self.villain.name
        self.tabBarController?.tabBar.hidden = true
        self.imageView!.image = UIImage(named: villain.imageName)
*/
    }
    
    override func viewWillDisappear(animated: Bool)
    {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.hidden = false
    }
}

