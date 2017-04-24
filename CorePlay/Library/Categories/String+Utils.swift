import Foundation
import UIKit

public extension String{
    
    public func stringByTrimingWhiteSpaces() -> String{
        return self.trimmingCharacters(in: .whitespaces)
    }
    
    func lowerCaseFirstCharacter () -> String {
        
        for chr in self.characters {
            
            let istChar = String (chr)
            return istChar.lowercased() + self.substring(from: self.startIndex)
        }
        return ""
    }
    
//    public func alphabeticString()-> String{
//        var tempString = ""
//        
//        for ch in self.unicodeScalars{
//            if (ch.value > 96 && ch.value < 123) || (ch.value > 64 && ch.value < 91){
//                tempString.append(ch)
//            }
//        }
//        return tempString
//    }
    
//    public func matchWithRegularExpression(regx: String) -> Bool{
//
//        if let _ = self.rangeOfString(regx, options: NSStringCompareOptions.RegularExpressionSearch){
//            return true
//        }
//        else{
//            return false
//        }
//        
//    }
    
    public func htmlEncodedString() -> String{
        if let str = self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed){
            return str
        }
        else{
            return self
        }
    }
    
   
        func toBool() -> Bool?
        {
            switch self
            {
            case "True", "true", "yes", "1":
                return true
            case "False", "false", "no", "0":
                return false
            default:
                return nil
            }
        }
    
    func toDateFormatted(with dateFormat:String)-> NSDate? {
        let formator = DateFormatter()
        formator.dateFormat = dateFormat
        return formator.date(from: self) as NSDate?
    }


    func htmlAttributedString() -> NSMutableAttributedString? {
        guard let data = self.data(using: String.Encoding.utf16, allowLossyConversion: false) else { return nil }
        guard let html = try? NSMutableAttributedString(
            data: data,
            options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
            documentAttributes: nil) else { return nil }
        return html
    }
}
extension NSAttributedString {
    func heightWithConstrainedWidth(width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat(99999))
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
        return boundingBox.height
    }
    
    func widthWithConstrainedHeight(height: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: CGFloat(99999), height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
        
        return boundingBox.width
    }
}
//public extension UIImage {
//    func imageWithColor(color1: UIColor) -> UIImage {
//        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
//        color1.setFill()
//        
//        let context = UIGraphicsGetCurrentContext() //as CGContextRef
//        CGContextTranslateCTM(context!, 0, self.size.height)
//        CGContextScaleCTM(context!, 1.0, -1.0);
//        CGContextSetBlendMode(context!, CGBlendMode.Normal)
//        
//        let rect = CGRectMake(0, 0, self.size.width, self.size.height) as CGRect
//        CGContextClipToMask(context!, rect, self.CGImage!)
//        CGContextFillRect(context!, rect)
//        
//        let newImage = UIGraphicsGetImageFromCurrentImageContext()! as UIImage
//        UIGraphicsEndImageContext()
//        
//        return newImage
//    }
//}
//extension String {
//    
//    subscript (i: Int) -> Character {
//        
//        return self[self.startIndex.advancedBy(i)]
//    }
//    
//    subscript (i: Int) -> String {
//        return String(self[i] as Character)
//    }
//    
//    subscript (r: Range<Int>) -> String {
//        let start = startIndex.advancedBy(r.startIndex)
//        let end = start.advancedBy(r.endIndex - r.startIndex)
//        return self[Range(start ..< end)]
//    }
//}
//extension Dictionary where Value: Comparable {
//    var valueKeySorted: [(Key, Value)] {
//        return sort{ $0.1 > $1.1 }.sort{ String($0.0) < String($1.0) }
//    }
//    // or sorting as suggested by Just Another Coder without using map
//    var valueKeySorted2: [(Key, Value)] {
//        return sort{ if $0.1 != $1.1 { return $0.1 > $1.1 } else { return String($0.0) < String($1.0) } }
//    }
//    
//    
//}
extension String {
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat(99999))
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        
        return boundingBox.height
    }
}
//extension UILabel{
//    
//    func requiredHeight() -> CGFloat{
//        
//        let label:UILabel = UILabel(frame: CGRectMake(0, 0, self.frame.width, CGFloat.max))
//        label.numberOfLines = 0
//        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
//        label.font = self.font
//        label.text = self.text
//        
//        label.sizeToFit()
//        
//        return label.frame.height
//    }
//}
//extension NSDate {
//    func isGreaterThanDate(dateToCompare: NSDate) -> Bool {
//        var isGreater = false
//        if self.compare(dateToCompare) == NSComparisonResult.OrderedDescending {
//            isGreater = true
//        }
//        
//        return isGreater
//    }
//    
//    func isLessThanDate(dateToCompare: NSDate) -> Bool {
//        var isLess = false
//        if self.compare(dateToCompare) == NSComparisonResult.OrderedAscending {
//            isLess = true
//        }
//        return isLess
//    }
//    
//    func equalToDate(dateToCompare: NSDate) -> Bool {
//        var isEqualTo = false
//        if self.compare(dateToCompare) == NSComparisonResult.OrderedSame {
//            isEqualTo = true
//        }
//        return isEqualTo
//    }
//    
//    func addDays(daysToAdd: Int) -> NSDate {
//        let secondsInDays: NSTimeInterval = Double(daysToAdd) * 60 * 60 * 24
//        let dateWithDaysAdded: NSDate = self.dateByAddingTimeInterval(secondsInDays)
//        return dateWithDaysAdded
//    }
//    
//    func addHours(hoursToAdd: Int) -> NSDate {
//        let secondsInHours: NSTimeInterval = Double(hoursToAdd) * 60 * 60
//        let dateWithHoursAdded: NSDate = self.dateByAddingTimeInterval(secondsInHours)
//        return dateWithHoursAdded
//    }
//}
extension Int {
    var f: CGFloat { return CGFloat(self) }
}

extension Float {
    var f: CGFloat { return CGFloat(self) }
}

extension Double {
    var f: CGFloat { return CGFloat(self) }
}

extension CGFloat {
    var swf: Float { return Float(self) }
}
