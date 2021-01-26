//
//  LaunchViewModelTests.swift
//  SpaceXTests
//
//  Created by Admin on 24/1/21.
//  Copyright © 2021 Syd Srirak. All rights reserved.
//

import XCTest
import RxSwift
import RxCocoa
import RxDataSources

@testable import SpaceX_API

class LaunchesDetailsViewModelTests: XCTestCase {

    var launchDetailViewModel : LaunchDetailViewModel?
    
    override func setUp() {
        super.setUp()
        
        let launchModel = LaunchModel(links: (Links(patch: (Patch(small: "url", large: "url")), wikipedia: "wiki")), staticFireDateUTC: "2020", staticFireDateUnix: 20202, rocket: "scddcd334", success: true, details: "Hello details", launchpad: "launch pad", autoUpdate: true, flightNumber: 110, name: "Falcon9", dateUTC1: Date.init(), launchDate: "2020", dateUnix: 22424, datePrecision: "2202", upcoming: true, id: "123")

        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.launchDetailViewModel = LaunchDetailViewModel(flightNumber: 110, rocketId: "5e9d0d95eda69973a809d1ec", launch: launchModel)
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.launchDetailViewModel = nil
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testInit() {
        XCTAssert(nil != self.launchDetailViewModel)
    }
    
    func testRocketModel() {


        let rocketModel = RocketModel(id: "1223", active: true, stages: 1, boosters: 1, country: "USA", company: "NASA", wikipedia: "wiki URL", description: "my details", rocketName: "Falcon9")
        

        XCTAssert((rocketModel.id.count) > 0 , "No ID comes")
        XCTAssert((rocketModel.wikipedia.count) > 0 , "No wikipedia links comes")
        XCTAssert(rocketModel.rocketName.count > 0 , "No name links comes")
        XCTAssert(rocketModel.company.count > 0 , "No company links comes")

        
        
        let disposeBag = DisposeBag()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Date.localFormat
        var tableView = UITableView()
        guard let viewModel = self.launchDetailViewModel else { return XCTFail() }

    
        guard let data = getJSONData(fileName: "RocketDetails")else { return XCTFail() }

        let decoder = JSONDecoder()
        var rocketDetails: RocketModel = try! decoder.decode(RocketModel.self, from:  data as Data)

        //rocketDetails.wikipedia = ""
        XCTAssertNotNil(rocketDetails.rocketName.count > 0, "name Not Found!")
        XCTAssertTrue(rocketDetails.wikipedia.count > 0, "wikipedia Not Found!")
        XCTAssertTrue(rocketDetails.id.count > 0, "id Not Found!")
        XCTAssert(rocketDetails.company.count > 0 , "No company links comes")

    }
    

    func getJSONData(fileName:String) -> Data? {
        if let filePath = Bundle.main.path(forResource: fileName, ofType: "json"), let data = NSData(contentsOfFile: filePath) {
            do {
                return data as Data
            }
            catch {
                //Handle error
                print("Error:", error.localizedDescription)
                return nil
            }
        }
        return nil

    }
}
