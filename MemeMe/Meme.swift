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
            encoder.encodeObject(topText, forKey:NSCODER_KEY_TOP_TEXTFIELD)
        }
        
        if let bottomText = self.bottomText
        {
            encoder.encodeObject(bottomText, forKey:NSCODER_KEY_BOTTOM_TEXTFIELD)
        }
        
        if let image = self.image
        {
            encoder.encodeObject(image, forKey:NSCODER_KEY_IMAGE)
        }
        
        if let memedImage = self.memedImage
        {
            encoder.encodeObject(memedImage, forKey:NSCODER_KEY_MEMED_IMAGE)
        }
    }
    
    required init(coder aDecoder:NSCoder)
    {
        self.topText = aDecoder.decodeObjectForKey(NSCODER_KEY_TOP_TEXTFIELD) as? String
        self.bottomText = aDecoder.decodeObjectForKey(NSCODER_KEY_BOTTOM_TEXTFIELD) as? String
        self.image = aDecoder.decodeObjectForKey(NSCODER_KEY_IMAGE) as? UIImage
        self.memedImage = aDecoder.decodeObjectForKey(NSCODER_KEY_MEMED_IMAGE) as? UIImage
    }
}
