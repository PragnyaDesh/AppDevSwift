//
//  Holiday.swift
//  HolidayCalendar
//
//  Created by Pragnya Deshpande on 11/03/20.
//  Copyright © 2020 PragnyaDesh. All rights reserved.
//

import Foundation


struct HolidayResponse:Decodable {
    var response:Holidays
}

struct Holidays:Decodable {
    var holidays:[HolidayDetail]
}

struct HolidayDetail:Decodable {
    var name: String
    var date: DateInfo
}

struct DateInfo:Decodable {
    var iso: String
}
