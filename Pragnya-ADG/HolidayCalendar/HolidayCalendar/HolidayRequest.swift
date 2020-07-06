//
//  HolidayRequest.swift
//  HolidayCalendar
//
//  Created by Pragnya Deshpande on 11/03/20.
//  Copyright © 2020 PragnyaDesh. All rights reserved.
//

import Foundation

enum HolidayError:Error{
    case noDataAvailabe
    case cannotProcessData
}

struct HolidayRequest {
    let resourceURL: URL
    let API_KEY = "997a1869046c303d3b67d30a53186edbc559d1b5"
    
    init(countryCode: String) {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy"
        let currentYear = format.string(from: date)
        
    let resourceString = "https://calendarifi.com/api/v2/holidays?api_key=\(API_KEY)&country=\(countryCode)&year=\(currentYear)"
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        
        self.resourceURL = resourceURL
    }
    
    func getHolidays(completion: @escaping(Result<[HolidayDetail], HolidayError>) -> Void){
        let dataTask = URLSession.shared.dataTask(with: resourceURL) {data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.noDataAvailabe))
                return
            }
            
            do{
                let decoder = JSONDecoder()
                let holidayResponse = try decoder.decode(HolidayResponse.self, from: jsonData)
                let holidayDetails = holidayResponse.response.holidays
                completion(.success(holidayDetails))
            }catch{
                completion(.failure(.cannotProcessData))
          }
       }
        dataTask.resume()
    }
 }

