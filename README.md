## Tổng quan
- Flutter Codebase dựa trên Clean Architechture , bổ sung các thành phần cần thiết để khởi động 1 dự án.
- Tuân thủ SOLID, Dependencies Injection.
- Sử dụng Bloc Cubit ( có thể thay thế bằng các State management khác ).
- Hỗ trợ gọi API thông qua Dio
- Tách nhỏ feature nhằm tái sử dụng code trong cái dự án khác có tính lặp lại chức năng
## Kiến trúc
```sh
└── flutter_codebase_clean/
    ├── Makefile
    ├── README.md
    ├── analysis_options.yaml
    ├── android
    │   ├── .gitignore
    │   ├── app
    │   ├── build.gradle
    │   ├── gradle
    │   ├── gradle.properties
    │   └── settings.gradle
    ├── assets
    │   └── localizations
    ├── ios
    │   ├── .gitignore
    │   ├── Flutter
    │   ├── Runner
    │   ├── Runner.xcodeproj
    │   ├── Runner.xcworkspace
    │   └── RunnerTests
    ├── lib
    │   ├── app.dart
    │   ├── core
    │   ├── features
    │   ├── flavors.dart
    │   ├── injection_container.dart
    │   ├── main.dart
    │   └── start.dart
    ├── linux
    │   ├── .gitignore
    │   ├── CMakeLists.txt
    │   ├── flutter
    │   ├── main.cc
    │   ├── my_application.cc
    │   └── my_application.h
    ├── macos
    │   ├── .gitignore
    │   ├── Flutter
    │   ├── Runner
    │   ├── Runner.xcodeproj
    │   ├── Runner.xcworkspace
    │   └── RunnerTests
    ├── pubspec.yaml
    ├── web
    │   ├── favicon.png
    │   ├── icons
    │   ├── index.html
    │   └── manifest.json
    └── windows
        ├── .gitignore
        ├── CMakeLists.txt
        ├── flutter
        └── runner
```
## Sử dụng
- Sử dụng git để clone source code hoặc tải trực tiếp
- Sử dụng các câu lệnh trong makefile để hỗ trợ generate hay get nhanh hơn thay vì phải gõ lệnh
## Duy trì
- Sắp tới sẽ hoàn thiện SDK nhằm generate codebase và feature 1 cách tự động
