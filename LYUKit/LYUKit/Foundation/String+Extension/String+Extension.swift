//
//  String+Extension.swift
//  SwiftRouter
//
//  Created by 吕陈强 on 2018/3/27.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import Foundation
import UIKit

extension String{
    // 拼音
    var pinyin:String{
        get{
            let str = NSMutableString(string: self)
            CFStringTransform(str as CFMutableString, nil, kCFStringTransformMandarinLatin, false)
            CFStringTransform(str as CFMutableString, nil, kCFStringTransformStripDiacritics, false)
            
            return str.replacingOccurrences(of: " ", with: "")
            
        }
    }
    /// base64转码
    var base64: String {
        let plainData = (self as NSString).data(using: String.Encoding.utf8.rawValue)
        let base64String = plainData!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        return base64String
    }
    //返回字符串的长度
    var length:NSInteger{
        get{
            return self.count;
        }
    }
    
 
    /// 返回文本的高度
    ///
    /// - Parameters:
    ///   - font: 字体
    ///   - width: 宽度
    /// - Returns: 高度
    func textHeight(font:UIFont,width:CGFloat)->CGFloat{
       let style = NSMutableParagraphStyle()
//        style.lineBreakMode = .byClipping;
//        style.maximumLineHeight = 1;
        
        let height =   self.boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options:  NSStringDrawingOptions(rawValue:
            NSStringDrawingOptions.usesDeviceMetrics.rawValue |
            NSStringDrawingOptions.usesFontLeading.rawValue |
                NSStringDrawingOptions.usesLineFragmentOrigin.rawValue
//            NSStringDrawingOptions.truncatesLastVisibleLine.rawValue
        ), attributes: [NSAttributedString.Key.font:font,NSAttributedString.Key.paragraphStyle:style], context: nil).size.height;
        return ceil(height);
    }
    
    /// 返回文本的宽度
    ///
    /// - Parameters:
    ///   - font: 字体
    ///   - height: 高度
    /// - Returns: 宽度
    func textWidth(font:UIFont,height:CGFloat)->CGFloat{
        
        let width =   self.boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: height), options: NSStringDrawingOptions(rawValue:  NSStringDrawingOptions.usesFontLeading.rawValue |    NSStringDrawingOptions.usesLineFragmentOrigin.rawValue |
            NSStringDrawingOptions.truncatesLastVisibleLine.rawValue)
            , attributes: [NSAttributedString.Key.font:font], context: nil).size.width;
        return ceil(width);
    }
    
    
}



// MARK:app相关路径
extension String{
    static var homePath:String {
        get{
            return NSHomeDirectory();
        }
    }
    
    static var documentPath:String {
        get{
            return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        }
    }
    
    
}

// MARK:数据类型转换 string to ---> {目标类型}
extension String{
    
    var toClass:AnyClass? {
        get{
          
            if  let appName: String = Bundle.main.infoDictionary!["CFBundleName"] as? String{
                return NSClassFromString("\(appName).\(self)")
            }
            return nil;
        }
        
    }
    
    var toSelector:Selector {
        get {
            return Selector(self);
        }
    }
    
    /// parse url eg:id=1&name=k
    /// 获得参数
    var toUrlParams:[String:String]{
        get{
            var params = [String:String]()
            let url = URL(string: self);
            if let url = url, let paramstring = url.query{
                paramstring.split(separator: "&").forEach { (index) in
                    let tmp =  index.split(separator: "=")
                    if(tmp.count > 1){
                        params[String(tmp[0])] = String(tmp[1])
                    }
                }
            }
            return params;
        }
    }
    /// 获得host
    var toUrlHost:String {
        get{
            let url = URL(string: self);
            var host = "";
            if let url = url, let hoststr = url.host{
                host = hoststr;
            }
            return host;
        }
    }
    
    /// parse url eg:/path/qweqwe
    var toUrlPath:[String]{
        get{
           var params = [String]()
            self.split(separator: "/").forEach { (index) in
                params.append(String(index));
            }
            return params;
        }
        
    }
    
    
    var currentClass:AnyClass? {
        get{
            
            if  let appName: String = Bundle.main.infoDictionary!["CFBundleName"] as? String{
                return NSClassFromString("\(appName).\(self)")
            }
            return nil;
        }
    }
    
    
    func convertToClass<T>(_ type:T.Type) -> T.Type?{
        
        if  let appName: String = Bundle.main.infoDictionary!["CFBundleName"] as? String{
            
            if let appClass = NSClassFromString("\(appName).\(self)") {
                return appClass as? T.Type;
            }
            return nil;
            
        }
        return nil;
        
    }
    
    
}



// MARK:搜索子 str所有所在位置的集合
extension String {
    
        func indexesOf(pattern: String) -> [Int]? {
            let patternLength: Int = pattern.length
            /* Let's calculate the Z-Algorithm on the concatenation of pattern and text */
            let zeta = ZetaAlgorithm(ptrn: pattern + "💲" + self)
            
            guard zeta != nil else {
                return nil
            }
            
            var indexes: [Int] = [Int]()
            
            /* Scan the zeta array to find matched patterns */
            for i in 0 ..< zeta!.count {
                if zeta![i] == patternLength {
                    indexes.append(i - patternLength - 1)
                }
            }
            
            guard !indexes.isEmpty else {
                return nil
            }
            
            return indexes
        }
}



func ZetaAlgorithm(ptrn: String) -> [Int]? {
    
    let pattern = Array(ptrn.characters)
    let patternLength: Int = pattern.count
    
    guard patternLength > 0 else {
        return nil
    }
    
    var zeta: [Int] = [Int](repeating: 0, count: patternLength)
    
    var left: Int = 0
    var right: Int = 0
    var k_1: Int = 0
    var betaLength: Int = 0
    var textIndex: Int = 0
    var patternIndex: Int = 0
    
    for k in 1 ..< patternLength {
        if k > right {  // Outside a Z-box: compare the characters until mismatch
            patternIndex = 0
            
            while k + patternIndex < patternLength  &&
                pattern[k + patternIndex] == pattern[patternIndex] {
                    patternIndex = patternIndex + 1
            }
            
            zeta[k] = patternIndex
            
            if zeta[k] > 0 {
                left = k
                right = k + zeta[k] - 1
            }
        } else {  // Inside a Z-box
            k_1 = k - left + 1
            betaLength = right - k + 1
            
            if zeta[k_1 - 1] < betaLength { // Entirely inside a Z-box: we can use the values computed before
                zeta[k] = zeta[k_1 - 1]
            } else if zeta[k_1 - 1] >= betaLength { // Not entirely inside a Z-box: we must proceed with comparisons too
                textIndex = betaLength
                patternIndex = right + 1
                
                while patternIndex < patternLength && pattern[textIndex] == pattern[patternIndex] {
                    textIndex = textIndex + 1
                    patternIndex = patternIndex + 1
                }
                
                zeta[k] = patternIndex - k
                left = k
                right = patternIndex - 1
            }
        }
    }
    return zeta
}
