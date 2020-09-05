#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;

/*
	Returns if the player is a bot.
*/
is_bot()
{
	return ((isDefined(self.pers["isBot"]) && self.pers["isBot"]) || (isDefined(self.pers["isBotWarfare"]) && self.pers["isBotWarfare"]) || self getguid() == "0");
}

/*
	Bot presses the button for time.
*/
BotPressAttack(time)
{
	self maps\mp\bots\_bot_internal::fire(time);
}

/*
	Returns the bot's random assigned number.
*/
BotGetRandom()
{
	return self.bot.rand;
}

BotGetTargetRandom()
{
	if (!isDefined(self.bot.target))
		return undefined;

	return self.bot.target.rand;
}

/*
	Bot presses the ads button for time.
*/
BotPressADS(time)
{
	self maps\mp\bots\_bot_internal::pressADS(time);
}

BotPressFrag(time)
{
	self maps\mp\bots\_bot_internal::frag(time);
}

BotPressSmoke(time)
{
	self maps\mp\bots\_bot_internal::smoke(time);
}

/*
	Returns if the bot is fragging.
*/
IsBotFragging()
{
	return self.bot.isfraggingafter;
}

/*
	Returns if the bot is pressing smoke button.
*/
IsBotSmoking()
{
	return self.bot.issmokingafter;
}

/*
	Returns if the bot is sprinting.
*/
IsBotSprinting()
{
	return self.bot.issprinting;
}

/*
	Returns if the bot is reloading.
*/
IsBotReloading()
{
	return self.bot.isreloading;
}

/*
	Freezes the bot's controls.
*/
BotFreezeControls(what)
{
	self.bot.isfrozen = what;
	if(what)
		self notify("kill_goal");
}

/*
	Returns if the bot is script frozen.
*/
BotIsFrozen()
{
	return self.bot.isfrozen;
}

/*
	Sets the bot's target to be this ent.
*/
SetAttacker(att)
{
	self.bot.target_this_frame = att;
}

/*
	Returns if the bot has a script goal.
	(like t5 gsc bot)
*/
HasScriptGoal()
{
	return (isDefined(self.bot.script_goal));
}

/*
	Sets the bot's goal, will acheive it when dist away from it.
*/
SetScriptGoal(goal, dist)
{
	self.bot.script_goal = goal;
	self.bot.script_goal_dist = dist;
	waittillframeend;
	self notify("new_goal_internal");
	self notify("new_goal");
}

/*
	Clears the bot's goal.
*/
ClearScriptGoal()
{
	self SetScriptGoal(undefined, 0);
}

SetScriptAimPos(pos)
{
	self.bot.script_aimpos = pos;
}

ClearScriptAimPos()
{
	self SetScriptAimPos(undefined);
}

/*
	Sets the script enemy for a bot.
*/
SetScriptEnemy(enemy, offset)
{
	self.bot.script_target = enemy;
	self.bot.script_target_offset = offset;
}

/*
	Removes the script enemy of the bot.
*/
ClearScriptEnemy()
{
	self SetScriptEnemy(undefined, undefined);
}

/*
	Returns the entity of the bot's target.
*/
GetThreat()
{
	if(!isdefined(self.bot.target))
		return undefined;
		
	return self.bot.target.entity;
}

/*
	Returns if the given weapon is full auto.
*/
WeaponIsFullAuto(weap)
{
	weaptoks = strtok(weap, "_");
	
	return isDefined(weaptoks[0]) && isString(weaptoks[0]) && isdefined(level.bots_fullautoguns[weaptoks[0]]);
}

/*
	Returns if the bot has a script enemy.
*/
HasScriptEnemy()
{
	return (isDefined(self.bot.script_target));
}

/*
	Returns if the bot has a threat.
*/
HasThreat()
{
	return (isDefined(self GetThreat()));
}

/*
	Returns what our eye height is.
*/
GetEyeHeight()
{
	myEye = self GetEyePos();
	
	return myEye[2] - self.origin[2];
}

/*
	Returns (iw4) eye pos.
*/
GetEyePos()
{
	return self getTagOrigin("tag_eye");
}

/*
	Waits until either of the nots.
*/
waittill_either(not, not1)
{
	self endon(not);
	self waittill(not1);
}

/*
	Returns if we have the create a class object unlocked.
*/
isItemUnlocked(what, lvl)
{
	switch(what)
	{
		case "ak47":
			return true;
		case "ak74u":
			return (lvl >= 28);
		case "barrett":
			return (lvl >= 49);
		case "dragunov":
			return (lvl >= 22);
		case "g3":
			return (lvl >= 25);
		case "g36c":
			return (lvl >= 37);
		case "m1014":
			return (lvl >= 31);
		case "m14":
			return (lvl >= 46);
		case "m16":
			return true;
		case "m21":
			return (lvl >= 7);
		case "m4":
			return (lvl >= 10);
		case "m40a3":
			return true;
		case "m60e4":
			return (lvl >= 19);
		case "mp44":
			return (lvl >= 52);
		case "mp5":
			return true;
		case "p90":
			return (lvl >= 40);
		case "rpd":
			return true;
		case "saw":
			return true;
		case "skorpion":
			return true;
		case "uzi":
			return (lvl >= 13);
		case "winchester1200":
			return true;
		case "remington700":
			return (lvl >= 34);
		case "beretta":
			return true;
		case "colt45":
			return (lvl >= 16);
		case "deserteagle":
			return (lvl >= 43);
		case "deserteaglegold":
			return (lvl >= 55);
		case "usp":
			return true;
		case "specialty_bulletdamage":
			return true;
		case "specialty_armorvest":
			return true;
		case "specialty_fastreload":
			return (lvl >= 20);
		case "specialty_rof":
			return (lvl >= 29);
		case "specialty_twoprimaries":
			return (lvl >= 38);
		case "specialty_gpsjammer":
			return (lvl >= 11);
		case "specialty_explosivedamage":
			return true;
		case "specialty_longersprint":
			return true;
		case "specialty_bulletaccuracy":
			return true;
		case "specialty_pistoldeath":
			return (lvl >= 8);
		case "specialty_grenadepulldeath":
			return (lvl >= 17);
		case "specialty_bulletpenetration":
			return true;
		case "specialty_holdbreath":
			return (lvl >= 26);
		case "specialty_quieter":
			return (lvl >= 44);
		case "specialty_parabolic":
			return (lvl >= 35);
		case "specialty_specialgrenade":
			return true;
		case "specialty_weapon_rpg":
			return true;
		case "specialty_weapon_claymore":
			return (lvl >= 23);
		case "specialty_fraggrenade":
			return (lvl >= 41);
		case "specialty_extraammo":
			return (lvl >= 32);
		case "specialty_detectexplosive":
			return (lvl >= 14);
		case "specialty_weapon_c4":
			return true;
		default:
			return true;
	}
}

