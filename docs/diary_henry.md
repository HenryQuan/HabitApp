# Henry's Diary
~~~
template
# /04/2020
~~~

# 19/04/2020
The app works if you follow it but it is so hard for me to follow my own app. I just waste my time and escape from it. I wasn't like this. I guess I get more weaknesses when I grow up. It shouldn't be like this. You should be better than this. 
***
Many issues are fixed. It should be ready for a beta release on Google Play. I might work on it soon. 

# 10/03/2020
Notification is working but only once somehow. I might need to study more about Android notifications. 
Version 0.0.3 is out for internal testing. I have added a settings button for `ResultWidget` to update reminder. 
I still need to polish this app with more suggestions and ideas if possible. About and how to use are also really important I think. 

# 07/03/2020
Testing phrase 1 was done and everything is working. The main issue here is that users don't know how this app works. 
I need to write a good `about this app` and `how it works`. The purpose of this app is to start something. 
That's why one minute is sufficient for it. I will probably publish it or do a beta testing at the end of this month. 

# 01/03/2020
`History` has been implemented and it is ready for alpha testing. It is quite smooth on my phone. 
I will do some more optimization development on IOS and I think it should be ready to be published. 
Failed habits can now be added and new habit can start again. I will publish 0.0.2 version later.

# 29/02/2020
Somehow, this wasn't committed. It was mainly about `HomePage` and `ResultWidget`. Only `History` left now.

# 28/02/2020
Some more designs were done today on my iPad. Now, time is selected via `DatePicker`. It is more fun and easier for users to see. 
Other than simply typing in a boring number. I think home screen is now all good. The field should only be changable on Day 1. 
Now, only `History` left. I am still thinking about it and I don't know how to add it yet. 
When a habit ends, it should push to `History` and add `curr` to `history`. 
`curr` becomes null and `History` should push to `Home` to start a new habit. However, the user has done one. 
Maybe it is better to wait for the next day? Yes, I have decided to let the user wait for one day. The habit will be added to `History` 
if the user uses the app the next day or after that. Animation will be shown and current habit will be added to history. 
I will leave it for tomorrow because I have done enough today. 

# 27/02/2020
Theme in `HomePage` is now working properly. It was broken because `Stack` and `AppBar`. 
I am still stuck on the home page now. Using an `AppBar` isn't bad and the design is also fine. 
However, I am not sure that the habit entering part. It might take a bit more time I think. 

# 26/02/2020
Logo has been added but it is rather blurry for some reasons. I will update it so that it is more hd. 
I will not probably work on this today. It is close to the end now and shaun might help me with English. 
Now, how to choose the date might be a big issue. Then, you have the history and IAP for Android. 
I don't know what to do about it yet but I think I should solve it soon. 

# 25/02/2020
`Intro` is now done but haven't tested on Android. `Settings` has been updated and a share button has been added to the `ResultWidget`. 
Both `Completed` and `Failed` were removed because they are no longer necessary. The start button has been replaced with `START NOW`. 
Some models have been created and `LocalDate` will be used to manage data. This project has been quite smooth so far. 
Now, only `HomePage` and `HabitListPage` left. How the user should interact with the input is still a big issue. 
I want to push to `HabitListPage` when a new habit is done. Then, a new item will popup and it will push to `HomePage` again. 
It should be the same for failed state as well. I need more testings so probably I will use this app myself for at least a month. 

# 24/02/2020
Nothing but thinking about local data. A boolean value should be added to indicate whether user passed the tutorial. 
I think most designs are good and I have a clearer idea now. I will work on this more.

# 23/02/2020
More animations, specially cross fade two lables. Last night, I was thinking of adding percetange to past habits. 
When a new habit completes or fails, the app will push to the list and add the new habit which its percentage and corresponding colour (green or red). Also, I will extract `Completed` widget so that it also supports `Failed`. Then, it is time to do past habit list. The `Intro` and `Turorial` page shouldn't be that hard. Maybe I can finish this app in a month if I work on everyday but who knows? I should do more design and know what kind of features I want.

# 22/02/2020
Animations were added today. After the timer reaches zero, a new screen will popup and the check icon will be shown, followed by the text. This is a simple app so the animation needs to be great and it will be the main focus of this app as well. It is about time to use more animations so that the app feels alive.

# 21/02/2020
Today, I was mainly focused on the one minute timer. The animation is quite smooth and it supports dark mode as well. 
There aren't many screens and if possible, I want to make it as clean as possible. Pushing everything to the limit. 

# 20/02/2020
## WoWs Info
I want to take a break from WoWs Info. Charge or not, this is a hard question. 
I cannot offer my app for free anymore so let's wait and see. 

## Henry's Habit App
This app aims to help you start a new habit. Only one and just one at a time. 
You just need to do it everyday for at least one minute. It will be 1 USD I think. 
I want to use make app to help me and also help others. 
It is not about how long you do it today or tomorrow. 
It is about whether you can keep doing it unless a point where you feel strange if you don't do it.
