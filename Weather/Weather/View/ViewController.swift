//
//  ViewController.swift
//  ImageDownloder
//
//  Created by Saurav Satpathy on 11/6/19.
//  Copyright © 2019 bitMountn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    lazy var viewModel = WeatherViewModel()
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.getWeather(searchBar.text!) { (weather, error) in
            guard let error = error else {
                self.tableView.reloadData()
                return
            }
            let alert = UIAlertController.init(title: "", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction.init(title: "Ok", style: .default, handler: .none))
            self.present(alert, animated: true, completion: .none)
        }
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.weatherInfo?.weather?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "Cell")
        guard let weathers = viewModel.weatherInfo?.weather, weathers.count > indexPath.row else {
            return cell
        }
        let weather = weathers[indexPath.row]
        cell.textLabel?.text = viewModel.weatherInfo?.name
        var description = "Weather: " + weather.weatherDescription!
        if let humidity = viewModel.weatherInfo?.main?.humidity {
            description += ", Humidity : " + String(humidity)
        }
        cell.detailTextLabel?.text = description
        return cell
    }
}
