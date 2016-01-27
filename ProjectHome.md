This is a project to extend the great work Glenn Kreisel and Chris Reed did with porting CotVNC to the iPhone.  There were some features I (and others) wanted so I decided to spend some time teaching myself to program in ObjC (and learn C too).  Modifying VNSea seemed like a great way to start.

Since my modifications now seem to be working (but not yet robust), I figured I'd share them with the world (and hopefully get some feedback for other improvements).

Added features:

- Panning is accomplished by tilting the phone

- Added an arrow key pad that includes home/end/pgup/pgdn (accepting ideas for what that center button should do)

Future plans:

- Require a shake to change orientation so tilting does not inadvertently change the orientation

- Allow users to 'zero' the accelerometer and adjust the sensitivity

- Get rid of the scroll wheel pad which just doesn't work well (screen refresh is just too slow and page up/down works better)