// Actor.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Актер фильма
struct Actor: Identifiable {
    /// Идентификатор
    let id: Int
    /// Url фотографии
    let photoUrl: URL?
    /// Имя
    let name: String

    init(id: Int, photoUrl: URL?, name: String) {
        self.id = id
        self.photoUrl = photoUrl
        self.name = name
    }

    init(fromDTO actorDTO: PersonDTO) {
        id = actorDTO.id
        photoUrl = URL(string: actorDTO.photo)
        name = actorDTO.name ?? actorDTO.enName ?? ""
    }
}
