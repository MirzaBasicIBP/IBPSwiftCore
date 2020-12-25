
import UIKit
extension UIColor {
      /// Alows you to convert a 6 digit hexadecimal string to UIColor instance
      /// - Parameters:
      ///   - hexString: 6 digit hexadecimal string
      ///   - alpha: A number betwen 0.0 to 1 indicate how the transparent color is
      /// - Returns: UIColor defined by hexString and alpha parameters
      public class func fromHex(_ hexString: String, alpha: CGFloat = 1) -> UIColor {
          let r, g, b: CGFloat
          let offset = hexString.hasPrefix("#") ? 1 : 0
          let start = hexString.index(hexString.startIndex, offsetBy: offset)
          let hexColor = String(hexString[start...])
          let scanner = Scanner(string: hexColor)
          var hexNumber: UInt64 = 0
          if scanner.scanHexInt64(&hexNumber) {
              r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
              g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
              b = CGFloat(hexNumber & 0x0000ff) / 255
              return UIColor(red: r, green: g, blue: b, alpha: alpha)
          }
          return UIColor(red: 0, green: 0, blue: 0, alpha: alpha)
      }
      
      /// IBP color
      public static var ibpColor : UIColor {
          return  self.fromHex("006736")
      }
      
      public static var secondIbpColor: UIColor {
          return self.fromHex("FCFFFD")
      }
}
