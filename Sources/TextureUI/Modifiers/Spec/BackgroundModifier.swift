//
//  BackgroundModifier.swift
//
//
//  Created by Nikita Arutyunov on 22.12.2021.
//

import Foundation

public struct BackgroundModifier<Content, Background>: LayoutSpecModifier
where Content: LayoutElement, Background: LayoutElement {

    public let background: Background?

    public init(
        background: Background?
    ) {
        self.background = background
    }

    public func modify(content: Content) -> LayoutElement {
        background.map { BackgroundSpec(content: content, background: $0) } ?? content
    }
}

extension LayoutElement {
    public func background<Background>(_ background: Background?) -> some LayoutElement
    where Background: LayoutElement {
        modifier(BackgroundModifier<Self, Background>(background: background))
    }
}
