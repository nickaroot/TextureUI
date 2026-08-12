# Changelog

## Unreleased

### Behavioral changes

These change rendered layout without any API change, so a compiler will not flag call sites.
Consumers should review usage before adopting.

- **Block/builder forms now preserve the direct child's style.** `ZStack {}`, `OverlaySpec(){}`,
  `BackgroundSpec(){}`, and the block forms of `CenterSpec`/`AspectRatioSpec`/`CornerSpec`/
  `RelativeSpec`/`InsetSpec(insets:){}` used to reset the direct child's `ASLayoutElementStyle`
  to defaults. They now preserve it, matching `HStack`/`VStack` and the modifier forms
  (`.background(_)`, `.overlay(_)`, `.padding(_)`, `.aspectRatio(_)`). A style modifier chained on a
  direct child inside such a block (e.g. `.preferredLayoutSize`, `.minLayoutHeight`, `.flexGrow`) now
  takes effect instead of being silently dropped. This also applies to the decoration slots
  (`overlay:` / `background:` / `corner:`).

- **`nil` optionals no longer leave a phantom stack child.** A `nil`-`Optional` carrying a modifier
  inside a stack, or a `nil` embedded in an array used as stack content, previously became a
  zero-size placeholder that added one extra `spacing` gap. Such `nil`s now drop cleanly, so a stack
  with a `nil` slot loses one spacing gap. `Array` content is now flattened via each element's `node`
  (consistent with composite): an element that itself expands to multiple nodes contributes multiple
  stack children rather than one implicitly grouped child.

### Removed (source-breaking)

- `StackLayoutProtocol` and `StyleableLayout` (both `public`) were unused (zero conformers) and are
  removed. External code that referenced them will not compile.

### Internal

- `Layout.layoutElement` no longer copies the always-default `Layout`-level style onto the produced
  element in any case (`.single`/`.composite`/`.empty`), matching `Layout.node`. This removes a load-
  bearing ordering dependency in the former per-case style copy.
- `InsetSpec` block-form initializer evaluates its `@LayoutSpecBuilder` closure once (was twice) and
  drops an unreachable nested-inset merge branch.

### Tests

- Added `CharacterizationTests` (run on the iOS simulator) locking the two behavioral changes and
  characterizing the remaining known-but-unfixed behaviors (style leak across passes, deferred
  modifier side-effect, innermost-wins on duplicate modifiers, array-style-modifier no-op,
  parameterless `.padding()` = zero insets) so a future change to any of them trips a test.
