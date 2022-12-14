/*
 * Copyright (c) Meta Platforms, Inc. and affiliates.
 * All rights reserved.
 *
 * This source code is licensed under the license found in the
 * LICENSE file in the root directory of this source tree.
 */

@dynamicMemberLookup
protocol DependentAsType {
  associatedtype TypeDependencies

  static var configuredDependencies: TypeDependencies? { get set }
  static var defaultDependencies: TypeDependencies? { get }

  static func setDependencies(_ dependencies: TypeDependencies)

  #if DEBUG
  static func resetDependencies()
  #endif
}

extension DependentAsType {
  static func setDependencies(_ dependencies: TypeDependencies) {
    configuredDependencies = dependencies
  }

  #if DEBUG
  static func resetDependencies() {
    configuredDependencies = nil
  }
  #endif

  static func getDependencies() throws -> TypeDependencies {
    guard let dependencies = configuredDependencies ?? defaultDependencies else {
      throw MissingDependenciesError(for: Self.self)
    }

    return dependencies
  }

  static subscript<Dependency>(dynamicMember keyPath: KeyPath<TypeDependencies, Dependency>) -> Dependency? {
    try? getDependencies()[keyPath: keyPath]
  }
}
