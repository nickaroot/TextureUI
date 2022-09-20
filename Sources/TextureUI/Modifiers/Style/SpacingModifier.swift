//
//  SpacingModifier.swift
//
//
//  Created by Nikita Arutyunov on 22.12.2021.
//

import Foundation

public struct SpacingModifier<Content>: LayoutStyleModifier where Content: LayoutElement {

    public let spacingAfter: CGFloat?
    public let spacingBefore: CGFloat?

    public init(
        after: CGFloat? = nil,
        before: CGFloat? = nil
    ) {
        self.spacingAfter = after
        self.spacingBefore = before
    }

    public func modify(content: Content) -> LayoutElement {
        spacingAfter.map { content.style.spacingAfter = $0 }
        spacingBefore.map { content.style.spacingBefore = $0 }

        return content
    }
}

extension LayoutElement {
    public func spacingAfter(_ value: CGFloat) -> some LayoutElement {
        modifier(SpacingModifier<Self>(after: value))
    }
    public func spacingBefore(_ value: CGFloat) -> some LayoutElement {
        modifier(SpacingModifier<Self>(before: value))
    }
}
