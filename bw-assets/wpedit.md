# IW3 Bot Warfare Waypoint Editor
First things first, Bot Warfare uses the [AStar search algorithm](https://en.wikipedia.org/wiki/A*_search_algorithm) for creating paths for the bots to find their way through a map. 

The AStar search algorithm requires a [set of waypoints](https://en.wikipedia.org/wiki/Graph_(discrete_mathematics)) defining where all the paths are in the map.

Now if you want to modify existing or create new waypoints for CoD4 maps, this is the read for you.

## Contents
- [Setting up the Waypoint Editor](#Setting-up-the-Waypoint-Editor)
- [The Editor](#The-Editor)

## Setting up the Waypoint Editor
The Bot Warfare mod comes with the Waypoint Editor out of the box, so its just a matter of telling the mod you want to use it. Its a matter of setting the `bots_main_debug` DVAR to `1`.

Start your server with the Bot Warfare mod.

In the server console, type in ```set bots_main_debug 1```.<br>
![Setting the dvar](/bw-assets/console.png)

Now start a match with the map you want to edit with the `devmap <mapname>` command.<br>
![Starting a map](/bw-assets/console-map.png)

It should be noted that waypoints load in this following order;
1. checks the 'waypoints' folder (FS_Game\waypoints) for a csv file
2. loads the waypoints from GSC (maps\mp\bots\waypoints)

If all fail to load waypoints, there will be no waypoints and the bots will not know how to navigate the map.

Connect to the server with the CoD4x client, you'll be introduced to the Waypoint Editor.

## The Editor
![The editor](/bw-assets/editor.png)<br>
This is the Waypoint Editor. You can view, edit and create the waypoint graph.
- Each red number you see in the world is a waypoint.
- The green string you see is the type of that waypoint.
- The green list of numbers are the waypoints linked to that waypoint.
- The pink lines show the links between the waypoints, a link defines that a bot can walk from A to B.
- The white lines show the 'angles' that a waypoint has, these are used for grenade, claymore and tube waypoints. It's used to tell the bot where to look at when grenading/claymoring, etc.

---

Pressing any of these buttons will initiate a command to the Waypoint Editor.
Each button has a secondary modifier button, and can be pressed shortly after pressing the primary button.

- SecondaryOffhand (stun) - Add Waypoint
    - Press nothing - Make a waypoint of your stance
    - ADS - Make a climb waypoint
    - Attack + Use - Make a tube waypoint
    - Attack - Make a grenade waypoint
    - Use - Make a claymore waypoint

- Melee - Link Waypoint
    - Press nothing - Link
    - ADS - Unlink

- FragButton (grenade) - Delete Waypoint
    - Press nothing - Delete Waypoint
    - Attack - Delete all waypoints
    - ADS - (Re)Load Waypoints

- UseButton + Attack - Save Waypoints
    - Press nothing - Save waypoints
    - ADS - Toggle autolink waypoints (links waypoints as you create them)

---

Okay, now that you know how to control the Editor, lets now go ahead and create some waypoints.

Here I added a waypoint.<br>
![Adding a waypoint](/bw-assets/editor-addwp.png)

And I added a second waypoint.<br>
![Adding another waypoint](/bw-assets/editor-addwp2.png)

There are several types of waypoints, holding a modifier button before pressing the add waypoint button will create a special type of waypoint.
- Types of waypoints:
  - any stance ('stand', 'crouch', 'prone') - bots will have this stance upon reaching this waypoint
  - grenade - bots will look at the angles you were looking at when you made the waypoint and throw a grenade from the waypoint
  - tube - bots will look at the angles you were looking at when you made the waypoint and switch to a launcher and fire
  - claymore - bots will look at the angles you were looking at when you made the waypoint and place a claymore or c4
  - camp ('crouch' waypoint with only one linked waypoint) - bots will look at the angles you were looking at when you made the waypoint and camp
  - climb - bots will look at the angles you were looking at when you made the waypoint and climb (use this for ladders and mantles)

Here I linked the two waypoints together.<br>
![Linking waypoints](/bw-assets/editor-link.png)

Linking waypoints are very important, it tells the bots that they can reach waypoint 1 from waypoint 0, and vice versa.

Now go and waypoint the whole map out. This may take awhile and can be pretty tedious.

Once you feel like you are done, press the Save buttons. This will generate a [CSV](https://en.wikipedia.org/wiki/Comma-separated_values) output to your waypoints folder!

That is it! The waypoints should load next time you start your game!

Your waypoints CSV file will be located at ```<fs_game>/waypoints/<mapname>_wp.csv```. (main folder if fs_game is blank)<br>
![Location](/bw-assets/saved.png)
