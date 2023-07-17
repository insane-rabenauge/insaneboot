# insaneboot
insaneBOOT by insane/tSCc

This boot menu allows a grouped selection of autostart files.
insaneBOOT does NOT write to your HD/CF! Instead it simply runs the files.

Check the example autoexec.cfg file for options

insaneBOOT also includes fpatch1/fpatch2/bmapfix2 support (if enabled),
so you don't need to include them inside autoexec.cfg

# History:
1.0 beta build 20190223.2034
- first public beta release

1.0 beta build 20190225.1742
- added savelast; insaneboot remembers your selection

1.0 beta build 20190225.1758
- cosmetics: show selection cursor after timeout

1.0 beta build 20190225.1912
- cursor right now executes the menu item

1.0 beta build 20190228.0949
- modified config open code

1.0 beta build 20190315.1505
- restructured code to not run inside supervisor mode
-> fixes no-keyboard-input when ran inside mint.cnf

1.0 build 20200429
- insaneBOOT opens menu.cfg if it exists in the same directory
