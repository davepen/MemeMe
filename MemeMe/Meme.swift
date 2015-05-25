import UIKit

/**
*   Class that maintains a meme. Stores the top text, bottom text image and
    the memed image. This started as a struct, but when I need to store the memes
    array to NSUserDefaults, I had to change it to a class so I could implement
    NSCoding. This was needed so I could store the memes array object.
*/
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
        if let topText = topText
        {
            encoder.encodeObject(topText, forKey:NSCODER_KEY_TOP_TEXTFIELD)
        }
        
        if let bottomText = bottomText
        {
            encoder.encodeObject(bottomText, forKey:NSCODER_KEY_BOTTOM_TEXTFIELD)
        }
        
        if let image = image
        {
            encoder.encodeObject(image, forKey:NSCODER_KEY_IMAGE)
        }
        
        if let memedImage = memedImage
        {
            encoder.encodeObject(memedImage, forKey:NSCODER_KEY_MEMED_IMAGE)
        }
    }
    
    required init(coder aDecoder:NSCoder)
    {
        topText = aDecoder.decodeObjectForKey(NSCODER_KEY_TOP_TEXTFIELD) as? String
        bottomText = aDecoder.decodeObjectForKey(NSCODER_KEY_BOTTOM_TEXTFIELD) as? String
        image = aDecoder.decodeObjectForKey(NSCODER_KEY_IMAGE) as? UIImage
        memedImage = aDecoder.decodeObjectForKey(NSCODER_KEY_MEMED_IMAGE) as? UIImage
    }
}
