//
//  HolidaysTableViewController.swift
//  HolidayCalendar
//
//  Created by Pragnya Deshpande on 10/03/20.
//  Copyright © 2020 PragnyaDesh. All rights reserved.
//

import UIKit

class HolidaysTableViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var listOfHolidays = [HolidayDetail]() {
        didSet{
            DispatchQueue.main.async {
                
                self.navigationItem.title = "\(self.listOfHolidays.count) Holidays found"
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
   
           func NumberOfSections(in tableView: UITableView) ->Int {
           return 1
    }
    
            func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return listOfHolidays.count
    }
    
           func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            
            let holiday = listOfHolidays[indexPath.row]
            
            cell.textLabel?.text = holiday.name
            cell.detailTextLabel?.text = holiday.date.iso
            return cell
    }
}

extension HolidaysTableViewController : UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchBarText = searchBar.text else {return}
        let holidayRequest = HolidayRequest(countryCode: searchBarText)
        holidayRequest.getHolidays{[weak self] result in
            switch result{
            case.failure(let error):
                print(error)
            case.success(let holidays):
                self?.listOfHolidays = holidays
           }
       }
    }
}

