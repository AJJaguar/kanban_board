# Innoscripta Flutter Technical Test Task

![coverage][coverage_badge]
[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![License: MIT][license_badge]][license_link]

---

https://user-images.githubusercontent.com/90194561/214649042-72b10bee-4c4e-42ea-9194-0121b8ddba32.mov




## Getting Started ๐

The project was optimized to run on an ipad in landscape mode
To run the project either use the launch configuration in VSCode/Android Studio or use the following commands:

```sh
$ flutter run 
```

_\*Innoscripta works on iOS, Android, Web, and Windows._

---

## Folder Structure
```
โ
โโโ feature
|     โโโ data
โ     โ     โโโ data source
โ     โ     โโโ model
โ     โ     โโโ repository(implementation)
โ     โโโ domain     
โ     โ     โโโ entities
โ     โ     โโโ repository(abstract)
โ     โ     โโโ usecases
โ     โโโ presentation
โ     โ     โโโ bloc
โ     โ     โโโ pages
โ     โ     โโโ widgets
โ     โ        
```

## Running Tests ๐งช

To run all unit and widget tests use the following command:

```sh
$ flutter test 
```

To view the generated coverage report you can use [lcov](https://github.com/linux-test-project/lcov).

```sh
# Generate Coverage Report
$ genhtml coverage/lcov.info -o coverage/

# Open Coverage Report
$ open coverage/index.html
```

---

## Working with Translations ๐

This project relies on [flutter_localizations][flutter_localizations_link] and follows the [official internationalization guide for Flutter][internationalization_link].

### Adding Strings

1. To add a new localizable string, open the `app_en.arb` file at `lib/l10n/arb/app_en.arb`.

```arb
{
    "@@locale": "en",
    "counterAppBarTitle": "Counter",
    "@counterAppBarTitle": {
        "description": "Text shown in the AppBar of the Counter Page"
    }
}
```

2. Then add a new key/value and description

```arb
{
    "@@locale": "en",
    "counterAppBarTitle": "Counter",
    "@counterAppBarTitle": {
        "description": "Text shown in the AppBar of the Counter Page"
    },
    "helloWorld": "Hello World",
    "@helloWorld": {
        "description": "Hello World Text"
    }
}
```

3. Use the new string

```dart
import 'package:innoscipta_takehome/l10n/l10n.dart';

@override
Widget build(BuildContext context) {
  final l10n = context.l10n;
  return Text(l10n.helloWorld);
}
```

### Adding Supported Locales

Update the `CFBundleLocalizations` array in the `Info.plist` at `ios/Runner/Info.plist` to include the new locale.

```xml
    ...

    <key>CFBundleLocalizations</key>
	<array>
		<string>en</string>
		<string>de</string>
	</array>

    ...
```

### Adding Translations

1. For each supported locale, add a new ARB file in `lib/l10n/arb`.

```
โโโ lib
|     โโโ l10n
โ     โ     
โ     โ     โโโ app_en.arb
โ     โ     โโโ app_es.arb
```

2. Add the translated strings to each `.arb` file:

`app_en.arb`

```arb
{
    "@@locale": "en",
    "email": "Email",
    "@email": {
        "description": "email"
    },
}
```

`app_de.arb`

```arb
{
    "@@locale": "de",
    "email": "E-mail",
    "@email": {
        "description": "email"
    },
}
```
