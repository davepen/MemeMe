import UIKit

/**
*  Handles the meme editor
*/
class MemeEditorViewController : UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate
{
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var navigationBar: UINavigationBar!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // disable any buttons that may need to be
        shareButton.enabled = false
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        
        // setup the text for the two text fields we'll use
        let memeTextAttributes = [
            NSStrokeColorAttributeName : UIColor.blackColor(),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName : -3.0
        ]
        
        topTextField.enabled = false;
        topTextField.defaultTextAttributes = memeTextAttributes
        topTextField.textAlignment = NSTextAlignment.Center
        topTextField.delegate = self
        bottomTextField.enabled = false
        bottomTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.textAlignment = NSTextAlignment.Center
        bottomTextField.delegate = self
    }
    
    // MARK: Overrides

    override func prefersStatusBarHidden() -> Bool
    {
        return true;
    }

    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool)
    {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    // MARK: IBAction

    @IBAction func pickAnImageFromAlbum(sender: AnyObject)
    {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        imagePicker.delegate = self
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func pickAnImageFromCamera(sender: AnyObject)
    {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        imagePicker.delegate = self
        presentViewController(imagePicker, animated: true, completion: nil)
    }

    @IBAction func cancelButtonTapped(sender: UIBarButtonItem)
    {
        dismissViewControllerAnimated(true, completion: nil);
    }
    
    @IBAction func shareButtonTapped(sender: UIBarButtonItem)
    {
        let meme = (UIApplication.sharedApplication().delegate as! AppDelegate).memes.last! as Meme
        let activity = UIActivityViewController(activityItems: [meme.memedImage!], applicationActivities: nil)
        activity.completionWithItemsHandler = {
            (activity, success, items, error) in
            // left this println here to see what was being returned each time
            println("Activity: \(activity) Success: \(success) Items: \(items) Error: \(error)")
            
            if (success)
            {
                self.save()
                self.dismissViewControllerAnimated(true, completion: nil);
            }
        }
        presentViewController(activity, animated: true, completion: nil)
    }
    
    // MARK: Keyboard Notifications

    func subscribeToKeyboardNotifications()
    {
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: Selector("keyboardWillShow:"),
            name: UIKeyboardWillShowNotification,
            object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: Selector("keyboardWillHide:"),
            name: UIKeyboardWillHideNotification,
            object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications()
    {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func keyboardWillHide(notification:NSNotification)
    {
        if bottomTextField.isFirstResponder()
        {
            view.frame.origin.y += getKeyboardHeight(notification)
        }
    }
    
    func keyboardWillShow(notification: NSNotification)
    {
        if bottomTextField.isFirstResponder()
        {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat
    {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.CGRectValue().height
    }
    
    // MARK: UIImagePickerControllerDelegate
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject])
    {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            imageView.image = image
            shareButton.enabled = true
            topTextField.enabled = true
            bottomTextField.enabled = true
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController)
    {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: Supporting Methods
    
    /**
    Saves the meme to a meme object and store it in our global array
    */
    func save()
    {
        let memedImage = generateMemedImage()
        let meme = Meme()
        meme.memedImage = memedImage

        // Add it to the memes array in the Application Delegate
        (UIApplication.sharedApplication().delegate as! AppDelegate).memes.append(meme)
    }
    
    /**
    Generates a UIImage using the view hierarchy. First hides the toolbar and navigation bar
    and then unhides them.
    
    :returns: UIImage of the view hierarcchy.
    */
    func generateMemedImage() -> UIImage
    {
        // hide the toolbar and navigation bar
        toolbar.hidden = true
        navigationBar.hidden = true
        
        // render view to an image
        UIGraphicsBeginImageContext(view.frame.size)
        view.drawViewHierarchyInRect(view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        // unhide the tooolbar and navigation bar
        toolbar.hidden = false
        navigationBar.hidden = false

        return memedImage
    }
    
    /**
    Hitting return on the keyboard will dismiss it
    */
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true;
    }
}