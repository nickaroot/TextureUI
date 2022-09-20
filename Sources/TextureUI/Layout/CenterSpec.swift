//
//  CenterSpec.swift
//
//
//  Created by Nikita Arutyunov on 22.12.2021.
//

import AsyncDisplayKit

public struct CenterSpec<Content> where Content: LayoutElement {

    public let centeringOptions: ASCenterLayoutSpecCenteringOptions
    public let sizingOptions: ASCenterLayoutSpecSizingOptions

    public let content: Content

    public init(
        centeringOptions: ASCenterLayoutSpecCenteringOptions = .XY,
        sizingOptions: ASCenterLayoutSpecSizingOptions = [],
        @LayoutSpecBuilder _ content: () -> Content
    ) {
        self.centeringOptions = centeringOptions
        self.sizingOptions = sizingOptions
        self.content = content()
    }

    public init(
        content: Content,
        centeringOptions: ASCenterLayoutSpecCenteringOptions = .XY,
        sizingOptions: ASCenterLayoutSpecSizingOptions = []
    ) {
        self.centeringOptions = centeringOptions
        self.sizingOptions = sizingOptions
        self.content = content
    }
}

extension CenterSpec: LayoutElement {
    public var node: LazySequence<[ASLayoutElement]> {
        ASCenterLayoutSpec(
            centeringOptions: centeringOptions,
            sizingOptions: sizingOptions,
            child: content.layoutElement
        )
        .node
    }
    
    public var layoutElement: ASLayoutElement {
        node.first ?? ASLayoutSpec()
    }
    
    public var style: ASLayoutElementStyle {
        layoutElement.style
    }
}
