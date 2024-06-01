//
//  CachableRequestProtocol.swift
//  CinemaStar
//
//  Created by Kate Volkova on 1.06.24.
//

import Combine
import CoreData
import Foundation

/// Кэшируемый запрос
protocol CachableRequestProtocol {
    associatedtype ModelType
    associatedtype EntityType: NSFetchRequestResult
    /// Паблишер оригинального запроса
    var reqPublisher: Future<ModelType, NetworkError> { get }
    /// Маппинг данных в CoreData entities с контекстом
    func prepareDataForSave(_ data: ModelType, context: NSManagedObjectContext)
    /// Маппинг данных из закэшированных entities
    func mapDataFromCache(_ cache: [EntityType]) throws -> ModelType
    /// Создание запроса в кэш
    func cacheFetchRequest() -> NSFetchRequest<EntityType>
}
