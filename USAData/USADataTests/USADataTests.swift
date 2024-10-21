//
//  USADataTests.swift
//  USADataTests
//
//  Created by Daniel Silva on 16/10/2024.
//

import XCTest
@testable import USAData

final class USADataTests: XCTestCase {
    
    var vc: ViewController!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        vc = storyboard.instantiateViewController(identifier: "ViewController")
        vc.loadViewIfNeeded()
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testViews() {
        XCTAssertNotNil(vc.tableView)
    }
    
    func testShowYear() {
        vc.showHideYearSelection(show: true)
        XCTAssertEqual(vc.showYearConstraint.constant, 60)
        vc.showHideYearSelection(show: false)
        XCTAssertEqual(vc.showYearConstraint.constant, 10)
    }
    
    func testChangeYear() {
        vc.actualYear = 2022
        vc.changeYear(swipe: .right)
        XCTAssertEqual(vc.actualYear, 2021)
        vc.changeYear(swipe: .left)
        XCTAssertEqual(vc.actualYear, 2022)
    }
    
    func testChangeToStates() {
        vc.segmentControl.selectedSegmentIndex = 1
        vc.segmentControl.sendActions(for: .valueChanged)
        vc.updateUI()
        XCTAssertEqual(vc.listType, .states)
        vc.segmentControl.selectedSegmentIndex = 0
        vc.segmentControl.sendActions(for: .valueChanged)
        vc.updateUI()
        XCTAssertEqual(vc.listType, .nation)
    }
    
    func testCellForRow() {
        vc.listType = .states
        vc.updateUI()
        XCTAssertNotNil(vc.tableView)
    }
    
    func testButtons() {
        vc.actualYear = 2020
        vc.btnYearAfterPressed(UIButton())
        XCTAssertEqual(vc.actualYear, 2021)
        vc.btnYearBeforePressed(UIButton())
        XCTAssertEqual(vc.actualYear, 2020)
    }
    
    func testSwipe() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(vc.respondToSwipeGesture))
        swipeRight.direction = .right
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(vc.respondToSwipeGesture))
        swipeLeft.direction = .left
        
        vc.actualYear = 2020
        vc.respondToSwipeGesture(gesture: swipeRight)
        XCTAssertEqual(vc.actualYear, 2019)
        vc.respondToSwipeGesture(gesture: swipeLeft)
        XCTAssertEqual(vc.actualYear, 2020)
    }
    
    func testCell() {
        let cellTest = DataInfoTableViewCell(style: .default, reuseIdentifier: DataInfoTableViewCell.reuseIdentifier)
        let cell = vc.tableView.dequeueReusableCell(withIdentifier: DataInfoTableViewCell.reuseIdentifier, for: IndexPath()) as! DataInfoTableViewCell
        cell.prepareForReuse()
        cell.setupCell(name: "", year: "", population: nil)
        XCTAssertNotNil(cellTest)
        XCTAssertNotNil(cell)
    }
    
    func testShowError() {
        let text = "Test"
        vc.showErrorMessage(text: text)
        XCTAssertNotNil(text)
    }
}
