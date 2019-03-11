# LGBT YouthLine/Rainbow Warriors

 > _Note:_ This document is meant to be written during (or shortly after) your review meeting, which should happen fairly close to the due date.      
 >      
 > _Suggestion:_ Have your review meeting a day or two before the due date. This way you will have some time to go over (and edit) this document, and all team members should have a chance to make their contribution.


## Iteration 02 - Review & Retrospect

 * When: March 9, 2019
 * Where: BA 3175

## Process - Reflection

#### Decisions that turned out well
 * We choose to draw flow chart before coding. Flow chart help us to see each pages relation more clearly.
 * Assign work in detail to each group member. This improve our work efficiency a lot, each member have clear idea what they need to do.


#### Decisions that did not turn out as well as we hoped

 * We planed to have three group members to do front-end. However, fornt-end have heavy work load in this deliverable. So, we makes 4 members working on front-end in this deliverable.
 * Back-end group members had little work to do.


#### Planned changes
 
 * We change our group structure, before, we have three members in back-end group and three members in front-end group. After changing, we have four members in front-end group. Since there is lot of work need to be done in front-end.

## Product - Review

#### Goals and/or tasks that were met/completed:

 * iOS front-end app which has basically finished layout (working buttoms and navigation inside app) with some hard-coded local data for demo.
 * Data structure for back-end is confirmed.

#### Goals and/or tasks that were planned but not met/completed:

 * iOS App do not deploy yet. We under-estimate difficulty to deploy iOS App, we do not have enough time to deploy it.

## Meeting Highlights
 
* First, we need to write the internal data fetching logic for the front-end. For now, our mobile app only use data pre-stored on local to demo the GUI. To make it a read working front-end, we still need to finish the fetching logic, how the program package the "get" json request and how the program decode the json from server.
* Second, we need to design our Admin page GUI for the back-end. Admin page is important to the app owner, owner will need to use the admin page to manage the resources, event and userdata in the back-end database.
* Third, we need to write the back-end internal logic to handle data get and post request. This the core of back-end, to process all the request from front-end and back-end admin page. Receive data from admin page and store it into database, obtain data from database and send it front-end.
* Fourth, try to combine the front-end and back-end together and debug.