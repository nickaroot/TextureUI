//
//  CornerSpec.swift
//
//
//  Created by Nikita Arutyunov on 22.12.2021.
//

import AsyncDisplayKit

public struct CornerSpec<Content, CornerContent>
where Content: LayoutElement, CornerContent: LayoutElement {

    public var layoutElement: ASLayoutElement

    public init(
        location: ASCornerLayoutLocation,
        @LayoutSpecBuilder _ corner: () -> CornerContent,
        @LayoutSpecBuilder _ content: () -> Content
    ) {
        self.layoutElement = ASCornerLayoutSpec(
            child: content().layoutElement,
            corner: corner().layoutElement,
            location: location
        )
    }

    public init(
        corner: CornerContent,
        location: ASCornerLayoutLocation,
        @LayoutSpecBuilder _ content: () -> Content
    ) {
        self.layoutElement = ASCornerLayoutSpec(
            child: content().layoutElement,
            corner: corner.layoutElement,
            location: location
        )
    }

    public init(
        content: Content,
        corner: CornerContent,
        location: ASCornerLayoutLocation
    ) {
        self.layoutElement = ASCornerLayoutSpec(
            child: content.layoutElement,
            corner: corner.layoutElement,
            location: location
        )
    }
}

extension CornerSpec: LayoutElement {
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
