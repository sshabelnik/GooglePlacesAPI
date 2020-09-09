//
//  DetailsViewController.swift
//  GooglePlacesAPI
//
//  Created by Сергей Шабельник on 07.09.2020.
//  Copyright © 2020 Сергей Шабельник. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var places: [PlaceModel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

//MARK: - Configure TableView
extension DetailsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MainTableViewCell
        DispatchQueue.main.async {
            cell.setup(for: self.places[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.selectionStyle = .none
        cell?.isSelected = false
    }
    
    
}