isWeaponDroppable(weap)
{
	return (maps\mp\gametypes\_weapons::mayDropWeapon(weap));
}

IsDefusing()
{
	return (isDefined(self.isDefusing) && self.isDefusing);
}

isPlanting()
{
	return (isDefined(self.isPlanting) && self.isPlanting);
}

inLastStand()
{
	return (isDefined(self.lastStand) && self.lastStand);
}

/*
	Returns if we are stunned.
*/
IsStunned()
{
	return (isdefined(self.concussionEndTime) && self.concussionEndTime > gettime());
}

/*
	Returns if we are beingArtilleryShellshocked 
*/
isArtShocked()
{
	return (isDefined(self.beingArtilleryShellshocked) && self.beingArtilleryShellshocked);
}

/*
	Selects a random element from the array.
*/
Random(arr)
{
	size = arr.size;
	if(!size)
		return undefined;
		
	return arr[randomInt(size)];
}

/*
	Removes an item from the array.
*/
array_remove( ents, remover )
{
	newents = [];
	for(i = 0; i < ents.size; i++)
	{
		index = ents[i];
		
		if ( index != remover )
			newents[ newents.size ] = index;
	}

	return newents;
}

/*
	Waits until not or tim.
*/
waittill_notify_or_timeout(not, tim)
{
	self endon(not);
	wait tim;
}

/*
	Pezbot's line sphere intersection.
*/
RaySphereIntersect(start, end, spherePos, radius)
{
   dp = end - start;
   a = dp[0] * dp[0] + dp[1] * dp[1] + dp[2] * dp[2];
   b = 2 * (dp[0] * (start[0] - spherePos[0]) + dp[1] * (start[1] - spherePos[1]) + dp[2] * (start[2] - spherePos[2]));
   c = spherePos[0] * spherePos[0] + spherePos[1] * spherePos[1] + spherePos[2] * spherePos[2];
   c += start[0] * start[0] + start[1] * start[1] + start[2] * start[2];
   c -= 2.0 * (spherePos[0] * start[0] + spherePos[1] * start[1] + spherePos[2] * start[2]);
   c -= radius * radius;
   bb4ac = b * b - 4.0 * a * c;
   
   return (bb4ac >= 0);
}

/*
	Returns if a smoke grenade would intersect start to end line.
*/
SmokeTrace(start, end, rad)
{
	for(i = level.bots_smokeList.count - 1; i >= 0; i--)
	{
		nade = level.bots_smokeList.data[i];
		
		if(nade.state != "smoking")
			continue;
			
		if(!RaySphereIntersect(start, end, nade.origin, rad))
			continue;
		
		return false;
	}
	
	return true;
}

/*
	Returns the cone dot (like fov, or distance from the center of our screen). 1.0 = directly looking at, 0.0 = completely right angle, -1.0, completely 180
*/
getConeDot(to, from, dir)
{
    dirToTarget = VectorNormalize(to-from);
    forward = AnglesToForward(dir);
    return vectordot(dirToTarget, forward);
}

DistanceSquared2D(to, from)
{
	to = (to[0], to[1], 0);
	from = (from[0], from[1], 0);
	
	return DistanceSquared(to, from);
}

/*
	Rounds to the nearest whole number.
*/
Round(x)
{
	y = int(x);
	
	if(abs(x) - abs(y) > 0.5)
	{
		if(x < 0)
			return y - 1;
		else
			return y + 1;
	}
	else
		return y;
}

/*
	Rounds up the given value.
*/
RoundUp( floatVal )
{
	i = int( floatVal );
	if ( i != floatVal )
		return i + 1;
	else
		return i;
}

