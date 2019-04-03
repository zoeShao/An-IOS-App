# YOUR PRODUCT/TEAM NAME

 > _Note:_ This document is meant to be written during (or shortly after) your initial planning meeting.     
 > It does not really make sense for you to edit this document much (if at all) while working on the project - Instead, at the end of the planning phase, you can refer back to this document and decide which parts of your plan you are happy with and which parts you would like to change.


## Iteration 03

 * Start date: March 23,2019
 * End date: Marhc 31, 2019

## Process

In this iteration, we will focus on the front-end imporvement and back-end building . The goal for this iteration is having a complete version of our product.

#### Changes from previous iteration

List the most significant changes you made to your process (if any).
1. Home page: Added phone call button, message sending button and scocial media buttons. Deleted viewing upcoming events feature and replaced with the youthline organization overview.
##### Reasons: 
Upcoming event feature is very similar to the event page so rather displaying repeated data, its better to let user having an overview of the organization.
2. Event page: Every event could be selected as "liked" in its detail page. A "liked filter" on the event list page view can help users look at their favourite events, traced by their username after logging in.
##### Reason:
Like filter is added instead of putting the like button in personal page beacause users can access their liked events in a faster way when they are browsing events, which makes the design of the product more intuitive and easy to use.
3. Made login in work.
##### Reason:
This is the not working feature from the last iteration. We need to make it work to make the favoriate history consistent with each user.
4. Connected frontend to backend.
##### Reason:
To make the product deployable we need to connect the backend and frontend.
5. Resource page: Added more filters. Make the UI consistent with other pages.
##### Reason:
To make the product looks consistent we need to make some changes to the resource page UI.

 #### Roles & responsibilities

Describe the different roles on the team and the responsibilities associated with each role. 
 * Roles should reflect the structure of your team and be appropriate for your project. Not necessarily one role to one team member.


Yecheng Song, Yuting Shao (Note that Yecheng and Yuting are also assigned with coding-based jobs, see below)

Software Engineer:

* Front-end Engineer: Shiqi Lin, Yecheng Song, Yuting Shao, Baijiang Yuan
* Back-end Engineer: Huadong Xing, Ran Wei
#### Team Rules

Describe your team's working culture.
#### Team culture:
Our team’s culture is data-driven, every group member can propose a different solution which supported by a reasonable explanation. Every ideas should have proper reasoning. More importantly, our working environment is friendly and open-minded for any possible solution. We believe that effective communication is the key to build a outstanding team.

Communications:
#### Team communication:
Channels of communication: WeChat (former channel, now used for casual talks), Slack (currently using for any update in the team)

Our team communication could be done in two ways, via online chatting apps or having a group meeting. All of our team members keep a close contact with each other every day using online chatting, in order to keep every member updated by the latest news and arrangements.

To cooperate with our partner, we use slack and email to keep them updated. Email will be sent on a weekly basis, while other communications will be on Slack. If we cannot reach the partners by slack, we will try to call them or email them. Additionally, considering online chatting could be very inefficient when long discussion is needed for making essential decisions, we keep having a group meeting on weekly basis. 

#### Team meeting:

At the beginning of the semester, every member in our group has updated his/her course schedule onto a sharable doc. By combining everyone’s schedule, we have a clear timetable indicating all possible meeting time for our team. Before the coming of every new week, Yuting in our team will be responsible for making arrangements of our next meeting time, location and attendances. Members who might not be presented will be asked to provide his/her ideas and reasoning about the topic beforehand, or to accept a phone call at meeting time when he/she is physically absent. 

The same mechanics works for our meeting with the partner. Based on our schedule, we send email to confirm a meeting with our partner, with number of team members who will be going. Members might take shifts for each other when someone is busy, but we’re trying to keep every member involved in meeting with the partner.
Conflict Resolution:
 #### Conflict resolution: 
* Indecision: We vote for decision and go for the one with majority votes.
* Non-responsive team members: Try to set up a face-to-face meeting with them and try to find out/fix any problem with them.
* Not-doing-work: Friendly alarm him and discuss the potential issues.


#### Events

As it has been mentioned before, we’re having pre-arranged meetings in person on a weekly basis, to discuss about the latest updates of the course, share ideas within the team, check everyone’s progress and give out new tasks. The meeting usually takes place in Bahen Center, 40 St. George Street. In our next meeting after the submission of deliverable 1, we’re planning to have a meeting about the functionalities and product prototype.

Also, we do have online meetings via either voice chatting or texting in a group. This could happen at any time of a day and solves little issues within the team. 
#### Artifacts

Artifacts that we have in our team construct:
* A schedule containing all available time slots for the team
* A team log that contains all our meeting details and records
* A sharable doc where we post the latest to-do list for the team
* A chatting group on WeChat and Slack

    
We keep every of our team member acknowledged about our current tasks, by sending group notices on WeChat and updating our to-do list in a sharable doc. Everyone in our team can either go to the online doc to see what should be done or check the group messages every day. The priority of every task is decided mostly in our group meetings, based on the level of importance. To ensure that every member is assigned with reasonable work, we split our group into two divisions (frontend and backend). Furthermore, we usually discuss about distribution of jobs right after our group tasks are decided. By selecting one member to be our product manager, we also have someone to keep track of everyone’s progress, so that everyone is ensured to know what he/she is doing at a certain time spot.

#### Deployment and Github Workflow

* We plan to let every front-end member(Shiqi Lin, Yecheng Song, Yuting Shao, Baijiang Yuan) create a project on their own branch and implement their responsible page (Home Page, Event Page, Resource Page, User Page respectively) for the app. After everyone finished their part, we meet together and merge the projects.
* Back-end developers will build the back end for our app using python on their own branch.
* Back-end developers will build Adminstor website.
* After everyone finish there own part, we will have a offline group meeting to merge everyone's code, doing so, we can have the conflict or the bug caused by merging being solved quickly.
* All group member will follow the naming conventions and coding style suggested by Swift 4. 
* iOS Simulator is a convenient tool provided by XCode, in the simulator, we can easily compile our code and run it in iOS simulation environment. Also, XCode provides some tools helping developers to install the app on their iPhone without upload the app to App-Store by installing a developer cerification on iPhone. So we will take this advantage to deploy our app in a small range.




## Product

#### Goals and tasks

* The main goal for this iteration is: Having a deployable iOS front-end app which has  a finished layout (working buttoms and navigation inside app) with retrive data from back-end 
 * The secondary goal is: Some imporvement of front-end UI
##### To achieve the Goals, following tasks is required:
 * Design the back-end in detail, and draw the full flow chart of the app.
 * Come up with a working flow that everyone can share the same code base and have comfortable experience to commit their code to the team repo.
 * Get familiar with the developing environment of XCode, and learn how to create views or controllers of user interface. Experiment the iOS App develop flow. 
 * Assign work in detail to each group member.
 * Back-end developers and front-end developers will have meetings to design the communication "protocol".
#### Artifacts
There will be a responsive iOS App for this iteration, it can actually fetch data from the backend,
User can explore the freely of the app.
