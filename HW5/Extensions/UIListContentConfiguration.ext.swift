import Foundation
import UIKit

extension  UIListContentConfiguration {
    
    mutating func setGetConfigBy(text txt: String, secondaryText sndTxt: String, image img: String) -> UIListContentConfiguration {
            
        text = txt
        textProperties.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
        secondaryText = sndTxt
        
        image = UIImage(named: img)
        imageProperties.maximumSize = CGSize(width: 56, height: 56)
        
        return self
    }
}
