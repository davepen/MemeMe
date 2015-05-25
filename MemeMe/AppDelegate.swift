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

        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        let mainstoryboard = UIStoryboard(name:"Main", bundle:nil);
        
        // app always shows the sent memes view controller
        self.window?.rootViewController = mainstoryboard.instantiateViewControllerWithIdentifier(CONTROLLER_IDENTIFIER_MEME_SENT) as? UITabBarController
        self.window?.makeKeyAndVisible()
        
        if (self.memes.count == 0)
        {
            // but present the meme editor view when we don't yet have any sent memes
            let vc = mainstoryboard.instantiateViewControllerWithIdentifier(CONTROLLER_IDENTIFIER_MEME_EDITOR) as! MemeEditorViewController
            self.window?.rootViewController?.presentViewController(vc, animated: true, completion: nil);
        }

        return true
    }

    func applicationWillResignActive(application: UIApplication)
    {
        self.saveMemes()
    }

    func applicationWillTerminate(application: UIApplication)
    {
        self.saveMemes()
    }
    
    /**
    Saves the sent memes array to NSUserDefaults
    */
    func loadMemes()
    {
        let memesData = NSUserDefaults.standardUserDefaults().objectForKey(MEMES_ARRAY_KEY) as? NSData
        if let memesData = memesData
        {
            let memesArray = NSKeyedUnarchiver.unarchiveObjectWithData(memesData) as? [Meme]
            if let memesArray = memesArray
            {
                self.memes = memesArray
            }
        }
    }
    
    /**
    Loads the sent meme array from NSUserDefaults
    */
    func saveMemes() -> Void
    {
        let memesData = NSKeyedArchiver.archivedDataWithRootObject(memes)
        NSUserDefaults.standardUserDefaults().setObject(memesData, forKey:MEMES_ARRAY_KEY)
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