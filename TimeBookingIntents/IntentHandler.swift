//
//  IntentHandler.swift
//  TimeBookingIntents
//
//  Created by Torsten Richter on 06.09.18.
//  Copyright © 2018 Torsten Richter. All rights reserved.
//

import Intents

class IntentHandler: INExtension {
    
    override func handler(for intent: INIntent) -> Any {
        guard intent is TimeBookingIntent else {
            fatalError("Unhandled intent type: \(intent)")
        }
        return TimeBookingIntentHandler()
    }
    
}
