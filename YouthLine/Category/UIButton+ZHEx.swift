import Foundation
import UIKit

extension UIButton {
    func blueTheme() {
        setTitleColor(RGBColor(0, 125, 255), for: UIControlState.normal)
//        titleLabel?.textAlignment = NSTextAlignment.center
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    }
}
