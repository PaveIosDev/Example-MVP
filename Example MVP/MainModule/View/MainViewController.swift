//
//  ViewController.swift
//  Example MVP
//
//  Created by Павел Яковенко on 19.06.2023.
//

import UIKit

class MainViewController: UIViewController {

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .none
        tableView.bounces = false
        tableView.showsVerticalScrollIndicator = false
        tableView.delaysContentTouches = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var presenter: MainPresenter?
    
    private var personArray = [Person]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(addButtonTapped))
        
//        presenter = MainPresenter(view: self)
    }
    
    private func setupViews() {
        title = "MainVC"
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    @objc private func addButtonTapped() {
        let alert = UIAlertController(title: "Add person", message: nil, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .destructive)
        
        let add = UIAlertAction(title: "Add", style: .default) { _ in
            if let text = alert.textFields?.first?.text {
                self.presenter?.addPerson(firstName: text)
            }
        }
        alert.addTextField()
        alert.addAction(cancel)
        alert.addAction(add)
        
        present(alert, animated: true)
    }
}

extension MainViewController: MainViewProtocol {
    func addPerson(person: Person) {
        personArray.append(person)
        tableView.reloadData()
    }
    
    func deletePerson(index: Int) {
        personArray.remove(at: index)
        tableView.reloadData()
    }
}

//MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        personArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = personArray[indexPath.row].firstName
        return cell
    }
}

//MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { _, _, _ in
            self.presenter?.deletePerson(index: indexPath.row)
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
}



//MARK: - setConstraints

extension MainViewController {
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}
