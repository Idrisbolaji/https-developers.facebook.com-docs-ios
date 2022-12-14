/*
 * Copyright (c) Meta Platforms, Inc. and affiliates.
 * All rights reserved.
 *
 * This source code is licensed under the license found in the
 * LICENSE file in the root directory of this source tree.
 */

@testable import FBSDKCoreKit

import XCTest

final class DrawableTests: XCTestCase {
  let size = CGSize(width: 100, height: 100)
  let placeholderImageColor = UIColor(
    red: 157.0 / 255.0,
    green: 177.0 / 255.0,
    blue: 204.0 / 255.0,
    alpha: 1.0
  )

  func testBaseClassPathWithSize() {
    XCTAssertNil(FBIcon().path(with: size))
  }

  func testDefaultScale() {
    XCTAssertEqual(
      _HumanSilhouetteIcon().image(size: size)?.scale,
      UIScreen.main.scale,
      "Icons should default their scale to the scale of the main screen"
    )
  }

  func testDefaultScaleWithColor() {
    XCTAssertEqual(
      _HumanSilhouetteIcon().image(size: size, color: .red)?.scale,
      UIScreen.main.scale,
      "Scale should not be affected by the color"
    )
  }

  func testCustomScale() {
    XCTAssertEqual(
      _HumanSilhouetteIcon().image(
        size: size,
        scale: 2.0
      )?.scale,
      2.0,
      "Icons should accept a custom scale"
    )
  }

  func testSystemColor() throws {
    try XCTSkipIf(
      true,
      "This test is being skipped due to changes in Xcode 14.1 that produce new and different PNG data"
    )

    let potentialImage = _HumanSilhouetteIcon().image(
      size: size,
      scale: 2.0,
      color: .red
    )

    guard let image = potentialImage else {
      return XCTFail("Should be able to create an image with a valid size")
    }

    let redIcon = UIImage(
      named: "redSilhouette.png",
      in: Bundle(for: Self.self),
      compatibleWith: nil
    )

    XCTAssertEqual(
      image.pngData(),
      redIcon?.pngData(),
      "Should create the expected image for the size and color"
    )
  }

  // MARK: Human Silhouette Icon

  func testImageWithInvalidSize() {
    XCTAssertNil(_HumanSilhouetteIcon().image(size: .zero), "An image must have a non-zero size")
  }

  func testPlaceholderImageColor() throws {
    try XCTSkipIf(
      true,
      "This test is being skipped due to changes in Xcode 14.1 that produce new and different PNG data"
    )

    let potentialImage = _HumanSilhouetteIcon().image(
      size: size,
      scale: 2.0,
      color: placeholderImageColor
    )
    let customIcon = UIImage(
      named: "customColorSilhouette.png",
      in: Bundle(for: Self.self),
      compatibleWith: nil
    )

    guard let image = potentialImage else {
      return XCTFail("Should be able to create an image with a valid size")
    }

    XCTAssertEqual(
      image.pngData(),
      customIcon?.pngData(),
      "Should create the expected image for the size and color"
    )
  }

  // MARK: Logo Icon

  func testLogo() throws {
    try XCTSkipIf(
      true,
      "This test is being skipped due to changes in Xcode 14.1 that produce new and different PNG data"
    )

    let potentialImage = _FBLogo().image(
      size: size,
      scale: 2.0,
      color: .red
    )
    let storedImage = UIImage(
      named: "redLogo.png",
      in: Bundle(for: Self.self),
      compatibleWith: nil
    )

    guard let image = potentialImage else {
      return XCTFail("Should be able to create an image with a valid size")
    }

    XCTAssertEqual(
      image.pngData(),
      storedImage?.pngData(),
      "Should create the expected image"
    )
  }

  // MARK: Close Icon

  func testCloseIcon() throws {
    try XCTSkipIf(
      true,
      "This test is being skipped due to changes in Xcode 14.1 that produce new and different PNG data"
    )

    guard let image = _FBCloseIcon().image(
      size: size,
      primaryColor: .red,
      secondaryColor: .green,
      scale: 2.0
    ) else {
      return XCTFail("Should be able to create an image with a valid size")
    }

    let storedImage = UIImage(
      named: "closeIcon.png",
      in: Bundle(for: Self.self),
      compatibleWith: nil
    )

    XCTAssertEqual(
      image.pngData(),
      storedImage?.pngData(),
      "Should create the expected image"
    )
  }
}
