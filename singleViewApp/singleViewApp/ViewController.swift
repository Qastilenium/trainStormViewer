//
//  ViewController.swift
//  singleViewApp
//
//  Created by Soraya Ollo on 2/16/24.
//

import UIKit

class ViewController: UITableViewController {

    var pictures = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Storm Viewer"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "info.circle"), style: .done, target: self, action: #selector(showInfo))
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)

        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
        print(pictures)
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pictures.sort()
        return pictures.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = "Picture \(pictures.firstIndex(of: pictures[indexPath.row])! + 1) of \(pictures.count)"
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    @objc func showInfo() {
        let ac = UIAlertController(title: "About App", message: "Storm Viewer, v. 1.0. Created by Ilryc Marokonen, 2024. Thx for hackingwithswift.com for a guide!", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Okay, got it", style: .default))
        present(ac, animated: true)
    }
}

