# Flutter Alarm App

A flutter alarm app created in Flutter using BloC.

Demo:
https://drive.google.com/file/d/1qRnWlJZOBHGTgD7MWBPAklwOAyg8CpyX/view?usp=sharing

## How to Use

**Step 1:**

Download or clone this repo by using the link below:

```
https://github.com/willwees/flutter_alarm_app.git
```

**Step 2:**

Go to project root and execute the following command in console to get the required dependencies:

```
flutter pub get 
```

### Libraries & Tools Used

* [Flutter Bloc](https://pub.dev/packages/flutter_bloc) (State Management)
* [Flutter Local Notification](https://pub.dev/packages/flutter_local_notifications)
* [Flutter ScreenUtil](https://pub.dev/packages/flutter_screenutil)
* [Intl](https://pub.dev/packages/intl)
* [Timezone](https://pub.dev/packages/timezone)
* [Equatable](https://pub.dev/packages/equatable)
* [Lint](https://pub.dev/packages/lint)

### Folder Structure
Here is the core folder structure which flutter provides.

```
flutter_alarm_app/
|- android
|- build
|- ios
|- lib
|- test
```

Here is the folder structure used in this project

```
lib/
|- src/
  |- blocs/
  |- constants/
  |- models/
  |- screens/
  |- utils/
  |- widgets/
  |- app.dart
|- main.dart
```

Now, lets dive into the lib/src folder which has the main code for the application.

```
1- blocs - Contains store(s) for state-management of the app.
2- constants - All the application level constants are defined in this directory with-in their respective files.
3- models - Contains class objects. 
4- screens — Contains all the UI of the app.
5- utils — Contains the utilities/common functions for the app.
6- widgets — Contains the common widgets for the app.
7- app.dart - All the application level configurations are defined in this file i.e, theme, routes, title etc.
8- main.dart - This is the starting point of the app.
```

