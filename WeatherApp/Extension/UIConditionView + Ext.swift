import Foundation
import UIKit

extension UIImageView {
    
    func loadImageFromURL(urlString: String, placeholder: UIImage? = nil) {
        self.image = nil
        
        let imageCache = NSCache<NSString, UIImage>()
        
        let key = NSString(string: urlString)
        
        if let cachedImage = imageCache.object(forKey: key) {
            self.image = cachedImage
            
            return
        }
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            
            if let data = data, let image = UIImage(data: data) {
                imageCache.setObject(image, forKey: key)
                
                DispatchQueue.main.async {
                    self.image = image
                }
               
            }
        }
        
        task.resume()
            
    }
}
