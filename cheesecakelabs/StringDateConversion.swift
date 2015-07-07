//
//  StringDateConversion.swift
//  cheesecakelabs
//
//  Created by Israel Tavares on 7/7/15.
//  Copyright © 2015 Coruja Virtual. All rights reserved.
//

import UIKit

/**
Helper class that converts date String format to NSDate and vice-versa
*/
class StringDateConversion {

    internal static func getNSDate(dateString: NSString) -> NSDate?
    {
        let dateFormatter: NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        dateFormatter.timeZone = NSTimeZone(abbreviation: "UTC")
        return dateFormatter.dateFromString(dateString as String)
    }
    
    internal static func getBRString(date: NSDate) -> NSString?
    {
        let dateFormatter: NSDateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .MediumStyle
        dateFormatter.timeStyle = .NoStyle
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dateFormatter.locale = NSLocale(localeIdentifier: "pt_BR")
        dateFormatter.timeZone = NSTimeZone(abbreviation: "UTC")
        return dateFormatter.stringFromDate(date)
    }
    
}