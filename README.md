# deployr

A wrappr for installr and bootstrappr. I made this so that I could name a machine during the initial recovery partition bash script for both installr and bootstrappr. Then since I was already doing some more complex stuff to these simple scripts, why not combine them both?
![why not both?](https://media.giphy.com/media/3o85xIO33l7RlmLR4I/giphy.gif)

If you've used bootstrappr or installr, you'll have a pretty good idea of how to use deployr. If you use the `make_dmg.sh` to create, then you will run `hdiutil attach http://dmg_location/mac.dmg` and then `/Volumes/deploy/mac`. You will want to customize the `mac` script to add the $DMG_LOCATION and any custom questions you may want to ask. For ours, we put some info into the ARD text fields, so that is what is included.

## [Bootstrappr](https://github.com/munki/bootstrappr)
For use with bootstrapr, the format I'm following requires that you also have a productbuild version of outset in your packages folder.
Get that [here](https://github.com/chilcote/outset/releases) and run `productbuild -p /path/to/outset.pkg /path/to/productbuild/outset.pkg` then add that to the packages folder.

## [Installr](https://github.com/munki/installr)
In order to customize the name of an uninstalled machine, you need to customize a package on every run. To do this I have an expanded package in the script_package directory.
You will need to add the productbuild binary to this folder as well as the Recovery partition does not include this. `cp /usr/bin/productbuild ./script_package`
You should then have the tools you need to build a package for use with startosinstall from within the Recovery partition. We are simply editing the postinstall script in the expanded package directory, so anything that is scriptable should be able to go in there to use. 

I have split out the OS dmg from the deployr dmg because I hated waiting for Installr to finish making the dmg. You will need to download the OS you would like to install and create a dmg. I've included sample directories/scripts to do this. 