//
//  ViewController.swift
//  USAData
//
//  Created by Daniel Silva on 16/10/2024.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var showYearConstraint: NSLayoutConstraint!
    @IBOutlet weak var lblYear: UILabel!
    @IBOutlet weak var viewYear: UIView!
    @IBOutlet weak var lblNoData: UILabel!
    
    //MARK: - Variables/Constants
    var listType: ListType = .nation
    var lastYear: Int = 2022
    var actualYear: Int = 2022
    var dataViewModel = DataViewModel()
    
    //MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSwipes()
        self.setupTableView()
        self.setupData()
    }
    
    //MARK: - Private Methods
    private func setupSwipes() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeRight.direction = .right
        self.viewYear.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeLeft.direction = .left
        self.viewYear.addGestureRecognizer(swipeLeft)
    }
    
    private func setupTableView() {
        self.tableView.separatorStyle = .singleLine
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: DataInfoTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: DataInfoTableViewCell.reuseIdentifier)
    }
    
    private func setupData() {
        self.dataViewModel.fetchData { success, error in
            if success == true {
                DispatchQueue.main.async {
                    self.updateUI()
                }
            } else if let err = error {
                print("Error: \(err)")
            } else {
                print("Error")
            }
        }
    }
    
    func updateUI() {
        self.tableView.reloadData()
    }
    
    func showHideYearSelection(show: Bool) {
        self.showYearConstraint.constant = show ? 60 : 10
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    func changeYear(swipe: UISwipeGestureRecognizer.Direction) {
        if swipe == .right {
            lblYear.text = String(actualYear - 1)
            actualYear -= 1
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        } else if swipe == .left {
            lblYear.text = String(actualYear + 1)
            actualYear += 1
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
        
        dataViewModel.requestStatesWithYear(year: String(actualYear)) { success, error in
            if success == true {
                DispatchQueue.main.async {
                    self.tableView.isHidden = self.dataViewModel.statesArray.count == 0
                    self.lblNoData.isHidden = self.dataViewModel.statesArray.count != 0
                    self.updateUI()
                }
            } else if let err = error {
                print("Error: \(err)")
            } else {
                print("Error")
            }
        }
    }
    
    func showErrorMessage(text: String) {
        let alert = UIAlertController(title: "Error", message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alert, animated: true)
    }
    
    //MARK: - Actions
    @IBAction func segmentPressed(_ sender: Any) {
        self.listType = ListType(rawValue: segmentControl.selectedSegmentIndex) ?? .nation
        self.showHideYearSelection(show: self.listType == .states)
        self.updateUI()
    }
    
    @IBAction func btnYearBeforePressed(_ sender: Any) {
        self.changeYear(swipe: .right)
    }
    
    @IBAction func btnYearAfterPressed(_ sender: Any) {
        self.changeYear(swipe: .left)
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            self.changeYear(swipe: swipeGesture.direction)
        }
    }
    
    //MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch listType {
        case .nation:
            return dataViewModel.nationsArray.count
        case .states:
            return dataViewModel.statesArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: DataInfoTableViewCell.reuseIdentifier, for: indexPath) as? DataInfoTableViewCell {
            cell.prepareForReuse()
            switch listType {
            case .nation:
                let model = dataViewModel.nationsArray[indexPath.row]
                cell.setupCell(name: model.nation, year: model.year, population: model.population)
            case .states:
                let model = dataViewModel.statesArray[indexPath.row]
                cell.setupCell(name: model.state, year: model.year, population: model.population)
            }
            return cell
        } else {
            return UITableViewCell()
        }
    }
}
