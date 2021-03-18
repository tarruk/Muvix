//
//  SubscriptedMovieDB+CoreDataProperties.swift
//  MoviesApp
//
//  Created by Tarek on 17/03/2021.
//
//

import Foundation
import CoreData


extension MovieDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieDB> {
        return NSFetchRequest<MovieDB>(entityName: "MovieDB")
    }

    @NSManaged public var title: String?
    @NSManaged public var overview: String?
    @NSManaged public var selectedGenre: String?
    @NSManaged public var posterPath: String?
    @NSManaged public var subscribed: Bool
    @NSManaged public var id: Int64
    @NSManaged public var year: String?

}

extension MovieDB : Identifiable {

}
