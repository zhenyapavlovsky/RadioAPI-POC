//
//  DomainModelConvertible.swift
//  RadioAPI-POC
//
//  Created by Yevhen Pavlovskyy on 30.07.2024.
//

import Foundation

protocol DomainModelConvertible {
    associatedtype DomainModelType
    func toDomainModel() -> DomainModelType
}