/*
	Creates indexers for the create a class objects.
*/
cac_init_patch()
{
	// oldschool mode does not create these, we need those tho.
	if(!isDefined(level.tbl_weaponIDs))
	{
		level.tbl_weaponIDs = [];
		for( i=0; i<150; i++ )
		{
			reference_s = tableLookup( "mp/statsTable.csv", 0, i, 4 );
			if( reference_s != "" )
			{ 
				level.tbl_weaponIDs[i]["reference"] = reference_s;
				level.tbl_weaponIDs[i]["group"] = tablelookup( "mp/statstable.csv", 0, i, 2 );
				level.tbl_weaponIDs[i]["count"] = int( tablelookup( "mp/statstable.csv", 0, i, 5 ) );
				level.tbl_weaponIDs[i]["attachment"] = tablelookup( "mp/statstable.csv", 0, i, 8 );	
			}
			else
				continue;
		}
	}
	
	if(!isDefined(level.tbl_WeaponAttachment))
	{
		level.tbl_WeaponAttachment = [];
		for( i=0; i<8; i++ )
		{
			level.tbl_WeaponAttachment[i]["bitmask"] = int( tableLookup( "mp/attachmentTable.csv", 9, i, 10 ) );
			level.tbl_WeaponAttachment[i]["reference"] = tableLookup( "mp/attachmentTable.csv", 9, i, 4 );
		}
	}
	
	if(!isDefined(level.tbl_PerkData))
	{
		level.tbl_PerkData = [];
		// generating perk data vars collected form statsTable.csv
		for( i=150; i<194; i++ )
		{
			reference_s = tableLookup( "mp/statsTable.csv", 0, i, 4 );
			if( reference_s != "" )
			{
				level.tbl_PerkData[i]["reference"] = reference_s;
				level.tbl_PerkData[i]["reference_full"] = tableLookup( "mp/statsTable.csv", 0, i, 6 );
				level.tbl_PerkData[i]["count"] = int( tableLookup( "mp/statsTable.csv", 0, i, 5 ) );
				level.tbl_PerkData[i]["group"] = tableLookup( "mp/statsTable.csv", 0, i, 2 );
				level.tbl_PerkData[i]["name"] = tableLookupIString( "mp/statsTable.csv", 0, i, 3 );
				level.tbl_PerkData[i]["perk_num"] = tableLookup( "mp/statsTable.csv", 0, i, 8 );
			}
			else
				continue;
		}
	}

	level.perkReferenceToIndex = [];
	level.weaponReferenceToIndex = [];
	level.weaponAttachmentReferenceToIndex = [];
	
	for( i=0; i<150; i++ )
	{
		if(!isDefined(level.tbl_weaponIDs[i]) || !isDefined(level.tbl_weaponIDs[i]["reference"]))
			continue;
			
		level.weaponReferenceToIndex[level.tbl_weaponIDs[i]["reference"]] = i;
	}
	
	for( i=0; i<8; i++ )
	{
		if(!isDefined(level.tbl_WeaponAttachment[i]) || !isDefined(level.tbl_WeaponAttachment[i]["reference"]))
			continue;
			
		level.weaponAttachmentReferenceToIndex[level.tbl_WeaponAttachment[i]["reference"]] = i;
	}
	
	for( i=150; i<194; i++ )
	{
		if(!isDefined(level.tbl_PerkData[i]) || !isDefined(level.tbl_PerkData[i]["reference_full"]))
			continue;
	
		level.perkReferenceToIndex[ level.tbl_PerkData[i]["reference_full"] ] = i;
	}
}

tokenizeLine(line, tok)
{
  tokens = [];

  token = "";
  for (i = 0; i < line.size; i++)
  {
    c = line[i];

    if (c == tok)
    {
      tokens[tokens.size] = token;
      token = "";
      continue;
    }

    token += c;
  }
  tokens[tokens.size] = token;

  return tokens;
}

parseTokensIntoWaypoint(tokens)
{
	waypoint = spawnStruct();

	orgStr = tokens[0];
	orgToks = strtok(orgStr, " ");
	waypoint.origin = (float(orgToks[0]), float(orgToks[1]), float(orgToks[2]));

	childStr = tokens[1];
	childToks = strtok(childStr, " ");
	waypoint.childCount = childToks.size;
	waypoint.children = [];
	for( j=0; j<childToks.size; j++ )
		waypoint.children[j] = int(childToks[j]);

	type = tokens[2];
	waypoint.type = type;

	anglesStr = tokens[3];
	if (isDefined(anglesStr) && anglesStr != "")
	{
		anglesToks = strtok(anglesStr, " ");
		waypoint.angles = (float(anglesToks[0]), float(anglesToks[1]), float(anglesToks[2]));
	}

	return waypoint;
}

readWpsFromFile(mapname)
{
	waypoints = [];
	filename = "waypoints/" + mapname + "_wp.csv";

	if (!FS_TestFile(filename))
		return waypoints;

	println("Attempting to read waypoints from " + filename);

	csv = FS_FOpen(filename, "read");

	for (;;)
	{
		waypointCount = int(FS_ReadLine(csv));
		if (waypointCount <= 0)
			break;

		for (i = 1; i <= waypointCount; i++)
		{
			line = FS_ReadLine(csv);
			tokens = tokenizeLine(line, ",");

			waypoint = parseTokensIntoWaypoint(tokens);

			waypoints[i-1] = waypoint;
		}

		break;
	}
	
	FS_FClose(csv);
	return waypoints;
}

