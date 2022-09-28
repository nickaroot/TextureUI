//
//  OverlaySpec.swift
//
//
//  Created by Nikita Arutyunov on 22.12.2021.
//

import AsyncDisplayKit

public struct OverlaySpec<Content, OverlayContent>
where Content: LayoutElement, OverlayContent: LayoutElement {

    public let overlay: OverlayContent

    public let content: Content
    
    public init(
        @LayoutSpecBuilder _ overlay: () -> OverlayContent,
        @LayoutSpecBuilder _ content: () -> Content
    ) {
        self.overlay = overlay()
        self.content = content()
    }

    public init(
        overlay: OverlayContent,
        @LayoutSpecBuilder _ content: () -> Content
    ) {
        self.overlay = overlay
        self.content = content()
    }

    public init(
        content: Content,
        overlay: OverlayContent
    ) {
        self.overlay = overlay
        self.content = content
    }
}

extension OverlaySpec: LayoutElement {
    public var node: LazySequence<[ASLayoutElement]> {
        ASOverlayLayoutSpec(child: content.layoutElement, overlay: overlay.layoutElement)
            .node
    }
    
    public var layoutElement: ASLayoutElement {
        node.first ?? ASLayoutSpec()
    }
    
    public var style: ASLayoutElementStyle {
        layoutElement.style
    }
}
