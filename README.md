# redM_custom_hud
REDM: custom HUD, including WIND DIRECTION, LOCATION and COMPASS removing the CROSSHAIR 
( feel free to adjust my files to your liking )

- SVG compass showing N, E, S, W
- Showing Location 
- Showing Wind Direction
- Showing Health and Stamina bar 
- Removing entire Rockstar HUD !
- This also removes weapon dial ( so you need to find a way around this one (ex. using inventory) )
- This also removes certain ingame-alerts ( you killed 10 enemys .. etc. )

# Installation
- Create a new folder within RESOURCES and name it to your liking
- Add "ensure yourfolder" to your server config

# Available Exports
- Call these exports at your desired places ( ex. on player death | while in a menu )

exports.yourfolder:showCompass()

exports.yourfolder:hideCompass()

- There is a custom crosshair available in the HTML file, you need to uncomment a LINE to enable.

# Known Issues
- Not sure if the location-hashes I have are complete or entirely correct.
- Works for [1920 x 1080 Resolution], anything lower can break layout.

# @TODO or not @TODO
- Enable Crosshair when player is using BOW
- Add Config for usability