/*
	Loads the waypoints. Populating everything needed for the waypoints.
*/
load_waypoints()
{
	mapname = getDvar("mapname");
	
	level.waypointCount = 0;
	level.waypoints = [];

	wps = readWpsFromFile(mapname);
	
	if (wps.size)
	{
		level.waypoints = wps;
		println("Loaded " + wps.size + " waypoints from file.");
	}
	else
	{
		switch(mapname)
		{
			case "mp_convoy":
				level.waypoints = maps\mp\bots\waypoints\ambush::Ambush();
			break;
			case "mp_backlot":
				level.waypoints = maps\mp\bots\waypoints\backlot::Backlot();
			break;
			case "mp_bloc":
				level.waypoints = maps\mp\bots\waypoints\bloc::Bloc();
			break;
			case "mp_bog":
				level.waypoints = maps\mp\bots\waypoints\bog::Bog();
			break;
			case "mp_countdown":
				level.waypoints = maps\mp\bots\waypoints\countdown::Countdown();
			break;
			case "mp_crash":
			case "mp_crash_snow":
				level.waypoints = maps\mp\bots\waypoints\crash::Crash();
			break;
			case "mp_crossfire":
				level.waypoints = maps\mp\bots\waypoints\crossfire::Crossfire();
			break;
			case "mp_citystreets":
				level.waypoints = maps\mp\bots\waypoints\district::District();
			break;
			case "mp_farm":
				level.waypoints = maps\mp\bots\waypoints\downpour::Downpour();
			break;
			case "mp_overgrown":
				level.waypoints = maps\mp\bots\waypoints\overgrown::Overgrown();
			break;
			case "mp_pipeline":
				level.waypoints = maps\mp\bots\waypoints\pipeline::Pipeline();
			break;
			case "mp_shipment":
				level.waypoints = maps\mp\bots\waypoints\shipment::Shipment();
			break;
			case "mp_showdown":
				level.waypoints = maps\mp\bots\waypoints\showdown::Showdown();
			break;
			case "mp_strike":
				level.waypoints = maps\mp\bots\waypoints\strike::Strike();
			break;
			case "mp_vacant":
				level.waypoints = maps\mp\bots\waypoints\vacant::Vacant();
			break;
			case "mp_cargoship":
				level.waypoints = maps\mp\bots\waypoints\wetwork::Wetwork();
			break;
			
			case "mp_broadcast":
				level.waypoints = maps\mp\bots\waypoints\broadcast::Broadcast();
			break;
			case "mp_creek":
				level.waypoints = maps\mp\bots\waypoints\creek::Creek();
			break;
			case "mp_carentan":
				level.waypoints = maps\mp\bots\waypoints\chinatown::Chinatown();
			break;
			case "mp_killhouse":
				level.waypoints = maps\mp\bots\waypoints\killhouse::Killhouse();
			break;
			
			default:
				maps\mp\bots\waypoints\_custom_map::main(mapname);
			break;
		}

		if (level.waypoints.size)
			println("Loaded " + level.waypoints.size + " waypoints from script.");
	}

	if (!level.waypoints.size)
	{
		maps\mp\bots\_bot_http::getRemoteWaypoints(mapname);
	}

	level.waypointCount = level.waypoints.size;
	
	for(i = 0; i < level.waypointCount; i++)
	{
		level.waypoints[i].index = i;
		level.waypoints[i].bots = [];
		level.waypoints[i].bots["allies"] = 1;
		level.waypoints[i].bots["axis"] = 1;

		level.waypoints[i].childCount = level.waypoints[i].children.size;
	}
	
	level.waypointsKDTree = WaypointsToKDTree();
	
	level.waypointsCamp = [];
	level.waypointsTube = [];
	level.waypointsGren = [];
	level.waypointsClay = [];
	
	for(i = 0; i < level.waypointCount; i++)
		if(level.waypoints[i].type == "crouch" && level.waypoints[i].childCount == 1)
			level.waypointsCamp[level.waypointsCamp.size] = level.waypoints[i];
		else if(level.waypoints[i].type == "tube")
			level.waypointsTube[level.waypointsTube.size] = level.waypoints[i];
		else if(level.waypoints[i].type == "grenade")
			level.waypointsGren[level.waypointsGren.size] = level.waypoints[i];
		else if(level.waypoints[i].type == "claymore")
			level.waypointsClay[level.waypointsClay.size] = level.waypoints[i];
}

/*
	Returns a good amount of players.
*/
getGoodMapAmount()
{
	switch(getDvar("mapname"))
	{
		case "mp_crash":
		case "mp_crash_snow":
		case "mp_countdown":
		case "mp_carentan":
		case "mp_creek":
		case "mp_broadcast":
		case "mp_cargoship":
		case "mp_pipeline":
		case "mp_overgrown":
		case "mp_strike":
		case "mp_farm":
		case "mp_crossfire":
		case "mp_backlot":
		case "mp_convoy":
		case "mp_bloc":
			if(level.teamBased)
				return 14;
			else
				return 9;
			
		case "mp_vacant":
		case "mp_showdown":
		case "mp_citystreets":
		case "mp_bog":
			if(level.teamBased)
				return 12;
			else
				return 8;
			
		case "mp_killhouse":
		case "mp_shipment":
			if(level.teamBased)
				return 8;
			else
				return 4;
	}
	
	return 2;
}

getMapName(map)
{
	switch(map)
	{
		case "mp_convoy":
			return "Ambush";
		case "mp_backlot":
			return "Backlot";
		case "mp_bloc":
			return "Bloc";
		case "mp_bog":
			return "Bog";
		case "mp_countdown":
			return "Countdown";
		case "mp_crash":
			return "Crash";
		case "mp_crash_snow":
			return "Winter Crash";
		case "mp_crossfire":
			return "Crossfire";
		case "mp_citystreets":
			return "District";
		case "mp_farm":
			return "Downpour";
		case "mp_overgrown":
			return "Overgrown";
		case "mp_pipeline":
			return "Pipeline";
		case "mp_shipment":
			return "Shipment";
		case "mp_showdown":
			return "Showdown";
		case "mp_strike":
			return "Strike";
		case "mp_vacant":
			return "Vacant";
		case "mp_cargoship":
			return "Wetwork";
		case "mp_broadcast":
			return "Broadcast";
		case "mp_creek":
			return "Creek";
		case "mp_carentan":
			return "Chinatown";
		case "mp_killhouse":
			return "Killhouse";
	}
	
	return map;
}

/*
	Returns an array of all the bots in the game.
*/
getBotArray()
{
	result = [];
	playercount = level.players.size;
	for(i = 0; i < playercount; i++)
	{
		player = level.players[i];
		
		if(!player is_bot())
			continue;
			
		result[result.size] = player;
	}
	
	return result;
}

/*
	We return a balanced KDTree from the waypoints.
*/
WaypointsToKDTree()
{
	kdTree = KDTree();
	
	kdTree _WaypointsToKDTree(level.waypoints, 0);
	
	return kdTree;
}

