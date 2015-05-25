import UIKit

class MemeDetailViewController : UIViewController
{
    @IBOutlet weak var imageView: UIImageView!
    
    var meme:Meme? = nil
    
    override func viewDidLoad()
    {
        imageView.image = meme?.memedImage
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.hidden = true
    }
    
    override func viewWillDisappear(animated: Bool)
    {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.hidden = false
    }
}

