//
//  ReservationServiceTests.swift
//  CampgroundManagerTests
//
//  Created by Egor Gorskikh on 30.05.2021.
//  Copyright © 2021 Razeware. All rights reserved.
//

import XCTest

import Foundation
import CoreData
import XCTest
import CampgroundManager

class ReservationServiceTests: XCTestCase {
  // MARK: Properties
  var campSiteService: CampSiteService!
  var camperService: CamperService!
  var reservationService: ReservationService!
  var coreDataStack: CoreDataStack!
  
  override func setUp() {
    super.setUp()
    
    coreDataStack = TestCoreDataStack()
    camperService = CamperService( managedObjectContext: coreDataStack.mainContext,
                                   coreDataStack: coreDataStack)
    campSiteService = CampSiteService( managedObjectContext: coreDataStack.mainContext,
                                       coreDataStack: coreDataStack)
    reservationService = ReservationService( managedObjectContext: coreDataStack.mainContext,
                                             coreDataStack: coreDataStack)
  }
  
  override func tearDown() {
    super.tearDown()
    
    camperService = nil
    campSiteService = nil
    reservationService = nil
    coreDataStack = nil
  }
  
  func testReserveCampSitePositiveNumberOfDays() {
    let camper = camperService.addCamper( "Johnny Appleseed",
                                          phoneNumber: "408-555-1234")!
    let campSite = campSiteService.addCampSite( 15,
                                                electricity: false,
                                                water: false)
    
    let result = reservationService.reserveCampSite( campSite,
                                                     camper: camper,
                                                     date: Date(),
                                                     numberOfNights: 5)
    
    XCTAssertNotNil(result.reservation, "Reservation should not be nil")
    XCTAssertNil(result.error, "No error should be present")
    XCTAssertTrue( result.reservation?.status == "Reserved",
                   "Status should be Reserved")
  }
  
  func testReserveCampSiteNegativeNumberOfDays() {
    let camper = camperService.addCamper( "Johnny Appleseed",
                                          phoneNumber: "408-555-1234")!
    
    let campSite = campSiteService.addCampSite( 15,
                                                electricity: false,
                                                water: false)
    
    let result = reservationService!.reserveCampSite( campSite,
                                                      camper: camper,
                                                      date: Date(),
                                                      numberOfNights: -1)
    
    XCTAssertNotNil(result.reservation, "Reservation should not be nil")
    XCTAssertNotNil(result.error, "No error should be present")
    XCTAssertTrue(
      result.error?.userInfo["Problem"] as? String == "Invalid number of days",
      "Error problem should be present")
    XCTAssertTrue(result.reservation?.status == "Invalid", "Status should be Invalid")
  }
}
