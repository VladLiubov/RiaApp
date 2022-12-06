//
//  BaseFactory.swift
//  RiaApp
//
//  Created by Admin on 06.12.2022.
//

import SwiftUI

protocol AnyMediaSource {}
protocol AnyMediaSourceProvider {}

protocol AnyFactoryEnvironment {
  associatedtype Factory

  var factory: Factory! { get }
}

class BaseFactory {
  public enum ViewType {
    case imageView(AnyMediaSourceProvider)
  }
  
  public init() {}
  
  open func make(_ type: ViewType) -> AnyView {
    fatalError()
  }
}

