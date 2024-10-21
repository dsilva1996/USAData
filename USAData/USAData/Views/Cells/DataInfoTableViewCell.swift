//
//  DataInfoTableViewCell.swift
//  USAData
//
//  Created by Daniel Silva on 18/10/2024.
//

import UIKit

class DataInfoTableViewCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblYear: UILabel!
    @IBOutlet weak var lblPopulation: UILabel!
    
    static let reuseIdentifier = "DataInfoTableViewCell"

    //MARK: - Override Methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        self.lblName.text = nil
        self.lblYear.text = nil
        self.lblPopulation.text = nil
    }
    
    //MARK: - Public Methods
    func setupCell(name: String?, year: String?, population: Int?) {
        self.lblName.text = name
        self.lblYear.text = year
        self.lblPopulation.text = "\(String(population ?? 0)) Inhabitants"
    }
}
