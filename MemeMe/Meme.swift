import Foundation
import UIKit

class Meme : NSObject, NSCoding
{
    var topText:String?
    var bottomText:String?
    var image:UIImage?
    var memedImage:UIImage?

    override init()
    {
        super.init()
    }
    
    func encodeWithCoder(encoder:NSCoder) -> Void
    {
        if let topText = self.topText
        {
            encoder.encodeObject(topText, forKey:"topText")
        }
        
        if let bottomText = self.bottomText
        {
            encoder.encodeObject(bottomText, forKey:"bottomText")
        }
        
        if let image = self.image
        {
            encoder.encodeObject(image, forKey:"image")
        }
        
        if let memedImage = self.memedImage
        {
            encoder.encodeObject(memedImage, forKey:"memedImage")
        }
    }
    
    required init(coder aDecoder:NSCoder)
    {
        self.topText = aDecoder.decodeObjectForKey("topText") as? String
        self.bottomText = aDecoder.decodeObjectForKey("bottomText") as? String
        self.image = aDecoder.decodeObjectForKey("image") as? UIImage
        self.memedImage = aDecoder.decodeObjectForKey("memedImage") as? UIImage
    }
}
