//
//  ViewController.swift
//  ScrollLength
//
//  Created by Daniel Hjärtström on 2020-06-17.
//  Copyright © 2020 Daniel Hjärtström. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var items = [Any]()
    
    private lazy var progressView: UIProgressView = {
        let temp = UIProgressView()
        temp.progressTintColor = .blue
        temp.trackTintColor = .clear
        temp.layer.cornerRadius = 2
        temp.clipsToBounds = true
        temp.layer.sublayers![1].cornerRadius = 2
        temp.subviews[1].clipsToBounds = true
        view.addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -3.0).isActive = true
        temp.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 3.0).isActive = true
        temp.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        temp.heightAnchor.constraint(equalToConstant: 4.0).isActive = true
        return temp
    }()
    
    private lazy var tableView: UITableView = {
        let temp = UITableView()
        temp.delegate = self
        temp.dataSource = self
        temp.tableFooterView = UIView()
        temp.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        view.addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        temp.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        temp.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 2.0).isActive = true
        temp.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        return temp
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }


}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let progress = Float(scrollView.contentOffset.y / (scrollView.contentSize.height - view.frame.height))
        progressView.progress = progress
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.section) - \(indexPath.row)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
