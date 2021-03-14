//
//  NotificationNames.swift
//  MoviesApp
//
//  Created by Tarek on 14/03/2021.
//

import Foundation
import UIKit


extension Notification.Name {
    
    static var updateSubscribedMovies: Notification.Name {
        return Notification.Name("UPDATE_SUBSCRIBED_MOVIES")
    }
}
