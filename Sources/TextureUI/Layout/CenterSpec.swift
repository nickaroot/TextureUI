//
//  CenterSpec.swift
//
//
//  Created by Nikita Arutyunov on 22.12.2021.
//

import AsyncDisplayKit

public struct CenterSpec<Content> where Content: LayoutElement {

    public var layoutElement: ASLayoutElement

    public init(
        centeringOptions: ASCenterLayoutSpecCenteringOptions = .XY,
        sizingOptions: ASCenterLayoutSpecSizingOptions = [],
        @LayoutSpecBuilder _ content: () -> Content
    ) {
        self.layoutElement = ASCenterLayoutSpec(
            centeringOptions: centeringOptions,
            sizingOptions: sizingOptions,
            child: content().layoutElement
        )
    }

    public init(
        content: Content,
        centeringOptions: ASCenterLayoutSpecCenteringOptions = .XY,
        sizingOptions: ASCenterLayoutSpecSizingOptions = []
    ) {
        self.layoutElement = ASCenterLayoutSpec(
            centeringOptions: centeringOptions,
            sizingOptions: sizingOptions,
            child: content.layoutElement
        )
    }
}

extension CenterSpec: LayoutElement {
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