/*
	Recurive function. We construct a balanced KD tree by sorting the waypoints using heap sort.
*/
_WaypointsToKDTree(waypoints, dem)
{
	if(!waypoints.size)
		return;

	callbacksort = undefined;
	
	switch(dem)
	{
		case 0:
			callbacksort = ::HeapSortCoordX;
		break;
		case 1:
			callbacksort = ::HeapSortCoordY;
		break;
		case 2:
			callbacksort = ::HeapSortCoordZ;
		break;
	}
	
	heap = NewHeap(callbacksort);
	
	for(i = 0; i < waypoints.size; i++)
	{
		heap HeapInsert(waypoints[i]);
	}
	
	sorted = [];
	while(heap.data.size)
	{
		sorted[sorted.size] = heap.data[0];
		heap HeapRemove();
	}
	
	median = int(sorted.size/2);//use divide and conq
	
	left = [];
	right = [];
	for(i = 0; i < sorted.size; i++)
		if(i < median)
			right[right.size] = sorted[i];
		else if(i > median)
			left[left.size] = sorted[i];
	
	self KDTreeInsert(sorted[median]);
	
	_WaypointsToKDTree(left, (dem+1)%3);
	
	_WaypointsToKDTree(right, (dem+1)%3);
}

/*
	Returns a new list.
*/
List()
{
	list = spawnStruct();
	list.count = 0;
	list.data = [];
	
	return list;
}

/*
	Adds a new thing to the list.
*/
ListAdd(thing)
{
	self.data[self.count] = thing;
	
	self.count++;
}

/*
	Adds to the start of the list.
*/
ListAddFirst(thing)
{
	for (i = self.count - 1; i >= 0; i--)
	{
		self.data[i + 1] = self.data[i];
	}

	self.data[0] = thing;
	self.count++;
}

/*
	Removes the thing from the list.
*/
ListRemove(thing)
{
	for ( i = 0; i < self.count; i++ )
	{
		if ( self.data[i] == thing )
		{
			while ( i < self.count-1 )
			{
				self.data[i] = self.data[i+1];
				i++;
			}
			
			self.data[i] = undefined;
			self.count--;
			break;
		}
	}
}

/*
	Returns a new KDTree.
*/
KDTree()
{
	kdTree = spawnStruct();
	kdTree.root = undefined;
	kdTree.count = 0;
	
	return kdTree;
}

/*
	Called on a KDTree. Will insert the object into the KDTree.
*/
KDTreeInsert(data)//as long as what you insert has a .origin attru, it will work.
{
	self.root = self _KDTreeInsert(self.root, data, 0, -9999999999, -9999999999, -9999999999, 9999999999, 9999999999, 9999999999);
}

/*
	Recurive function that insert the object into the KDTree.
*/
_KDTreeInsert(node, data, dem, x0, y0, z0, x1, y1, z1)
{
	if(!isDefined(node))
	{
		r = spawnStruct();
		r.data = data;
		r.left = undefined;
		r.right = undefined;
		r.x0 = x0;
		r.x1 = x1;
		r.y0 = y0;
		r.y1 = y1;
		r.z0 = z0;
		r.z1 = z1;
		
		self.count++;
		
		return r;
	}
	
	switch(dem)
	{
		case 0:
			if(data.origin[0] < node.data.origin[0])
				node.left = self _KDTreeInsert(node.left, data, 1, x0, y0, z0, node.data.origin[0], y1, z1);
			else
				node.right = self _KDTreeInsert(node.right, data, 1, node.data.origin[0], y0, z0, x1, y1, z1);
		break;
		case 1:
			if(data.origin[1] < node.data.origin[1])
				node.left = self _KDTreeInsert(node.left, data, 2, x0, y0, z0, x1, node.data.origin[1], z1);
			else
				node.right = self _KDTreeInsert(node.right, data, 2, x0, node.data.origin[1], z0, x1, y1, z1);
		break;
		case 2:
			if(data.origin[2] < node.data.origin[2])
				node.left = self _KDTreeInsert(node.left, data, 0, x0, y0, z0, x1, y1, node.data.origin[2]);
			else
				node.right = self _KDTreeInsert(node.right, data, 0, x0, y0, node.data.origin[2], x1, y1, z1);
		break;
	}
	
	return node;
}

/*
	Called on a KDTree, will return the nearest object to the given origin.
*/
KDTreeNearest(origin)
{
	if(!isDefined(self.root))
		return undefined;
	
	return self _KDTreeNearest(self.root, origin, self.root.data, DistanceSquared(self.root.data.origin, origin), 0);
}

/*
	Recurive function that will retrieve the closest object to the query.
*/
_KDTreeNearest(node, point, closest, closestdist, dem)
{
	if(!isDefined(node))
	{
		return closest;
	}
	
	thisDis = DistanceSquared(node.data.origin, point);
	
	if(thisDis < closestdist)
	{
		closestdist = thisDis;
		closest = node.data;
	}
	
	if(node RectDistanceSquared(point) < closestdist)
	{
		near = node.left;
		far = node.right;
		if(point[dem] > node.data.origin[dem])
		{
			near = node.right;
			far = node.left;
		}
		
		closest = self _KDTreeNearest(near, point, closest, closestdist, (dem+1)%3);
		
		closest = self _KDTreeNearest(far, point, closest, DistanceSquared(closest.origin, point), (dem+1)%3);
	}
	
	return closest;
}

/*
	Called on a rectangle, returns the distance from origin to the rectangle.
*/
RectDistanceSquared(origin)
{
	dx = 0;
	dy = 0;
	dz = 0;
	
	if(origin[0] < self.x0)
		dx = origin[0] - self.x0;
	else if(origin[0] > self.x1)
		dx = origin[0] - self.x1;
		
	if(origin[1] < self.y0)
		dy = origin[1] - self.y0;
	else if(origin[1] > self.y1)
		dy = origin[1] - self.y1;

		
	if(origin[2] < self.z0)
		dz = origin[2] - self.z0;
	else if(origin[2] > self.z1)
		dz = origin[2] - self.z1;
		
	return dx*dx + dy*dy + dz*dz;
}

/*
	A heap invarient comparitor, used for objects, objects with a higher X coord will be first in the heap.
*/
HeapSortCoordX(item, item2)
{
	return item.origin[0] > item2.origin[0];
}

/*
	A heap invarient comparitor, used for objects, objects with a higher Y coord will be first in the heap.
*/
HeapSortCoordY(item, item2)
{
	return item.origin[1] > item2.origin[1];
}

