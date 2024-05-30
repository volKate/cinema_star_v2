// NetworkError.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Ошибки запросов в сеть
enum NetworkError: Error {
    /// Невалидный url
    case invalidUrl
    /// Нет данных
    case noData
    /// Неизвестная ошибка сети
    case unknown
    /// Ошибка ответа
    case responseError
    /// Ошибка парсинга
    case parsing
}
