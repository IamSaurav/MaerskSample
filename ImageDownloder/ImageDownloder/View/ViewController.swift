//
//  ViewController.swift
//  ImageDownloder
//
//  Created by Saurav Satpathy on 11/6/19.
//  Copyright © 2019 bitMountn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    lazy var viewModel = ImageDownloaderViewModel()
    override func viewDidLoad() {
        urlTextField.text = "https://homepages.cae.wisc.edu/~ece533/images/arctichare.png"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        viewModel.updated = {[unowned self] in
            self.tableView.reloadData()
        }
    }
    @IBAction func onDownloadButtonTap() {
        guard let urlString = urlTextField.text else {
            let alert = UIAlertController.init(title: "", message: "Please enter url", preferredStyle: .alert)
            present(alert, animated: true, completion: nil)
            return
        }
        guard let url = URL.init(string: urlString) else {
            let alert = UIAlertController.init(title: "", message: "Please enter valid url", preferredStyle: .alert)
            present(alert, animated: true, completion: nil)
            return
        }
        viewModel.downloadImage(url: url)
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.images.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "Cell")
        let image = viewModel.images[indexPath.row]
        cell.imageView?.image = UIImage.init(data: image.imageData!)
        cell.textLabel?.text = image.fileName
        cell.detailTextLabel?.text = "Progress: " + String(image.progressPercentage) + "%"
        return cell
    }
}
