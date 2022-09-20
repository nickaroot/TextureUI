//
//  LayoutSpec.swift
//
//
//  Created by Nikita Arutyunov on 22.12.2021.
//

import AsyncDisplayKit

public class LayoutSpec<Content>: ASWrapperLayoutSpec where Content: LayoutElement {
    public init(
        @LayoutSpecBuilder _ content: () -> Content
    ) {
        super.init(layoutElements: content().node.elements)
    }
}

public final class AnyLayoutSpec: ASWrapperLayoutSpec {
    public init<Content: LayoutElement>(
        @LayoutSpecBuilder _ content: () -> Content
    ) {
        super.init(layoutElements: content().node.elements)
    }
}
