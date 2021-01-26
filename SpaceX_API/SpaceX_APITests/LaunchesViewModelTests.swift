//
//  LaunchViewModelTests.swift
//  LiftoffTests
//
//  Created by Admin on 24/1/21.
//  Copyright © 2021 Syd Srirak. All rights reserved.
//

import XCTest
import RxSwift
import RxCocoa
import RxDataSources

@testable import SpaceX_API

class LaunchesViewModelTests: XCTestCase {

    var launchesViewModel : LaunchesViewModel?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.launchesViewModel = LaunchesViewModel()
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.launchesViewModel = nil
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
        XCTAssert(nil != self.launchesViewModel)
    }
    
    func testLaunchModel() {


        let launchModel = LaunchModel(links: (Links(patch: (Patch(small: "url", large: "url")), wikipedia: "wiki")), staticFireDateUTC: "2020", staticFireDateUnix: 20202, rocket: "scddcd334", success: true, details: "Hello details", launchpad: "launch pad", autoUpdate: true, flightNumber: 110, name: "Falcon9", dateUTC1: Date.init(), launchDate: "2020", dateUnix: 22424, datePrecision: "2202", upcoming: true, id: "123")
        

        XCTAssert((launchModel.links?.patch?.small!.count)! > 0 , "No Image links comes")
        XCTAssert((launchModel.id!.count) > 0 , "No ID comes")
        XCTAssert((launchModel.links?.wikipedia!.count)! > 0 , "No wikipedia links comes")
        XCTAssert(launchModel.name.count > 0 , "No name links comes")
        XCTAssert(launchModel.launchDate.count > 0 , "No launchDate links comes")

        
        
        let disposeBag = DisposeBag()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Date.localFormat
        var tableView = UITableView()
        guard let viewModel = self.launchesViewModel else { return XCTFail() }

        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, LaunchModel>>(
            configureCell: { dataSource, table, indexPath, item in
                guard let cell = table.dequeueReusableCell(withIdentifier: LaunchesTableViewCell.classIdentifier, for: indexPath) as? LaunchesTableViewCell else { return UITableViewCell() }
                
                cell.missionLabel.text = item.name
                cell.dateLabel.text = dateFormatter.date(from: item.launchDate)?.toString()
                return cell
            },
            titleForHeaderInSection: { dataSource, index in
                return dataSource.sectionModels[index].model
            }
        )
        
        viewModel.sections
        .bind(to: tableView.rx.items(dataSource: dataSource))
        .disposed(by: disposeBag)
        
    
        guard let data = getJSONData(fileName: "Launches")else { return XCTFail() }

        let decoder = JSONDecoder()
        let launches: [LaunchModel] = try! decoder.decode([LaunchModel].self, from:  data as Data)

        XCTAssertNotNil(launches.count == 0, "No Launches Found!")
        XCTAssertNotNil(launches.first?.name.count == 0, "name Not Found!")
        XCTAssertTrue(launches.first?.links?.patch?.small?.count == 0, "patch small name Not Found!")
        XCTAssertTrue(launches.first?.id?.count == 0, "id Not Found!")

        XCTAssertNotNil(launches[1].name.count == 0, "name Not Found!")
        XCTAssertTrue(launches[1].links?.patch?.small?.count == 0, "patch small name Not Found!")
        XCTAssertTrue(launches[1].id?.count == 0, "id Not Found!")
        
        XCTAssertNotNil(launches[2].name.count == 0, "name Not Found!")
        XCTAssertTrue(launches[2].links?.patch?.small?.count == 0, "patch small name Not Found!")
        XCTAssertTrue(launches[2].id?.count == 0, "id Not Found!")
    }
    
    func testabc() {

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
