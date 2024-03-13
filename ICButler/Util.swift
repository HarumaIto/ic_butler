import UIKit
import Foundation

class Util: NSObject {
    /**
     * 使用端末のディスプレイサイズを返す
     * @return displaySize (.width と .height)
     */
    class func returnDisplaySize() -> CGSize {
        let displaySize = UIScreen.main.bounds.size
        
        return displaySize
    }
}
