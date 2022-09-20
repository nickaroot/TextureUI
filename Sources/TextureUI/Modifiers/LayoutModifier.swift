//
//  LayoutModifier.swift
//
//
//  Created by Nikita Arutyunov on 22.12.2021.
//

import Foundation

public protocol LayoutModifier {
    associatedtype Content: LayoutElement

    func modify(content: Content) -> LayoutElement
}