/*
	A heap invarient comparitor, used for objects, objects with a higher Z coord will be first in the heap.
*/
HeapSortCoordZ(item, item2)
{
	return item.origin[2] > item2.origin[2];
}

/*
	A heap invarient comparitor, used for numbers, numbers with the highest number will be first in the heap.
*/
Heap(item, item2)
{
	return item > item2;
}

/*
	A heap invarient comparitor, used for numbers, numbers with the lowest number will be first in the heap.
*/
ReverseHeap(item, item2)
{
	return item < item2;
}

/*
	A heap invarient comparitor, used for traces. Wanting the trace with the largest length first in the heap.
*/
HeapTraceFraction(item, item2)
{
	return item["fraction"] > item2["fraction"];
}

/*
	Returns a new heap.
*/
NewHeap(compare)
{
	heap_node = spawnStruct();
	heap_node.data = [];
	heap_node.compare = compare;
	
	return heap_node;
}

/*
	Inserts the item into the heap. Called on a heap.
*/
HeapInsert(item)
{
	insert = self.data.size;
	self.data[insert] = item;
	
	current = insert+1;
	
	while(current > 1)
	{
		last = current;
		current = int(current/2);
		
		if(![[self.compare]](item, self.data[current-1]))
			break;
			
		self.data[last-1] = self.data[current-1];
		self.data[current-1] = item;
	}
}

/*
	Helper function to determine what is the next child of the bst.
*/
_HeapNextChild(node, hsize)
{
	left = node * 2;
	right = left + 1;
	
	if(left > hsize)
		return -1;
		
	if(right > hsize)
		return left;
		
	if([[self.compare]](self.data[left-1], self.data[right-1]))
		return left;
	else
		return right;
}

/*
	Removes an item from the heap. Called on a heap.
*/
HeapRemove()
{
	remove = self.data.size;
	
	if(!remove)
		return remove;
	
	move = self.data[remove-1];
	self.data[0] = move;
	self.data[remove-1] = undefined;
	remove--;
	
	if(!remove)
		return remove;
	
	last = 1;
	next = self _HeapNextChild(1, remove);
	
	while(next != -1)
	{
		if([[self.compare]](move, self.data[next-1]))
			break;
			
		self.data[last-1] = self.data[next-1];
		self.data[next-1] = move;
		
		last = next;
		next = self _HeapNextChild(next, remove);
	}
	
	return remove;
}

/*
	A heap invarient comparitor, used for the astar's nodes, wanting the node with the lowest f to be first in the heap.
*/
ReverseHeapAStar(item, item2)
{
	return item.f < item2.f;
}

/*
	Will linearly search for the nearest waypoint to pos that has a direct line of sight.
*/
GetNearestWaypointWithSight(pos)
{
	candidate = undefined;
	dist = 9999999999;
	
	for(i = 0; i < level.waypointCount; i++)
	{
		if(!bulletTracePassed(pos + (0, 0, 15), level.waypoints[i].origin + (0, 0, 15), false, undefined))
			continue;
		
		curdis = DistanceSquared(level.waypoints[i].origin, pos);
		if(curdis > dist)
			continue;
			
		dist = curdis;
		candidate = level.waypoints[i];
	}
	
	return candidate;
}

/*
	Modified Pezbot astar search.
	This makes use of sets for quick look up and a heap for a priority queue instead of simple lists which require to linearly search for elements everytime.
	Also makes use of the KD tree to search for the nearest node to the goal. We only use the closest node from the KD tree if it has a direct line of sight, else we will have to linearly search for one that we have a line of sight on.
	It is also modified to make paths with bots already on more expensive and will try a less congested path first. Thus spliting up the bots onto more paths instead of just one (the smallest).
*/
AStarSearch(start, goal, team, greedy_path)
{
	open = NewHeap(::ReverseHeapAStar);//heap
	openset = [];//set for quick lookup
	
	closed = [];//set for quick lookup
	
	startwp = level.waypointsKDTree KDTreeNearest(start);//balanced kdtree, for nns
	if(!isDefined(startwp))
		return [];
	_startwp = undefined;
	if(!bulletTracePassed(start + (0, 0, 15), startwp.origin + (0, 0, 15), false, undefined))
		_startwp = GetNearestWaypointWithSight(start);
	if(isDefined(_startwp))
		startwp = _startwp;
	startwp = startwp.index;
	
	goalwp = level.waypointsKDTree KDTreeNearest(goal);
	if(!isDefined(goalwp))
		return [];
	_goalwp = undefined;
	if(!bulletTracePassed(goal + (0, 0, 15), goalwp.origin + (0, 0, 15), false, undefined))
		_goalwp = GetNearestWaypointWithSight(goal);
	if(isDefined(_goalwp))
		goalwp = _goalwp;
	goalwp = goalwp.index;
	
	goalorg = level.waypoints[goalWp].origin;
	
	node = spawnStruct();
	node.g = 0; //path dist so far
	node.h = DistanceSquared(level.waypoints[startWp].origin, goalorg); //herustic, distance to goal for path finding
	//node.f = node.h + node.g; // combine path dist and heru, use reverse heap to sort the priority queue by this attru
	node.f = node.h;
	node.index = startwp;
	node.parent = undefined; //we are start, so we have no parent
	
	//push node onto queue
	openset[node.index] = node;
	open HeapInsert(node);
	
	//while the queue is not empty
	while(open.data.size)
	{
		//pop bestnode from queue
		bestNode = open.data[0];
		open HeapRemove();
		openset[bestNode.index] = undefined;
		
		//check if we made it to the goal
		if(bestNode.index == goalwp)
		{
			path = [];
		
			while(isDefined(bestNode))
			{
				if(isdefined(team))
					level.waypoints[bestNode.index].bots[team]++;
					
				//construct path
				path[path.size] = bestNode.index;
				
				bestNode = bestNode.parent;
			}
			
			return path;
		}
		
		nodeorg = level.waypoints[bestNode.index].origin;
		childcount = level.waypoints[bestNode.index].childCount;
		//for each child of bestnode
		for(i = 0; i < childcount; i++)
		{
			child = level.waypoints[bestNode.index].children[i];
			childorg = level.waypoints[child].origin;
			
			penalty = 1;
			if(!greedy_path && isdefined(team))
			{
				temppen = level.waypoints[child].bots[team];//consider how many bots are taking this path
				if(temppen > 1)
					penalty = temppen;
			}
			
			//calc the total path we have took
			newg = bestNode.g + DistanceSquared(nodeorg, childorg)*penalty;//bots on same team's path are more expensive
			
			//check if this child is in open or close with a g value less than newg
			inopen = isDefined(openset[child]);
			if(inopen && openset[child].g <= newg)
				continue;
			
			inclosed = isDefined(closed[child]);
			if(inclosed && closed[child].g <= newg)
				continue;
			
			if(inopen)
				node = openset[child];
			else if(inclosed)
				node = closed[child];
			else
				node = spawnStruct();
				
			node.parent = bestNode;
			node.g = newg;
			node.h = DistanceSquared(childorg, goalorg);
			node.f = node.g + node.h;
			node.index = child;
			
			//check if in closed, remove it
			if(inclosed)
				closed[child] = undefined;
			
			//check if not in open, add it
			if(!inopen)
			{
				open HeapInsert(node);
				openset[child] = node;
			}
		}
		
		//done with children, push onto closed
		closed[bestNode.index] = bestNode;
	}
	
	return [];
}

