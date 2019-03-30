# LGBT YouthLine/Rainbow Warriors


### Q1: What are you planning to build?

We are planning to build a mobile app that connects to Youthline.ca and provides online services to 2SLGBTQ people.

Youthline.ca is a website that contains information about ongoing events in the 2SLGBTQ community of Ontario. This website also serves the chatting function for people in seek of help when they’re in unstable mental condition. For any group or organization that aims to help 2SLGBTQ people, they could upload their location onto the website.

According to the requirements from our project partner, we’re building this mobile app version of Youthline.ca in order to:
  * Retrieve data stored in Youthline.ca, including events, news, and all other resources
  * Help users find and mark their favorite events/news/resources
  * Use all existing functions provided on the website (eg. chatting function)

That means, our users should be able to use our app to read all news, resources, and events posted on Youthline.ca. When he finds any interesting news/event/resources, he can mark it as a favorite and save it in his reading list. As our mobile inherits the Youthline website, the user can also use the function of the website, such as asking for help (online chatting) when he is in trouble. Our users might be asked to log in/ sign up when they’re trying to achieve certain tasks. 



### Q2: Who are your target users?

Our target users are all people under 29 and considered to be in 2SLGBTQ community in Ontario, and organizations or groups in this region that aim to provide help to this community. 

To be specific, 2SLGBTQ is short for Lesbian, Gay, Bisexual, Transgender, Queer and Two-spirited people. In other words, they could be any person who cannot find a sense of belonging, worry about coming out and have confusions with their gender identity or want to participate in some events held/managed by LGBT youth line. People in this group usually think highly of privacy, and they might usually come across situations where they need support and guidance from experts.



### Q3: Why would your users choose your product? What are they using today to solve their problem/need?

As we’re building a mobile version of a the YouthLine website, all former visitors and users of Youthline.ca can enjoy a better user interface of this website by using our app. All data and information will be presented in a clear and organized way and could be accessed directly by clicking on the icon on the phone (don’t have to access via browser anymore). 

Since our target users are minority groups, they may lack helpful information. Fortunately, youthline.ca is an organization who collects a significant amount of resources provided freely for these people. Our app connects their demand and supply together. We provide bookmark and save to local feature which can allow the user to save their favorite articles, websites or other helpful resources to their phone. So, the user can make use of fragmented time to read those resources even there is no Internet access.  

In addition, mobile phone as a very personal device, by using an app on a mobile phone we provide more privacy protection. It is often more private of using apps on a personal cell phone than using a computer, especially when the computer is public. It protects our users’ privacy, which most of them think highly of, by keeping user information in cell phones.



### Q4: How will you build it?

**Languages**: Swift/Object-C  
**Frameworks**: Flutter  
**Libraries**: AFNetworking (Object-C), SDWebImage, Alamo fire, MBProgressHUD/SVProgressHUD, Masonry, Swifty JSON, MJ Refresh, CocoaLumberjack, Realm  
**Toolkit**:  XCode - iOS  
**SDK**: iOS SDK  
**Database**: SQLite  

**Deployment**: 
For early test purpose, we will use a VPS (digital ocean) as our back-end server, then we will use apple developer certificate to deploy software on our own phone to test feature and stability. For final deployment, we will use a slightly better VPS as our server (which can be upgraded easily) and we will release our app to the Apple App Store as a free app.

**Architecture**:
We will be using MVVM-C architecture for our product. We will be using multiple view-models, one for each view (eg, view for the event and favorite page), and a coordinator in charge of dealing with transitioning from a view to another. Currently, we will be using google map API. A diagram can be referred to the following:

![https://lh5.googleusercontent.com/r7OTp1_7hOvnBIhDYYzXqFwhzxabfPmMPi8GoHkoD82TpioOQAu6bmMprbyFKEIkA2YKvZZQsqB_gVeYuvvdzWIxJv9VbobPaKt88Ll120fujPHf-D4y1Q3o79_OvJslkYlBAA1F](https://lh6.googleusercontent.com/MIgj8fic3PyBfef4uUWh56nJVxhNwrLfwgaN6gGEx-yj7zgUBi5i90NYxYTya2gCrTnb7UYZqMVTCbAZbESsmiTf6qKQREbbl8RldqFdClKXmCMfGqXPyDMG-uKlI9neR2409JQIhLqmQZKnSg)

Sources: <https://www.infoq.com/articles/ios-application-design-patterns-review>

**Testing strategy**: 
We will use our iphone devices and Xcode simulators to manually test our app.
More specifically, this strategy involves four major process: (1)system testing (2)iOS UI testing(3)security testing(4)Field testing 


----

### Highlights

As a summary of our collaborative process. We’ve decided to:
 
1. Create a News Feed base on time, showing their Twitter, Instagram, Facebook and the latest update on their website, so the user can browse all news in one place. Instead of connecting all LGBT social media, the alternatives we are considering will be a Timeline for the latest events and resources. Thus, we can edit it manually without import the third-party data from Twitter/Instagram/Facebook.
So far, making a timeline makes more sense to our team because the implementation of a timeline is more feasible for our team’s capability.
 
2. Implement a favorite page to store all the user-interested resources and events, so the user can revisit their favorite resources whenever they want. Therefore, it narrows down their search process and allows them to target only the information they desire to see. The alternatives will be a history page in case they close some important pages accidentally and couldn't find the entry to open again. It works similarly as the favorite page. However, it will contain many pages that user has opened but not interested in. Hence, the user still needs lots of time to browse through the history in order to find their desired page. As a result, our final decision will be the first approach (“favorite page”), because using “favorite page” is more efficient and convenient than “History page” to find out the relevant information that they are looking for.
 
3. Include a chat feature that connects to the chat service on their website. The alternatives could be an auto-chat bot on App. The auto-chat-bot can be available to the users who need support when LGBT chat volunteers that are off duty. It can also help to answer frequently asked questions. It can save time for the volunteers to do more important work. However, an auto-chat bot cannot be as intelligent as human beings. It’s hard to meet the need of some users who need someone to talk with. In this case, our team chooses to go with the first approach. 
 
4. Implement an event page with a map indicating all the nearby events. So the user can see which event was held close to his or her current position intuitively. The alternatives will be an event page that displays all the events and users can choose to sort them by keyword/interest (eg, lesbian, party etc.). In this approach, the user can find activities that are the most suitable for their interest. Our group decided to keep both features. However, we want to convert the sort feature to a search-by-keyword feature because the keywords are fixed by our app and user cannot add and sort by their own keywords. The search function is more flexible and this functionality can be used in both the resource page and event page. 
