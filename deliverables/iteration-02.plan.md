# LGBT YouthLine/Rainbow Warriors

## Iteration 02

 * Start date: March 4th, 2019
 * End date: March 10th, 2019

## Process

In this iteration, we will focus on the front-end developing and start planning the back-end structure. The goal for this iteration is having a responsive user interface with some hard-coded data in the front-end app.

#### Roles & responsibilities

Describe the different roles on the team and the responsibilities associated with each role.   
Product Manager and Marketing manager:

Yecheng Song, Yuting Shao (Note that Yecheng and Yuting are also assigned with coding-based jobs, see below)

Software Engineer:

* Front-end Engineer: Shiqi Lin, Yecheng Song, Yuting Shao, Baijiang Yuan
* Back-end Engineer: Huadong Xing, Ran Wei

#### 3 Strength and Weaknesses of team members:
Members | Division| Advantage | Disadvantage
--- | --- | --- | ---
Yecheng Song | 1. Product Manager and Marketing manager </br> 2. Front-end Engineer </br> | 1. Experience in developing apps and websites </br> 2. Familiar with C#, Python, C and JavaScript </br> 3. Familiar with team work and cooperation </br> | 1. Bad at time management </br> 2. Always struggling at making decisions -> wasting time </br> 3. Sometimes writes inefficient codes/hardcoding </br>
Baijiang Yuan | 1. Baijiang Yuan </br>| 1. Familiar with Java/C etc. </br> 2. Good at programming and database. MongoDB etc. </br> 3. learning new languages very fast. </br> | 1. New to App design </br> 2. Can not implement complex component </br> 3. Not familiar with libraries. </br>
Yuting Shao | 1. Product Manager and Marketing manager </br> 2. Front-end Engineer </br> | 1. Familiar with Java, C, etc. </br> 2. Good at frameworks design </br> 3. Good at programming </br> | 1. New to app design </br> 2. Not familiar with UI design </br> 3. Not familiar with libraries <br>
Huadong Xing | 1. Back-end Engineer </br> | 1. Familiar with Java and C Dev. </br> 2. Have experience in CSC309 </br> 3. Have insign in User experience </br> | 1. Hate website development </br> 2. No experience in UI development </br> 3. New to app design </br>
Ran Wei | 1. Back-end Engineer </br> | 1. Familiar with UI design and C </br> 2. Have experience in CSC309 </br> 3. Good at learning new languages </br> | 1. No experience in app design </br> 2. Not familiar with libraries </br> 3. Do not like coding with Java </br>
Shiqi Lin | 1. Front-end Engineer </br> | 1. Familiar with Python and C </br> 2. Decent overall programming skills </br> 3. Good web-building skills from CSC309 </br> | 1. New to App design </br> 2. Not familiar with libraries </br> 3. Hard to explain ideas clearly and intuitively

#### Team Rules

#### Team culture:
Our team’s culture is data-driven, every group member can propose a different solution which supported by a reasonable explanation. Every ideas should have proper reasoning. More importantly, our working environment is friendly and open-minded for any possible solution. We believe that effective communication is the key to build a outstanding team.

#### Team communication:
Channels of communication: WeChat (former channel, now used for casual talks), Slack (currently using for any update in the team)

Our team communication could be done in two ways, via online chatting apps or having a group meeting. All of our team members keep a close contact with each other every day using online chatting, in order to keep every member updated by the latest news and arrangements.

To cooperate with our partner, we use slack and email to keep them updated. Email will be sent on a weekly basis, while other communications will be on Slack. If we cannot reach the partners by slack, we will try to call them or email them. Additionally, considering online chatting could be very inefficient when long discussion is needed for making essential decisions, we keep having a group meeting on weekly basis. 

#### Team meeting:

At the beginning of the semester, every member in our group has updated his/her course schedule onto a sharable doc. By combining everyone’s schedule, we have a clear timetable indicating all possible meeting time for our team. Before the coming of every new week, Yuting in our team will be responsible for making arrangements of our next meeting time, location and attendances. Members who might not be presented will be asked to provide his/her ideas and reasoning about the topic beforehand, or to accept a phone call at meeting time when he/she is physically absent. 

The same mechanics works for our meeting with the partner. Based on our schedule, we send email to confirm a meeting with our partner, with number of team members who will be going. Members might take shifts for each other when someone is busy, but we’re trying to keep every member involved in meeting with the partner.

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
* After everyone finish there own part, we will have a offline group meeting to merge everyone's code, doing so, we can have the conflict or the bug caused by merging being solved quickly.
* All group member will follow the naming conventions and coding style suggested by Swift 4. 
* iOS Simulator is a convenient tool provided by XCode, in the simulator, we can easily compile our code and run it in iOS simulation environment. Also, XCode provides some tools helping developers to install the app on their iPhone without upload the app to App-Store by installing a developer cerification on iPhone. So we will take this advantage to deploy our app in a small range.

## Product

#### Goals and tasks

##### Goals:
 * The main goal for this iteration is: Having a deployable iOS front-end app which has basically a finished layout (working buttoms and navigation inside app) with some hard-coded local data for demo. 
 * The secondary goal is: To work out the data structure of Back-End, what data back-end is expected to storage? What is the JSON format to use in the communication between front-end and back-end?
##### To achieve the Goals, following tasks is required:
 * Design the user interface in detail, and draw the full flow chart of the app.
 * Come up with a working flow that everyone can share the same code base and have comfortable experience to commit their code to the team repo.
 * Get familiar with the developing environment of XCode, and learn how to create views or controllers of user interface. Experiment the iOS App develop flow. 
 * Assign work in detail to each group member.
 * Back-end developers and front-end developers will have meetings to design the communication "protocol".

#### Artifacts
There will be a responsive iOS App for this iteration, although it can't actually fetch data from the backend, but it uses some fake data stored in local for this early demo.
User can explore the freely and have basic impression of the app.
