# Lesson 1: App Startup and Repository Orientation

## Session goals

### What you will learn

You will learn how Flutter travels from a Dart entry point to the first rendered screen. You will also learn the role of each main project directory.

### What you will build

For this orientation step, you will write a render-path map. You do not need to change production code yet.

### What you should be able to explain afterward

- What `runApp()` does
- The separate responsibilities of `MaterialApp` and `Scaffold`
- Why `BuildContext` differs from Android `Context`

## The current render path

The application starts in [`lib/main.dart`](../lib/main.dart):

```text
main()
└── runApp(const MyApp())
    └── MyApp.build(context)
        └── MaterialApp
            └── home: MyHomePage
                └── _MyHomePageState.build(context)
                    └── Scaffold
                        └── counter UI
```

Flutter follows this sequence:

1. Dart calls `main()`.
2. `main()` passes `MyApp` to `runApp()`.
3. Flutter asks `MyApp` to describe its UI by calling `build()`.
4. `MyApp.build()` returns a `MaterialApp` whose `home` is `MyHomePage`.
5. The state object for `MyHomePage` builds a `Scaffold`, which contains the visible counter screen.

## Core concepts

### `main()`

`main()` is the Dart entry point. Android launches the generated host `Activity`, which initializes the Flutter engine and enters the Dart application.

Android comparison: Android developers often start their own code in `Activity.onCreate()`. Flutter places most application startup and UI code in Dart, while the native host remains under `android/`.

### `runApp()`

`runApp()` attaches the supplied root widget to Flutter's view and starts building the widget tree.

Compose comparison: it resembles establishing the root Compose content. The analogy stops at the rendering boundary because Flutter manages its own widget, element, and render-object trees.

### Widget

A widget is an immutable configuration that describes part of the UI. Flutter can create new widget objects during rebuilds because longer-lived element objects retain each widget's position in the tree.

Android comparison: a Flutter widget does not have the same identity or lifetime as an Android `View`. A widget resembles a UI description more than a mutable view instance.

### `StatelessWidget`

`MyApp` extends `StatelessWidget` because the widget itself owns no mutable state. Its `build()` method returns the application configuration.

Compose comparison: it resembles a composable whose output depends on inputs and inherited state. Flutter still represents the declaration as a widget object before mounting it into the element tree.

### `MaterialApp`

`MaterialApp` configures app-wide Material behavior. It provides:

- theme configuration
- navigation infrastructure
- localization and text-direction defaults
- the initial screen through `home`

The current [`MyApp`](../lib/main.dart) supplies a title and a home screen:

```dart
title: 'Sunnah LifeStyle',
home: const MyHomePage(title: 'Flutter Demo Home Page'),
```

The app does not supply `theme` or `darkTheme`. `MaterialApp` therefore uses `ThemeData.light()` as its default theme. Widgets can still call `Theme.of(context)` because `MaterialApp` places that default theme above the home screen in the tree.

Android comparison: `MaterialApp` combines responsibilities that Android may divide among an application theme, navigation setup, and root Compose configuration. No single Android class matches it.

### `Scaffold`

`Scaffold` provides the standard structure for one Material screen. It can coordinate a body, app bar, floating action button, bottom navigation, drawer, and snack bars.

Android comparison: it resembles a screen-level Compose layout that coordinates a top bar, content, FAB, and navigation bar. It does not represent an `Activity` or `Fragment`.

### `BuildContext`

`BuildContext` identifies a widget's location in the element tree. Flutter uses that location to find ancestors such as:

- `Theme`
- `Navigator`
- `MediaQuery`
- inherited state

For example, `Theme.of(context)` walks from that location toward the root until it finds the nearest theme data.

Android comparison: Android `Context` gives access to resources, services, and application or component state. Flutter `BuildContext` acts as a tree-position handle. Treating the two as equivalent causes incorrect assumptions about lifetime and access.

### `SafeArea`

`SafeArea` adds padding where system UI could cover content, such as status bars, display cutouts, and gesture areas.

Compose comparison: its purpose resembles applying safe drawing or window inset padding. Flutter calculates the padding from `MediaQuery` data available above the widget.

## Repository map

### `pubspec.yaml`

[`pubspec.yaml`](../pubspec.yaml) is the Dart and Flutter package manifest. It defines:

- project metadata and SDK constraints
- dependencies and development dependencies
- Flutter assets and fonts

Android comparison: it overlaps with parts of a Gradle build file, but Gradle still configures the native Android host under `android/`.

### `lib/`

`lib/` contains the Dart application source. Flutter compiles the code from this directory into the application.

### `lib/main.dart`

[`lib/main.dart`](../lib/main.dart) contains the Dart entry point and the current root widget.

### `android/`

`android/` contains the native Android host, Gradle configuration, manifest, resources, and `MainActivity`. You will return to this directory when a Flutter plugin requires Android permissions or platform configuration.

### `ios/`

`ios/` contains the native iOS host, Xcode project, property lists, resources, and application delegate.

### `test/`

`test/` contains Dart and Flutter tests. The current [`test/widget_test.dart`](../test/widget_test.dart) still tests the generated counter behavior.

### `helper/`

`helper/` contains the Sunnah Lifestyle design and project guide. Flutter does not package these files as application assets because `pubspec.yaml` does not declare them under `flutter.assets`.

### Generated directories

`.dart_tool/` and `build/` contain generated tool and build output. You should not place application source in them.

## Revision summary

- Flutter enters your Dart code through `main()`.
- `runApp()` mounts the root widget and begins the first build.
- `MaterialApp` configures app-wide Material behavior.
- `Scaffold` structures one Material screen.
- Widgets describe UI as immutable configuration objects.
- `BuildContext` identifies a position in the Flutter tree.
- Platform folders host the Flutter application and contain native configuration.

## Your task

Without editing code, write your own five-step explanation of how the current app reaches the visible counter screen.

## Done when

- Your trace begins at `main()`.
- It identifies both relevant `build()` methods.
- It distinguishes `MaterialApp` from `Scaffold`.
- It explains why `Theme.of(context)` works when the app does not supply a custom theme.
- It describes `BuildContext` without equating it to Android `Context`.

## Interview check

1. What would still work if you removed `Scaffold` but kept `MaterialApp`?
2. Why can Flutter recreate widget objects during rebuilds without losing all UI state?
3. Why must `Theme.of(context)` receive a context below the relevant `MaterialApp`?
