
import UIKit

extension UIFont {
    static func appleBold(with size: CGFloat) -> UIFont {
        UIFont(name: "Apple SD Gothic Neo Bold", size: size) ?? .systemFont(ofSize: 13)
    }

    static func appleRegular(with size: CGFloat) -> UIFont {
        UIFont(name: "Apple SD Gothic Neo Regular", size: size) ?? .systemFont(ofSize: 13)
    }
}
