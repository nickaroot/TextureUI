//
//  CornerSpec.swift
//
//
//  Created by Nikita Arutyunov on 22.12.2021.
//

import AsyncDisplayKit

public struct CornerSpec<Content, CornerContent>
where Content: LayoutElement, CornerContent: LayoutElement {

    public let corner: CornerContent
    public let location: ASCornerLayoutLocation

    public let content: Content

    public init(
        corner: CornerContent,
        location: ASCornerLayoutLocation,
        @LayoutSpecBuilder _ content: () -> Content
    ) {
        self.corner = corner
        self.location = location
        self.content = content()
    }

    public init(
        content: Content,
        corner: CornerContent,
        location: ASCornerLayoutLocation
    ) {
        self.corner = corner
        self.location = location
        self.content = content
    }
}

extension CornerSpec: LayoutElement {
    public var node: LazySequence<[ASLayoutElement]> {
        ASCornerLayoutSpec(
            child: content.layoutElement,
            corner: corner.layoutElement,
            location: location
        )
        .node
    }
}
