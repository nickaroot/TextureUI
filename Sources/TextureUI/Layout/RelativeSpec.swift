//
//  RelativeSpec.swift
//
//
//  Created by Nikita Arutyunov on 22.12.2021.
//

import AsyncDisplayKit

public struct RelativeSpec<Content> where Content: LayoutElement {

    public let horizontalPosition: ASRelativeLayoutSpecPosition
    public let verticalPosition: ASRelativeLayoutSpecPosition
    public let sizingOption: ASRelativeLayoutSpecSizingOption

    public let content: Content

    public init(
        horizontalPosition: ASRelativeLayoutSpecPosition = .start,
        verticalPosition: ASRelativeLayoutSpecPosition = .start,
        sizingOption: ASRelativeLayoutSpecSizingOption = .minimumSize,
        @LayoutSpecBuilder _ content: () -> Content
    ) {
        self.horizontalPosition = horizontalPosition
        self.verticalPosition = verticalPosition
        self.sizingOption = sizingOption
        self.content = content()
    }

    public init(
        content: Content,
        horizontalPosition: ASRelativeLayoutSpecPosition = .start,
        verticalPosition: ASRelativeLayoutSpecPosition = .start,
        sizingOption: ASRelativeLayoutSpecSizingOption = .minimumSize
    ) {
        self.horizontalPosition = horizontalPosition
        self.verticalPosition = verticalPosition
        self.sizingOption = sizingOption
        self.content = content
    }
}

extension RelativeSpec: LayoutElement {
    public var node: LazySequence<[ASLayoutElement]> {
        ASRelativeLayoutSpec(
            horizontalPosition: horizontalPosition,
            verticalPosition: verticalPosition,
            sizingOption: sizingOption,
            child: content.layoutElement
        )
        .node
    }
}
