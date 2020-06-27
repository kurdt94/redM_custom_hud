# redM_custom_hud
Custom HUD for REDM including WIND DIRECTION + LOCATION and COMPASS removing the CROSSHAIR 
( feel free to adjust my files to your liking )

- SVG compass showing N, E, S, W
- Showing Location 
- Showing Wind Direction
- Showing Health and Stamina bar 
- Removing entire Rockstar HUD !
  -Also removes weapon dial ( so you need to find a way around this one (ex. using inventory) )
  -Also removes certain ingame-alerts ( you killed 10 enemys .. etc. )

# Installation
- Create a new folder within RESOURCES and name it to your liking
- Add "ensure yourfolder" to your server config

# Available Exports
- Call these exports at your desired places ( ex. on player death | while in a menu )
exports.yourfolder:showCompass()
exports.yourfolder:hideCompass()

# Known Issues
- Not sure if the location-hashes I have are complete or entirely correct. 