/*
	Returns the natural log of x using harmonic series.
*/
Log(x)
{
	/*if (!isDefined(level.log_cache))
		level.log_cache = [];
	
	key = x + "";
	
	if (isDefined(level.log_cache[key]))
		return level.log_cache[key];*/

	//thanks Bob__ at stackoverflow
	old_sum = 0.0;
	xmlxpl = (x - 1) / (x + 1);
	xmlxpl_2 = xmlxpl * xmlxpl;
	denom = 1.0;
	frac = xmlxpl;
	sum = frac;

	while ( sum != old_sum )
	{
		old_sum = sum;
		denom += 2.0;
		frac *= xmlxpl_2;
		sum += frac / denom;
	}
	
	answer = 2.0 * sum;
	
	//level.log_cache[key] = answer;
	return answer;
}

/*
	Taken from t5 gsc.
*/
array_combine( array1, array2 )
{
	if( !array1.size )
	{
		return array2; 
	}
	array3 = [];
	keys = GetArrayKeys( array1 );
	for( i = 0;i < keys.size;i++ )
	{
		key = keys[ i ];
		array3[ array3.size ] = array1[ key ]; 
	}	
	keys = GetArrayKeys( array2 );
	for( i = 0;i < keys.size;i++ )
	{
		key = keys[ i ];
		array3[ array3.size ] = array2[ key ];
	}
	return array3; 
}

/*
	Taken from t5 gsc.
	Returns an array of number's average.
*/
array_average( array )
{
	assert( IsArray( array ) );
	assert( array.size > 0 );
	total = 0;
	for ( i = 0; i < array.size; i++ )
	{
		total += array[i];
	}
	return ( total / array.size );
}

/*
	Taken from t5 gsc.
	Returns an array of number's standard deviation.
*/
array_std_deviation( array, mean )
{
	assert( IsArray( array ) );
	assert( array.size > 0 );
	tmp = [];
	for ( i = 0; i < array.size; i++ )
	{
		tmp[i] = ( array[i] - mean ) * ( array[i] - mean );
	}
	total = 0;
	for ( i = 0; i < tmp.size; i++ )
	{
		total = total + tmp[i];
	}
	return Sqrt( total / array.size );
}

/*
	Taken from t5 gsc.
	Will produce a random number between lower_bound and upper_bound but with a bell curve distribution (more likely to be close to the mean).
*/
random_normal_distribution( mean, std_deviation, lower_bound, upper_bound )
{
	x1 = 0;
	x2 = 0;
	w = 1;
	y1 = 0;
	while ( w >= 1 )
	{
		x1 = 2 * RandomFloatRange( 0, 1 ) - 1;
		x2 = 2 * RandomFloatRange( 0, 1 ) - 1;
		w = x1 * x1 + x2 * x2;
	}
	w = Sqrt( ( -2.0 * Log( w ) ) / w );
	y1 = x1 * w;
	number = mean + y1 * std_deviation;
	if ( IsDefined( lower_bound ) && number < lower_bound )
	{
		number = lower_bound;
	}
	if ( IsDefined( upper_bound ) && number > upper_bound )
	{
		number = upper_bound;
	}
	
	return( number );
}

/*
	We patch the bomb planted for sd so we have access to defuseObject.
*/
onUsePlantObjectFix( player )
{
	// planted the bomb
	if ( !self maps\mp\gametypes\_gameobjects::isFriendlyTeam( player.pers["team"] ) )
	{
		level thread bombPlantedFix( self, player );
		player logString( "bomb planted: " + self.label );
		
		// disable all bomb zones except this one
		for ( index = 0; index < level.bombZones.size; index++ )
		{
			if ( level.bombZones[index] == self )
				continue;
				
			level.bombZones[index] maps\mp\gametypes\_gameobjects::disableObject();
		}
		
		player playSound( "mp_bomb_plant" );
		player notify ( "bomb_planted" );
		if ( !level.hardcoreMode )
			iPrintLn( &"MP_EXPLOSIVES_PLANTED_BY", player );
		maps\mp\gametypes\_globallogic::leaderDialog( "bomb_planted" );

		maps\mp\gametypes\_globallogic::givePlayerScore( "plant", player );
		player thread [[level.onXPEvent]]( "plant" );
	}
}

