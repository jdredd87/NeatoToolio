# NeatoToolio
Neato Toolio - Diagnostic tool for Neato Botvacs

Slowly adding support for calls for the XV, BotVac and BotVac Connected / D3-D7 models.

NeatoToolio is "Ready" to download and play with... I think... At least to a point where can start
letting other people play around and weed out all the many issues I am sure to crop up that I didn't catch
or think of....
Things to consider...

1) I have a D3, D7, XV-16, D75 in my hands.  Only things I could test against. So anything else maybe hit or miss. Such as the BotVac Connected for example.

2) While i've tried to catch bugs, I am sure there are many in here.

3) If a crash is bad enough a NeatoToolio_bugreport.txt file is generated and will get a popup. Can save this and view it.. and you can email it to me. It will try to use your email client if one installed.  Will send to neatotoolio@twc.com

4) I have no "tools" yet .. like drain the battery. Create a dump of information to paste around.  There is under Serial / Raw Data tab, all send/recv text , so can for now copy from there.

5) My script engine support is no where near ready.. So that will be not visible for now.  Like to get that going in the next few weeks.  I will probably do the drain/recharge tool in this.

6) I still have a lot of work ahead of me to go back through the source code and start optimizing some things.
Business logic code... GUI look and feel... More error catching... ect.  

7) Some things will auto enable TestMode.. items that say they won't run at all unless enabled.  
    So if its a call that can still work without testmode ON ... it won't turn it on. This may change if people
   report they want certain tabs to turn testmode on ( in case it is off )

8) I don't have an online update mechanism in place right now.. maybe later this week.
    I really don't want to host files, so may see if I can do this by using GitHub to host files for me.

9) Once I think everything in the Windows flavor is to a happy place, I will be switching to the Android and possibly iOS side of things.  Delphi allows cross compile and I've tested a few things with my Android devices and it works, but I have to remap all the GUI design to be mobile friendly. Which GUI is the pain usually in any dev work. iOS I am not 100% sure as iOS deployment is 1000x more a pain in the butt than Google Play Store. 

10) IP / Port connecting ( wireless serial adapters ) will come eventually as I have a new adapter i've tested.

11) Remember, this is free... so don't complain to much :)


Anyways..

Can download and run @ https://github.com/jdredd87/NeatoToolio/raw/master/Installer/NeatoToolio_Install.exe

Everything that isn't a paid for 3rd party that I own licenses to is posted to this repository... 
Hopefully as time allows, ill be cleaning up source and improving.  Please let me know and please don't hammer me to badly :)
