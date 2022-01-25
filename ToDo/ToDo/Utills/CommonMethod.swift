//
//  CommonMethod.swift
//  ToDo
//
//  Created by ELAVARASAN K on 24/01/22.
//

import Foundation

public class CommonMethod
{
    class func CustomDateStrFormatter(_ dateStr: String, requestDateFormat: String, responseDateFormat: String = Constants.displayrDateFormat) -> (dateStr : String, date: Date)
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = requestDateFormat
        let dateTime = dateFormatter.date(from: dateStr)
        
        if dateTime != nil
        {
            dateFormatter.dateFormat = responseDateFormat
            let formatedDateStr = dateFormatter.string(from: dateTime!)
            let formatedDate = dateFormatter.date(from: formatedDateStr)
            return (formatedDateStr,formatedDate ?? Date())
        }
        return ("",Date())
    }
    
    class func CustomDateFormatter(_ date: Date, responseDateFormat: String = Constants.displayrDateFormat) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = responseDateFormat
        let formatedDateStr = dateFormatter.string(from: date)
        return formatedDateStr
    }
    
    class func GetCurrentDate(dateFormat: String) -> (dateStr : String, date: Date)
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        let formatedDateStr = dateFormatter.string(from: Date())
        let formatedDate = dateFormatter.date(from: formatedDateStr)
        return (formatedDateStr, formatedDate ?? Date())
    }
    
    class func GetToDoTaskFilterType(_ eventDate: Date) -> ToDoFilter?
    {
        if Calendar.current.isDateInToday(eventDate)
        {
            return .Today
        }
        else if Calendar.current.isDateInTomorrow(eventDate)
        {
            return .Tomorrow
        }
        else if eventDate > Date()
        {
            return .Upcoming
        }
        
        return nil
    }
}
