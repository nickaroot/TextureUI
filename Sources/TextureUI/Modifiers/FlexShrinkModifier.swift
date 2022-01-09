//
//  FlexShrinkModifier.swift
//
//
//  Created by Nikita Arutyunov on 22.12.2021.
//

import Foundation

public struct FlexShrinkModifier<Content>: LayoutModifier where Content: LayoutElement {

    public let flexShrink: CGFloat

    public init(
        flexShrink: CGFloat
    ) {
        self.flexShrink = flexShrink
    }

    public func modify(content: Content) -> LayoutElement {
        content.style.flexShrink = flexShrink

        return content
    }
}

extension LayoutElement {
    public func flexShrink(_ value: CGFloat) -> some LayoutElement {
        modifier(FlexShrinkModifier<Self>(flexShrink: value))
    }
}
