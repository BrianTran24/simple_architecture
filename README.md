After run scrip.
You have to manual run
  - firebase config to configs project 
    ```
       flutterfire configure
    ```
 - Link ChPlayStore và AppleStore (AppConfig)
 - Điều chỉnh step inter Ad nếu cần. (AdConfig)
 - Cần update logo là chạy lại lệnh gen logo: 
    /// assets/images/logo/logo.png
    ```
       flutter pub run flutter_launcher_icons:main
    ```
 - manual setup fonts: 
 - setup các gói business