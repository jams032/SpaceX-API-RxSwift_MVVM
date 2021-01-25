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
       // XCTAssert(nil != self.launchesViewModel?.wordList)
    }
    
    func testLaunchModel() {

        let lightModel1 = LaunchModel(links: (Links(patch: (Patch(small: "url", large: "url")), wikipedia: "wiki")), staticFireDateUTC: "2020", staticFireDateUnix: 20202, rocket: "scddcd334", success: true, details: "Hello details", launchpad: "launch pad", autoUpdate: true, flightNumber: 110, name: "Falcon9", dateUTC1: Date.init(), launchDate: "2020", dateUnix: 22424, datePrecision: "2202", upcoming: true, id: "123")
          
          
        guard let viewModel = self.launchesViewModel else { return XCTFail() }


        
      //  XCTAssert(lightModel1.links?.patch?.small?.count > 0 , "No Image links comes")
        
        
        let disposeBag = DisposeBag()

        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Date.localFormat
        var tableView = UITableView()

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
        
        viewModel.retrieveLaunches()

        
      //  let fetchedElement = viewModel.getElement(at: IndexPath(row: 0, section: 0))
      //  XCTAssertEqual(element, fetchedElement)
        
        
      //  viewModel.deleteWord(index: 0)
       // guard let listRet = viewModel.wordList else { return XCTFail() }
       // XCTAssert(1 == listRet.value.count)
        
        //let vocaRet = listRet.value[0]
       // XCTAssert("TEST2" == vocaRet.word && "TEST2_Meaning" == vocaRet.meaning)
    }
    
    func testButtonEditPressed() {
//        launchesViewModel?.isTableViewEditing.accept(false)
//        launchesViewModel?.action.onNext(.buttonEditTapped)
//        XCTAssert(true == launchesViewModel?.isTableViewEditing.value)
//        XCTAssert("Edit" == launchesViewModel?.titleOfButtonEdit.value)
//
//        launchesViewModel?.action.onNext(.buttonEditTapped)
//        XCTAssert(false == launchesViewModel?.isTableViewEditing.value)
//        XCTAssert("Done" == launchesViewModel?.titleOfButtonEdit.value)
    }
}
