//
//  FlexGrowModifier.swift
//
//
//  Created by Nikita Arutyunov on 22.12.2021.
//

import Foundation

public struct FlexGrowModifier<Content>: LayoutModifier where Content: LayoutElement {

    public let flexGrow: CGFloat

    public init(
        flexGrow: CGFloat
    ) {
        self.flexGrow = flexGrow
    }

    public func modify(content: Content) -> LayoutElement {
        content.style.flexGrow = flexGrow

        return content
    }
}

extension LayoutElement {
    public func flexGrow(_ value: CGFloat) -> some LayoutElement {
        modifier(FlexGrowModifier<Self>(flexGrow: value))
    }
}
