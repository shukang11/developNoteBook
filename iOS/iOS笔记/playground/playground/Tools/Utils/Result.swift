//
//  Result.swift
//  playground
//
//  Created by tree on 2019/2/27.
//  Copyright © 2019 treee. All rights reserved.
//

import UIKit

public enum Result<Success, Failure: Error> {
    case success(Success)
    case failure(Failure)
    
    public func get() throws -> Success {
        switch self {
        case let .success(success):
            return success
        case let .failure(failure):
            throw failure
        }
    }
    
    public func map<NewSuccess>(
        _ transform: (Success) -> NewSuccess
        ) -> Result<NewSuccess, Failure> {
        switch self {
        case let .success(success):
            return .success(transform(success))
        case let .failure(failure):
            return .failure(failure)
        }
    }
    
    public func mapError<NewFailure>(
        _ transform: (Failure) -> NewFailure
        ) -> Result<Success, NewFailure> {
        switch self {
        case let .success(success):
            return .success(success)
        case let .failure(failure):
            return .failure(transform(failure))
        }
    }
    
    public func flatMap<NewSuccess>(
        _ transform: (Success) -> Result<NewSuccess, Failure>
        ) -> Result<NewSuccess, Failure> {
        switch self {
        case let .success(success):
            return transform(success)
        case let .failure(failure):
            return .failure(failure)
        }
    }
}
