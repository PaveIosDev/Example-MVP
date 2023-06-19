//
//  MainPresenter.swift
//  Example MVP
//
//  Created by Павел Яковенко on 19.06.2023.
//

import Foundation

//MARK: - от презентера

protocol MainViewProtocol: AnyObject {
    func addPerson (person: Person)
    func deletePerson(index: Int)
}

//MARK: - к презентеру

protocol MainViewPresenterProtocol: AnyObject {
    init(view: MainViewProtocol)
    func addPerson(firstName: String)
    func deletePerson(index: Int)
}

class MainPresenter: MainViewPresenterProtocol {
    
    weak var view: MainViewProtocol?
    
    required init(view: MainViewProtocol) {
        self.view = view
    }
    
    func addPerson(firstName: String) {
        // логика
        let person = Person(firstName: firstName)
        // уведомление для view
        self.view?.addPerson(person: person)
    }
    
    func deletePerson(index: Int) {
        // может быть логика
        self.view?.deletePerson(index: index)
    }
    
    
}
