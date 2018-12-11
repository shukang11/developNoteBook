//
//  SSDate.swift
//  SSKitSwiftCDemo
//
//  Created by Mac on 17/1/20.
//  Copyright © 2017年 YD. All rights reserved.
//

import Foundation
public extension Date {
    public var  year: Int {
        return Calendar.current.component(Calendar.Component.year, from: self)
    }
    
    public var  month: Int {
        return Calendar.current.component(Calendar.Component.month, from: self)
    }
    
    public var  day: Int {
        return Calendar.current.component(Calendar.Component.day, from: self)
    }
    
    public var  hour: Int {
        return Calendar.current.component(Calendar.Component.hour, from: self)
    }
    
    public var  minute: Int {
        return Calendar.current.component(Calendar.Component.minute, from: self)
    }
    
    public var  second: Int {
        return Calendar.current.component(Calendar.Component.second, from: self)
    }
    
    public var  nanosecond: Int {
        return Calendar.current.component(Calendar.Component.nanosecond, from: self)
    }
    
    public var  weekday: Int {
        return Calendar.current.component(Calendar.Component.weekday, from: self)
    }
    
    public var  weekdayOrdinal: Int {
        return Calendar.current.component(Calendar.Component.weekdayOrdinal, from: self)
    }
    
    public var  weekOfMonth: Int {
        return Calendar.current.component(Calendar.Component.weekOfMonth, from: self)
    }
    
    public var  weekOfYear: Int {
        return Calendar.current.component(Calendar.Component.weekOfYear, from: self)
    }
    
    public var  yearForWeekOfYear: Int {
        return Calendar.current.component(Calendar.Component.yearForWeekOfYear, from: self)
    }
    
    public var  quarter: Int {
        return Calendar.current.component(Calendar.Component.quarter, from: self)
    }
    
    public var  era: Int {
        return Calendar.current.component(Calendar.Component.era, from: self)
    }
    
    public var  isLeapYear: Bool {
        let year: Int = self.year
        return (((year % 400) == 0) || (((year % 100) != 0) && (year % 4 == 0)))
    }
    
    public var  isToday: Bool {
        if (fabs(self.timeIntervalSinceNow) >= 60 * 60 * 24) { return false}
        return Date.init().day == self.day
    }
    
    public var  isYeaterday: Bool {
        let date: Date = self.addDays(1)
        return date.isToday
    }
    
    public var  isLaterThanNow: Bool {
        let timeInterval:TimeInterval = self.timeIntervalSinceReferenceDate - Date.init().timeIntervalSinceReferenceDate
        if (timeInterval >= 0) { return true}
        return false
    }
    
    public func  addYears(_ years: Int) -> Date {
        let calendar:Calendar = Calendar.current
        var  components:DateComponents = DateComponents.init()
        components.setValue(year, for: Calendar.Component.year)
        return calendar.date(byAdding: components, to: self)!
    }
    
    public func  addMonths(_ months: Int) -> Date {
        let calendar:Calendar = Calendar.current
        var  components:DateComponents = DateComponents.init()
        components.setValue(months, for: Calendar.Component.month)
        return calendar.date(byAdding: components, to: self)!
    }
    
    public func  addWeeks(_ weeks: Int) -> Date {
        let calendar:Calendar = Calendar.current
        var  components:DateComponents = DateComponents.init()
        components.setValue(weeks, for: Calendar.Component.weekOfYear)
        return calendar.date(byAdding: components, to: self)!
    }
    
    public func  addDays(_ days: Int) -> Date {
        let aTimeInterval: TimeInterval = self.timeIntervalSinceReferenceDate
        let newDate: Date = Date.init(timeIntervalSinceReferenceDate: aTimeInterval+Double(86400*days))
        return newDate
    }
    
    public func  addHours(_ hours: Int) -> Date {
        let aTimeInterval: TimeInterval = self.timeIntervalSinceReferenceDate
        let newDate: Date = Date.init(timeIntervalSinceReferenceDate: aTimeInterval+Double(3600*hours))
        return newDate
    }
    
    public func  addMinutes(_ minutes: Int) -> Date {
        let aTimeInterval: TimeInterval = self.timeIntervalSinceReferenceDate
        let newDate: Date = Date.init(timeIntervalSinceReferenceDate: aTimeInterval+Double(60*minutes))
        return newDate
    }
    
    public func  addSecond(_ seconds: Int) -> Date {
        let aTimeInterval: TimeInterval = self.timeIntervalSinceReferenceDate
        let newDate: Date = Date.init(timeIntervalSinceReferenceDate: aTimeInterval+Double(seconds))
        return newDate
    }

    
    public func  toString(_ format: String) -> String {
        let formatter: DateFormatter = DateFormatter.init()
        formatter.dateFormat = format
        formatter.locale = Locale.current
        return formatter.string(from: self)
    }
    
    public func  toString(_ format: String, timeZone: TimeZone, locale: Locale? = Locale.current) -> String {
        let formatter: DateFormatter = DateFormatter.init()
        formatter.dateFormat = format
        formatter.timeZone = timeZone
        formatter.locale = locale
        return formatter.string(from: self)
    }

    
    public func  toIOSFormatString() -> String {
        let formatter: DateFormatter = DateFormatter.init()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        formatter.locale = Locale.init(identifier: "en_US_POSIX")
        return formatter.string(from: self)
    }
    
    
    static public func  dateBy(_ dateString: String, _ format: String) -> Date {
        let formatter: DateFormatter = DateFormatter.init()
        formatter.dateFormat = format
        return formatter.date(from: dateString)!
    }
    
    static public func  dateBy(_ dateString: String, _ format: String, _ timeZone: TimeZone, _ locale: Locale) -> Date {
        let formatter: DateFormatter = DateFormatter.init()
        formatter.dateFormat = format
        formatter.locale = locale
        formatter.timeZone = timeZone
        return formatter.date(from: dateString)!
    }
    
    static public func  dateIOSFormatBy(_ dateString: String) -> Date {
        let formatter: DateFormatter = DateFormatter.init()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        formatter.locale = Locale.init(identifier: "en_US_POSIX")
        return formatter.date(from: dateString)!
    }
    
    static public func  subtractTwoTimes(_ firstDateString: String, _ firstFormat: String, _ secondDateString: String,_ secondFormat: String) -> TimeInterval {
        let firstDateFormatter: DateFormatter = DateFormatter.init()
        firstDateFormatter.dateFormat = firstFormat
        guard let firstDate: Date = firstDateFormatter.date(from: firstDateString) else {
            return 0
        }
        
        
        let secondDateFormatter: DateFormatter = DateFormatter.init()
        secondDateFormatter.dateFormat = secondFormat
        guard let secondDate: Date = secondDateFormatter.date(from: secondDateString) else {
            return 0
        }
        
        
        return firstDate.timeIntervalSinceReferenceDate - secondDate.timeIntervalSinceReferenceDate
    }
}
