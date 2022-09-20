//
//  AspectRatioModifier.swift
//
//
//  Created by Nikita Arutyunov on 22.12.2021.
//

import Foundation

public struct AspectRatioModifier<Content>: LayoutSpecModifier where Content: LayoutElement {

    public let ratio: CGFloat

    public init(
        ratio: CGFloat
    ) {
        self.ratio = ratio
    }

    public func modify(content: Content) -> LayoutElement {
        AspectRatioSpec(content: content, ratio: ratio)
    }
}

extension LayoutElement {
    public func aspectRatio(_ ratio: CGFloat) -> some LayoutElement {
        modifier(AspectRatioModifier<Self>(ratio: ratio))
    }
}
