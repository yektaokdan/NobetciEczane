//
//  ListView.swift
//  NobetciEczane
//
//  Created by yekta on 13.03.2024.
//

import UIKit

class ListView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var selectedProvince: String?
    var selectedDistrict: String?
    var viewModel = ListViewModel()
    var eczaneler: [Result] = []

    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView = UITableView(frame: view.bounds)
        view.addSubview(tableView)
        
        tableView.register(PharmacyCell.self, forCellReuseIdentifier: "PharmacyCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        // TableView Layout Constraints
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        fetchPharmacies()
        setupNavigationBar()
    }
    
    func fetchPharmacies() {
        if let province = selectedProvince, let district = selectedDistrict {
            viewModel.fetchPharmacies(city: province, district: district) {
                self.eczaneler = self.viewModel.eczaneler
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PharmacyCell", for: indexPath) as? PharmacyCell,
              let pharmacy = viewModel.eczaneAtIndex(indexPath.row) else {
            return UITableViewCell()
        }
        
        cell.configure(with: pharmacy)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100 // Özelleştirilebilir
    }
    func setupNavigationBar() {
        navigationController?.navigationBar.isHidden = false

        // Geri butonu
        let backButton = UIBarButtonItem(title: "Geri", style: .plain, target: self, action: #selector(backButtonTapped))
        self.navigationItem.leftBarButtonItem = backButton
    }
    @objc func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }

}

