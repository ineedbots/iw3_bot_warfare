# CoD4x Bot Warfare v2.1.0
Bot Warfare is a GSC mod for the CoD4x project.

It aims to add playable AI to the multiplayer games of CoD4.

You can find the more information at the Git Repo: https://github.com/ineedbots/cod4x_bot_warfare

**Important to public dedicated servers**
The 'bots_main_firstIsHost' DVAR is enabled by default!
This is so inexperienced users of the mod can access with menu without any configuration.
Make sure to disable this DVAR by adding 'set bots_main_firstIsHost 0' in your server config!

## Installation
0. Make sure that CoD4x server + client is installed, updated and working properly.
	- Go to https://cod4x.ovh/ and download the Windows Server zip file. Move the contents of 'cod4x-windows-server' into your CoD4 game folder.
1. Locate your CoD4x server install folder.
2. Move the files/folders found in 'Add to root of CoD4x server' from the Bot Warfare release archive you downloaded to the root of your CoD4x server folder.
    - The folder/file structure should follow as '.CoD4x server folder\main_shared\maps\mp\bots\_bot.gsc'.
3. The mod is now installed.
    - You can use the z_localserver.bat to start a local server.
    - You can use the z_playserver.bat to join the local server and play!

## Documentation

### Menu Usage
- You can open the menu by pressing the primary grenade and secondary grenade buttons together.

- You can navigate the options by the pressing the ADS and fire keys, and you can select options by pressing your melee key.

- Pressing the menu button again closes menus.

## Changelog
- v2.1.0
  - Bot chatter system, bots_main_chat
  - Greatly reduce script variable usage
  - Improved bots mantling and stuck
  - Fix some runtime errors
  - Bots sprint more
  - Improved bots sight on enemies
  - Bots do random actions while waiting at an objective
  - Improved bots from getting stuck
  - Better bot difficulty management, bots_skill_min and bots_skill_max

- v2.0.1
  - Reduced bots crouching
  - Increased bots sprinting
  - Improved bots mantling, crouching and knifing glass when needed
  - Fixed possible script runtime errors
  - Improved domination
  - Bots use explosives more if they have it
  - Bots aim slower when ads'ing
  - Fixed bots holding breath
  - Fixed bots rubberbanding movement when their goal changes
  - Added bots quickscoping with snipers
  - Added bots reload canceling and fast swaps
  - Bots use C4
  - Improved revenge
  - Bots can swap weapons on spawn more likely

- v2.0.0
  - Initial reboot release

## Credits
- CoD4x Team - https://github.com/callofduty4x/CoD4x_Server
- INeedGames(me) - http://www.moddb.com/mods/bot-warfare
- PeZBot team - http://www.moddb.com/mods/pezbot
- Ability
- Salvation

Feel free to use code, host on other sites, host on servers, mod it and merge mods with it, just give credit where credit is due!
	-INeedGames/INeedBot(s) @ ineedbots@outlook.com
