//
//  MovieDetailsCachableRequest.swift
//  CinemaStar
//
//  Created by Kate Volkova on 1.06.24.
//

import Combine
import CoreData
import Foundation

/// Кэшируемый запрос деталей фильма
final class MovieDetailsCachableRequest: CachableRequestProtocol {
    typealias ModelType = MovieDetails
    typealias EntityType = MovieDetailsEntity

    private(set) var reqPublisher: Future<MovieDetails, NetworkError>
    private let id: Int

    init(reqPublisher: Future<MovieDetails, NetworkError>, id: Int) {
        self.reqPublisher = reqPublisher
        self.id = id
    }

    func prepareDataForSave(_ data: MovieDetails, context: NSManagedObjectContext) {
        let entity = MovieDetailsEntity(context: context)
        mapModelToEntity(data, entity, context: context)
    }

    func mapDataFromCache(_ cache: [MovieDetailsEntity]) throws -> MovieDetails {
        guard let entity = cache.first(where: { $0.id == id }) else {
            throw NetworkError.noData
        }

        return MovieDetails(
            id: Int(entity.id),
            name: entity.name ?? "",
            posterUrl: entity.posterUrl != nil ? URL(string: entity.posterUrl ?? "") : nil,
            rating: entity.rating,
            description: entity.desc ?? "",
            releaseInfo: entity.releaseInfo ?? "",
            actors: (entity.actors?.allObjects as? [ActorEntity] ?? []).map(mapActorEntityToModel),
            language: entity.language,
            similarMovies: []
        )
    }

    func cacheFetchRequest() -> NSFetchRequest<MovieDetailsEntity> {
        MovieDetailsEntity.fetchRequest()
    }

    private func mapActorEntityToModel(_ entity: ActorEntity) -> Actor {
        Actor(
            id: Int(entity.id),
            photoUrl: entity.photoUrl != nil ? URL(string: entity.photoUrl ?? "") : nil,
            name: entity.name ?? ""
        )
    }

    private func mapModelToEntity(
        _ movieDetails: MovieDetails,
        _ movieEntity: MovieDetailsEntity,
        context: NSManagedObjectContext
    ) {
        movieEntity.id = Int64(movieDetails.id)
        movieEntity.name = movieDetails.name
        movieEntity.desc = movieDetails.description
        movieEntity.language = movieDetails.language
        movieEntity.rating = movieDetails.rating
        movieEntity.releaseInfo = movieDetails.releaseInfo
        movieEntity.posterUrl = movieDetails.posterUrl?.absoluteString

        var actorsEntitiesSet: Set<ActorEntity> = []
        for actor in movieDetails.actors {
            let actorEntity = ActorEntity(context: context)
            actorEntity.name = actor.name
            actorEntity.id = Int64(actor.id)
            actorEntity.photoUrl = actor.photoUrl?.absoluteString
            actorsEntitiesSet.insert(actorEntity)
        }

        movieEntity.actors = NSSet(set: actorsEntitiesSet)
    }
}
