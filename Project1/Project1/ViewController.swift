//
//  ViewController.swift
//  Project1
//
//  Created by Hector Steven on 2/19/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
	
	//var pictueres = [String]()
	
	var picturesCount = [Picture]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		title = "Storm Viewer"
		navigationController?.navigationBar.prefersLargeTitles = true
		
		let defaults = UserDefaults.standard
		if let savedCount = defaults.object(forKey: "picturesCount") as? Data {
			let jsondecoder = JSONDecoder()
			do{
				picturesCount = try jsondecoder.decode([Picture].self, from: savedCount)
				print(picturesCount.count)
			} catch {
				print("Was not able reload user Data")
			}
		}
		
		if picturesCount.isEmpty {
			performSelector(inBackground: #selector(fetchImages), with: nil)
		}
		
		tableView.reloadData()
	}

	//tableView()/////////////////////////////////////////////////////////////
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return picturesCount.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
		//variable just holds a text -- pictures[indexPath.row]
		cell.textLabel?.text = "\(indexPath.row + 1) of \(picturesCount.count)" //set text in each table
		return cell
	}

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {

			vc.selectedImage = picturesCount[indexPath.row].name
			vc.selectedCount = picturesCount[indexPath.row].count
			picturesCount[indexPath.row].count += 1
			save()
			
			navigationController?.pushViewController(vc, animated: true)
		}
	}
	
	//@objc()/////////////////////////////////////////////////////////////////
	
	@objc func fetchImages() {
		let fm = FileManager.default //data type that lets us work with the filesystem
		let path = Bundle.main.resourcePath! //directory path to pictures
		let items = try! fm.contentsOfDirectory(atPath: path)   //The items constant will be an array of strings containing
		
		for item in items {
			
			if item.hasPrefix("nssl") {
				
				picturesCount.append(Picture(name: item, count: 1))
				
			}
		}
		tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
		
//		print(picturesCount.count)
	}
	
	// func() /////////////////////////////////////////////////////////////////
	
	func save() {
		let jsonEncoder = JSONEncoder()
		if let saveData = try? jsonEncoder.encode(picturesCount) {
			let defaults = UserDefaults.standard
			defaults.set(saveData, forKey: "picturesCount")
		} else {
			print("Failled to save Data!")
		}
		
	}
	
}

