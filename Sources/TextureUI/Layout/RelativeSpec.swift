//
//  RelativeSpec.swift
//
//
//  Created by Nikita Arutyunov on 22.12.2021.
//

import AsyncDisplayKit

public struct RelativeSpec<Content> where Content: LayoutElement {

    public var layoutElement: ASLayoutElement

    public init(
        horizontalPosition: ASRelativeLayoutSpecPosition = .start,
        verticalPosition: ASRelativeLayoutSpecPosition = .start,
        sizingOption: ASRelativeLayoutSpecSizingOption = [],
        @LayoutSpecBuilder _ content: () -> Content
    ) {
        self.layoutElement = ASRelativeLayoutSpec(
            horizontalPosition: horizontalPosition,
            verticalPosition: verticalPosition,
            sizingOption: sizingOption,
            child: content().layoutElement
        )
    }

    public init(
        content: Content,
        horizontalPosition: ASRelativeLayoutSpecPosition = .start,
        verticalPosition: ASRelativeLayoutSpecPosition = .start,
        sizingOption: ASRelativeLayoutSpecSizingOption = []
    ) {
        self.layoutElement = ASRelativeLayoutSpec(
            horizontalPosition: horizontalPosition,
            verticalPosition: verticalPosition,
            sizingOption: sizingOption,
            child: content.layoutElement
        )
    }
}

extension RelativeSpec: LayoutElement {
    public var node: LazySequence<[ASLayoutElement]> {
        [
            layoutElement
        ]
            .lazy
    }
    
    public var style: ASLayoutElementStyle {
        layoutElement.style
    }
}

extension LayoutElement {
    public func relativePosition(
        horizontal: ASRelativeLayoutSpecPosition,
        vertical: ASRelativeLayoutSpecPosition,
        sizingOption: ASRelativeLayoutSpecSizingOption = []
    ) -> some LayoutElement {
        RelativeSpec(
            content: self,
            horizontalPosition: horizontal,
            verticalPosition: vertical,
            sizingOption: sizingOption
        )
    }
}
