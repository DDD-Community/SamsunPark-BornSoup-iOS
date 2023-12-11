//
//  Neighborhood.swift
//  PresentationKit
//
//  Created by 신의연 on 12/3/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import ComposableArchitecture

import Foundation
import MapKit
import CoreLocation
import DomainKit
import SwiftUI

public struct Neighborhood: Reducer {
    public struct SelectableCategory: Equatable {
        var category: ContentsType
        var isSelected: Bool
        
        func getContentsImage() -> Image {
            switch category {
            case .review:
                return DesignSystemKitAsset.icOldPalace24.swiftUIImage
            case .location:
                return DesignSystemKitAsset.icOldPalace24.swiftUIImage
            case .palace:
                return DesignSystemKitAsset.icOldPalace24.swiftUIImage
            case .music:
                return DesignSystemKitAsset.icMusic24.swiftUIImage
            case .dance:
                return DesignSystemKitAsset.icDance24.swiftUIImage
            case .craft:
                return DesignSystemKitAsset.icCrafts24.swiftUIImage
            case .experience:
                return DesignSystemKitAsset.icExperience24.swiftUIImage
            case .museum:
                return DesignSystemKitAsset.icMuseum24Colored.swiftUIImage
            case .artGallery:
                return DesignSystemKitAsset.icArtGallery24Colored.swiftUIImage
            case .performance:
                return DesignSystemKitAsset.icExperience24.swiftUIImage
            case .etc:
                return DesignSystemKitAsset.icSetting24.swiftUIImage
            }
        }
    }
    
    public struct State: Equatable {
        public static func == (lhs: Neighborhood.State, rhs: Neighborhood.State) -> Bool {
            return lhs.region.center.latitude == rhs.region.center.latitude
            && lhs.region.center.longitude == rhs.region.center.latitude
            && lhs.region.span.latitudeDelta == rhs.region.span.latitudeDelta
            && lhs.region.span.longitudeDelta == rhs.region.span.longitudeDelta
        }
        
        var region: MKCoordinateRegion = .init(
            center: .gangnam,
            span: MKCoordinateSpan(
                latitudeDelta: 0.05,
                longitudeDelta: 0.05
            )
        )
        var visibleRect: MKMapRect = .init()
        var contentsAnnotationList: [ContentsAnnotation] = []
        var selectableCategories: [SelectableCategory] = []
        var text: String = ""
        
        var search: Search.State = .init(text: "", recentSearches: [], searchResultList: .init(contentsList: []))
    }
    
    public enum Action {
        case onAppear
        case regionChanged(MKCoordinateRegion)
        case visibleRectChanged(MKMapRect)
        case searchTextChanged(String)
        case categorySelected(Int)
        case contentsListChanged(ContentsType)
        
        case search(Search.Action)
    }
    
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
                
            case .regionChanged(let region):
                state.region = region
                print(region)
                return .none
                
            case .visibleRectChanged(let rect):
                print(rect.minX, rect.maxX, rect.minY, rect.maxY)
                return .none
                
            case let .searchTextChanged(text):
                state.text = text
                return .none
                
            case let .categorySelected(index):
                for (idx, _) in state.selectableCategories.enumerated() {
                    if idx == index {
                        state.selectableCategories[idx].isSelected.toggle()
                    } else {
                        state.selectableCategories[idx].isSelected = false
                    }
                }
                return .send(.contentsListChanged(state.selectableCategories[index].isSelected ? state.selectableCategories[index].category : ContentsType.location))
                
            case .contentsListChanged:
                return .none
                
            case .search:
                return .none
            }
        }
        Scope(state: \.search, action: /Action.search) {
            Search()
        }
    }
}

extension Neighborhood {
    static let placeholder = Neighborhood.State(
        contentsAnnotationList: [
            ContentsAnnotation(
                name: "gangnam",
                coordinate: .init(latitude: 37.49797616957218, longitude: 127.02764665816525),
                category: .artGallery
            ),
            ContentsAnnotation(
                name: "gyeongbokgung",
                coordinate: .init(latitude: 37.578611, longitude: 126.977222),
                category: .palace
            ),
            ContentsAnnotation(
                name: "국립현대미술관",
                coordinate: .init(latitude: 37.578628, longitude: 126.980261),
                category: .artGallery
            ),
            
            ContentsAnnotation(
                name: "Lola's Place",
                coordinate: .init(latitude: -32.4, longitude: 115.7),
                category: .location
            )
        ], selectableCategories: [
            SelectableCategory(category: .artGallery, isSelected: false),
            SelectableCategory(category: .craft, isSelected: false),
            SelectableCategory(category: .dance, isSelected: false)
        ])
}

extension CLLocationCoordinate2D {
    static let gangnam = CLLocationCoordinate2D(latitude: 37.49797616957218, longitude: 127.02764665816525)
    static let gyeongbokgung = CLLocationCoordinate2D(latitude: 37.578611, longitude: 126.977222)
}

public struct ContentsAnnotation: Identifiable {
    public var id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
    let category: ContentsType
    
    func getCategoryImage() -> Image {
        switch category {
        case .review:
            return DesignSystemKitAsset.icOldPalace24Colored.swiftUIImage
        case .location:
            return DesignSystemKitAsset.icOldPalace24Colored.swiftUIImage
        case .palace:
            return DesignSystemKitAsset.icOldPalace24Colored.swiftUIImage
        case .music:
            return DesignSystemKitAsset.icMusic24Colored.swiftUIImage
        case .dance:
            return DesignSystemKitAsset.icDance24Colored.swiftUIImage
        case .craft:
            return DesignSystemKitAsset.icCrafts24Colored.swiftUIImage
        case .experience:
            return DesignSystemKitAsset.icExperience24Colored.swiftUIImage
        case .museum:
            return DesignSystemKitAsset.icMuseum24Colored.swiftUIImage
        case .artGallery:
            return DesignSystemKitAsset.icArtGallery24Colored.swiftUIImage
        case .performance:
            return DesignSystemKitAsset.icExperience24Colored.swiftUIImage
        case .etc:
            return DesignSystemKitAsset.icSetting24.swiftUIImage
        }
    }
}
