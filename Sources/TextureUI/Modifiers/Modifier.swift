//
//  Modifier.swift
//
//
//  Created by Nikita Arutyunov on 22.12.2021.
//

import Foundation

public struct Modifier<Content>: LayoutModifier where Content: LayoutElement {
    public init() {}

    public func modify(content: Content) -> LayoutElement { content }
}
