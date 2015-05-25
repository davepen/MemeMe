import UIKit

@UIApplicationMain
class AppDelegate : UIResponder, UIApplicationDelegate
{
    var memes = [Meme]()
    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool
    {
        // load our memes
        self.loadMemes()

        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        let mainstoryboard = UIStoryboard(name:"Main", bundle:nil);
        
        // app always shows the sent memes view controller
        window?.rootViewController = mainstoryboard.instantiateViewControllerWithIdentifier(controllerIndetifierMemeSent) as? UITabBarController
        window?.makeKeyAndVisible()
        
        if (memes.count == 0)
        {
            // but present the meme editor view when we don't yet have any sent memes
            let memeEditorViewController = mainstoryboard.instantiateViewControllerWithIdentifier(controllerIdentifierMemeEditor) as! MemeEditorViewController
            window?.rootViewController?.presentViewController(memeEditorViewController, animated: true, completion: nil);
        }

        return true
    }

    func applicationWillResignActive(application: UIApplication)
    {
        saveMemes()
    }

    func applicationWillTerminate(application: UIApplication)
    {
        saveMemes()
    }
    
    /**
    Saves the sent memes array to NSUserDefaults
    */
    func loadMemes()
    {
        let memesData = NSUserDefaults.standardUserDefaults().objectForKey(memesArrayKey) as? NSData
        if let memesData = memesData
        {
            let memesArray = NSKeyedUnarchiver.unarchiveObjectWithData(memesData) as? [Meme]
            if let memesArray = memesArray
            {
                memes = memesArray
            }
        }
    }
    
    /**
    Loads the sent meme array from NSUserDefaults
    */
    func saveMemes() -> Void
    {
        let memesData = NSKeyedArchiver.archivedDataWithRootObject(memes)
        NSUserDefaults.standardUserDefaults().setObject(memesData, forKey:memesArrayKey)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
}

extension AppDelegate
{
    /**
    Helper method to access the memes array
    
    :returns: an array of Memes
    */
    static func getMemes() -> [Meme]
    {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        return appDelegate.memes
    }
}