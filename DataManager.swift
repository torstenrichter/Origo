//
//  DataManager.swift
//  Origo
//
//  Created by Torsten Richter on 06.09.18.
//  Copyright © 2018 Torsten Richter. All rights reserved.
//

import UIKit
import IntentsUI
import os.log

public class DataManager {
    func getBookingList() -> [TimeEntry] {
        var timeentries:[TimeEntry] = []
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            timeentries = try context.fetch(TimeEntry.fetchRequest())
        } catch {
            os_log("Error fetching timeentries")
        }
        return timeentries
    }

}
