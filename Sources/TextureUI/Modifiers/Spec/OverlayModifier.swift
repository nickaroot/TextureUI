//
//  OverlayModifier.swift
//
//
//  Created by Nikita Arutyunov on 22.12.2021.
//

import Foundation

public struct OverlayModifier<Content, Overlay>: LayoutSpecModifier
where Content: LayoutElement, Overlay: LayoutElement {

    public let overlay: Overlay?

    public init(
        overlay: Overlay?
    ) {
        self.overlay = overlay
    }

    public func modify(content: Content) -> LayoutElement {
        overlay.map { OverlaySpec(content: content, overlay: $0) } ?? content
    }
}

extension LayoutElement {
    public func overlay<Overlay>(_ overlay: Overlay?) -> some LayoutElement
    where Overlay: LayoutElement {
        modifier(OverlayModifier<Self, Overlay>(overlay: overlay))
    }
}
