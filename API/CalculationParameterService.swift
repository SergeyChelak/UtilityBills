//
//  CalculationParameterService.swift
//  UtilityBills
//
//  Created by Sergey on 28.08.2024.
//

import Foundation

protocol CalculationParameterService {
    func allCalculationParameters(for property: PropertyObject) async throws -> [CalculationParameter]
    
    func createCalculationParameter(for property: PropertyObject) async throws -> CalculationParameter
    
    func updateCalculationParameter(_ parameter: CalculationParameter) async throws
    
    func deleteCalculationParameter(_ parameter: CalculationParameter) async throws
}
