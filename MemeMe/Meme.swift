import UIKit

/**
*   Class that maintains a meme. Stores the top text, bottom text image and
    the memed image. This started as a struct, but when I need to store the memes
    array to NSUserDefaults, I had to change it to a class so I could implement
    NSCoding. This was needed so I could store the memes array object.
*/
class Meme : NSObject, NSCoding
{
    var memedImage:UIImage?

    override init()
    {
        super.init()
    }
    
    func encodeWithCoder(encoder:NSCoder) -> Void
    {
        if let memedImage = memedImage
        {
            encoder.encodeObject(memedImage, forKey:NSCODER_KEY_MEMED_IMAGE)
        }
    }
    
    required init(coder aDecoder:NSCoder)
    {
        memedImage = aDecoder.decodeObjectForKey(NSCODER_KEY_MEMED_IMAGE) as? UIImage
    }
}
