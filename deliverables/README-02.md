# LGBT YouthLine/Rainbow Warriors

## Description 
LGBT youthline provides various supporting resources and events information on their website. However, their website is only compatible with PC. It is a hard time if user want to access the website on a mobilephone. Our app is able to display the resources and events on a mobilephone in a friendly way by reorganizing the layout, adding bookmark feature, adding search feature.

## Key Features
### Home Page:
In the Home Page, user can view the upcoming events (maybe not the latest events) and decide whether they want to attend. By pressing the each event, user can see the detail of the event. They can also view the latest posts on Instagram, Facebook, Twitter in our app. The search function is also available on the home page if they want to search for a specific resource or event.

### Resources Page:
In this page, user are able to browse all the helping resources provided by LGBT youthline in a mobilephone friendly way. If user know what their looking for, they can search the resource by key words. Also, user can mark some resources as "like", so they can save it to their phone and read them later.

### Event Page:
In the event page, user can see all the events (both the upcoming ones and the past ones). By pressing the each event, user can see the detail of the event.

### Me Page:
This page authenticate user using Firebase. User requires to registered using email. If the email does not in databse,it
will ask user to creat a new account then log in. After logging in, user is enable to see their unique user id and log
in email in the dashboard. In addition, user can log out using log out button.

### Back-end:
See README.md file in BackEnd folder.
## Instructions
 * If we try to deploy our application in AppStroe, we need to have Apple developer membership, which will cost
 119 CAD per year. We cannot reach our partner for several weeks. At this situation, we cannot use AppStore to do universal
 deploy, we can only use Xcode to deploy in developer environment.
 # Option1:
* Step 1: Clone the project repo to a Mac computer.
* Step 2: Download Xcode.
* Step 3: Open terminal, type the following command to install the CocoaPods lib using by our app.
> gem install cocoapods
* Step 4: cd the terminal to the "YourthLine" directory under the git repo directory.
* Step 5: type the following command to install the CocoaPods lib under "YourthLine" directory, the main project directory.
> pod install
* Step 6: Double clicks "YouthLine.xcworkspace" under the "YourthLine" directory.
* Step 7: In the Xcode window, press "Command" + "," to open preference menu, go to "Component" tab, download the iOS 12 Simulator.
* Step 8: Click the "Run" buttom at the top left corner of Xcode. Now the code should compile and simulator will pop-up after the compilation success.
* Final Step: Now you can explore the app with mouse.
# Option2:
*Our team can provide a iphone which deploy the App to demonstrate each function