/*
	We patch the bomb planted for sd so we have access to defuseObject.
*/
bombPlantedFix( destroyedObj, player )
{
	maps\mp\gametypes\_globallogic::pauseTimer();
	level.bombPlanted = true;
	
	destroyedObj.visuals[0] thread maps\mp\gametypes\_globallogic::playTickingSound();
	level.tickingObject = destroyedObj.visuals[0];

	level.timeLimitOverride = true;
	setGameEndTime( int( gettime() + (level.bombTimer * 1000) ) );
	setDvar( "ui_bomb_timer", 1 );
	
	if ( !level.multiBomb )
	{
		level.sdBomb maps\mp\gametypes\_gameobjects::allowCarry( "none" );
		level.sdBomb maps\mp\gametypes\_gameobjects::setVisibleTeam( "none" );
		level.sdBomb maps\mp\gametypes\_gameobjects::setDropped();
		level.sdBombModel = level.sdBomb.visuals[0];
	}
	else
	{
		
		for ( index = 0; index < level.players.size; index++ )
		{
			if ( isDefined( level.players[index].carryIcon ) )
				level.players[index].carryIcon destroyElem();
		}

		trace = bulletTrace( player.origin + (0,0,20), player.origin - (0,0,2000), false, player );
		
		tempAngle = randomfloat( 360 );
		forward = (cos( tempAngle ), sin( tempAngle ), 0);
		forward = vectornormalize( forward - vector_scale( trace["normal"], vectordot( forward, trace["normal"] ) ) );
		dropAngles = vectortoangles( forward );
		
		level.sdBombModel = spawn( "script_model", trace["position"] );
		level.sdBombModel.angles = dropAngles;
		level.sdBombModel setModel( "prop_suitcase_bomb" );
	}
	destroyedObj maps\mp\gametypes\_gameobjects::allowUse( "none" );
	destroyedObj maps\mp\gametypes\_gameobjects::setVisibleTeam( "none" );
	/*
	destroyedObj maps\mp\gametypes\_gameobjects::set2DIcon( "friendly", undefined );
	destroyedObj maps\mp\gametypes\_gameobjects::set2DIcon( "enemy", undefined );
	destroyedObj maps\mp\gametypes\_gameobjects::set3DIcon( "friendly", undefined );
	destroyedObj maps\mp\gametypes\_gameobjects::set3DIcon( "enemy", undefined );
	*/
	label = destroyedObj maps\mp\gametypes\_gameobjects::getLabel();
	
	// create a new object to defuse with.
	trigger = destroyedObj.bombDefuseTrig;
	trigger.origin = level.sdBombModel.origin;
	visuals = [];
	defuseObject = maps\mp\gametypes\_gameobjects::createUseObject( game["defenders"], trigger, visuals, (0,0,32) );
	defuseObject maps\mp\gametypes\_gameobjects::allowUse( "friendly" );
	defuseObject maps\mp\gametypes\_gameobjects::setUseTime( level.defuseTime );
	defuseObject maps\mp\gametypes\_gameobjects::setUseText( &"MP_DEFUSING_EXPLOSIVE" );
	defuseObject maps\mp\gametypes\_gameobjects::setUseHintText( &"PLATFORM_HOLD_TO_DEFUSE_EXPLOSIVES" );
	defuseObject maps\mp\gametypes\_gameobjects::setVisibleTeam( "any" );
	defuseObject maps\mp\gametypes\_gameobjects::set2DIcon( "friendly", "compass_waypoint_defuse" + label );
	defuseObject maps\mp\gametypes\_gameobjects::set2DIcon( "enemy", "compass_waypoint_defend" + label );
	defuseObject maps\mp\gametypes\_gameobjects::set3DIcon( "friendly", "waypoint_defuse" + label );
	defuseObject maps\mp\gametypes\_gameobjects::set3DIcon( "enemy", "waypoint_defend" + label );
	defuseObject.label = label;
	defuseObject.onBeginUse = maps\mp\gametypes\sd::onBeginUse;
	defuseObject.onEndUse = maps\mp\gametypes\sd::onEndUse;
	defuseObject.onUse = maps\mp\gametypes\sd::onUseDefuseObject;
	defuseObject.useWeapon = "briefcase_bomb_defuse_mp";
	
	level.defuseObject = defuseObject;
	
	maps\mp\gametypes\sd::BombTimerWait();
	setDvar( "ui_bomb_timer", 0 );
	
	destroyedObj.visuals[0] maps\mp\gametypes\_globallogic::stopTickingSound();
	
	if ( level.gameEnded || level.bombDefused )
		return;
	
	level.bombExploded = true;
	
	explosionOrigin = level.sdBombModel.origin;
	level.sdBombModel hide();
	
	if ( isdefined( player ) )
		destroyedObj.visuals[0] radiusDamage( explosionOrigin, 512, 200, 20, player );
	else
		destroyedObj.visuals[0] radiusDamage( explosionOrigin, 512, 200, 20 );
	
	rot = randomfloat(360);
	explosionEffect = spawnFx( level._effect["bombexplosion"], explosionOrigin + (0,0,50), (0,0,1), (cos(rot),sin(rot),0) );
	triggerFx( explosionEffect );
	
	thread maps\mp\gametypes\sd::playSoundinSpace( "exp_suitcase_bomb_main", explosionOrigin );
	
	if ( isDefined( destroyedObj.exploderIndex ) )
		exploder( destroyedObj.exploderIndex );
	
	for ( index = 0; index < level.bombZones.size; index++ )
		level.bombZones[index] maps\mp\gametypes\_gameobjects::disableObject();
	defuseObject maps\mp\gametypes\_gameobjects::disableObject();
	
	setGameEndTime( 0 );
	
	wait 3;
	
	maps\mp\gametypes\sd::sd_endGame( game["attackers"], game["strings"]["target_destroyed"] );
}
