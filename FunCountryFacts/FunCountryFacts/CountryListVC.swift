//
//  CountryListVC.swift
//  FunCountryFacts
//
//  Created by Hector Steven on 4/1/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit

class CountryListVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
	fileprivate let tableView = UITableView()
	fileprivate let cellId = "cellid"
	var factsJsonList = [CountryFacts]()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = .white
		title = "Fun Country Facts"
		setupTV()
		performSelector(inBackground: #selector(getJson), with: nil)
    }
}


extension CountryListVC {
	@objc func getJson() {
		let forResource = "CountriesFactAPI"
		let withExtension = "json"
		
		if let factjson = Bundle.main.url(forResource: forResource, withExtension: withExtension) {
			if let data = try? Data(contentsOf: factjson) {
				parseJson(data)
				return
			}
		}
		print("Error: GetJson")
	}
	
	func parseJson(_ json: Data) {
		print(json)
		let decoder = JSONDecoder()
		if let decoded = try? decoder.decode(Countries.self, from: json) {
			factsJsonList = decoded.results
			self.tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
			return
		}
		print("Error: parseJson()")
	}
}

extension CountryListVC {
	fileprivate func setupTV() {
		view.addSubview(tableView)
		tableView.register(CountryListCell.self, forCellReuseIdentifier: cellId)
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.delegate = self
		tableView.dataSource = self
		
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
			tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
			])
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return factsJsonList.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CountryListCell
		cell.accessoryType = .disclosureIndicator

		let str =  factsJsonList[indexPath.row].country
		let image =  UIImage(named: str)
		
		
		cell.flagImageView.image = image
		cell.flagNameLabel.text = str.uppercased()
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 85
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		
//		let cell = [tableView.cellForRow(at: indexPath)]
		// TODO :core animate the image view
		
		let vc = CountryFactListVC()
		vc.country = factsJsonList[indexPath.row]
		navigationController?.pushViewController(vc, animated: true)
	}
}
