//
//  DateFormat.swift
//  TourismApp
//
//  Created by Aria Pratomo on 16/02/22.
//

import Foundation

struct DateFormat
{
    static func convertDateFormat(inputDate: String) -> String {
         let olDateFormatter = DateFormatter()
         olDateFormatter.dateFormat = "yyyy-MM-dd"
         let oldDate = olDateFormatter.date(from: inputDate)
         let convertDateFormatter = DateFormatter()
         convertDateFormatter.dateFormat = "dd MMM yyyy"
         return convertDateFormatter.string(from: oldDate!)
    }
}
