//
//  RelativeModifier.swift
//
//
//  Created by Nikita Arutyunov on 22.12.2021.
//

import AsyncDisplayKit

public struct RelativeModifier<Content>: LayoutSpecModifier where Content: LayoutElement {

    public let horizontal: ASRelativeLayoutSpecPosition
    public let vertical: ASRelativeLayoutSpecPosition
    public let sizingOption: ASRelativeLayoutSpecSizingOption

    public init(
        horizontal: ASRelativeLayoutSpecPosition,
        vertical: ASRelativeLayoutSpecPosition,
        sizingOption: ASRelativeLayoutSpecSizingOption
    ) {
        self.horizontal = horizontal
        self.vertical = vertical
        self.sizingOption = sizingOption
    }

    public func modify(content: Content) -> LayoutElement {
        RelativeSpec(
            content: content,
            horizontalPosition: horizontal,
            verticalPosition: vertical,
            sizingOption: sizingOption
        )
    }
}

extension LayoutElement {
    public func relativePosition(
        horizontal: ASRelativeLayoutSpecPosition,
        vertical: ASRelativeLayoutSpecPosition,
        sizingOption: ASRelativeLayoutSpecSizingOption = []
    ) -> some LayoutElement {
        modifier(
            RelativeModifier<Self>(
                horizontal: horizontal,
                vertical: vertical,
                sizingOption: sizingOption
            )
        )
    }
}
