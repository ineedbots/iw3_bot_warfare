#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;

/*
	Waits for the built-ins to be defined
*/
wait_for_builtins()
{
	for ( i = 0; i < 20; i++ )
	{
		if ( isdefined( level.bot_builtins ) )
		{
			return true;
		}
		
		if ( i < 18 )
		{
			waittillframeend;
		}
		else
		{
			wait 0.05;
		}
	}
	
	return false;
}

/*
	Prints to console without dev script on
*/
BotBuiltinPrintConsole( s )
{
	if ( isdefined( level.bot_builtins ) && isdefined( level.bot_builtins[ "printconsole" ] ) )
	{
		[[ level.bot_builtins[ "printconsole" ] ]]( s );
	}
}

/*
	Writes to the file, mode can be "append" or "write"
*/
BotBuiltinFileWrite( file, contents, mode )
{
	if ( isdefined( level.bot_builtins ) && isdefined( level.bot_builtins[ "filewrite" ] ) )
	{
		[[ level.bot_builtins[ "filewrite" ] ]]( file, contents, mode );
	}
}

/*
	Returns the whole file as a string
*/
BotBuiltinFileRead( file )
{
	if ( isdefined( level.bot_builtins ) && isdefined( level.bot_builtins[ "fileread" ] ) )
	{
		return [[ level.bot_builtins[ "fileread" ] ]]( file );
	}
	
	return undefined;
}

/*
	Test if a file exists
*/
BotBuiltinFileExists( file )
{
	if ( isdefined( level.bot_builtins ) && isdefined( level.bot_builtins[ "fileexists" ] ) )
	{
		return [[ level.bot_builtins[ "fileexists" ] ]]( file );
	}
	
	return false;
}

/*
	Bot action, does a bot action
	<client> botaction(<action string (+ or - then action like frag or smoke)>)
*/
BotBuiltinBotAction( action )
{
	if ( isdefined( level.bot_builtins ) && isdefined( level.bot_builtins[ "botaction" ] ) )
	{
		self [[ level.bot_builtins[ "botaction" ] ]]( action );
	}
}

/*
	Clears the bot from movement and actions
	<client> botstop()
*/
BotBuiltinBotStop()
{
	if ( isdefined( level.bot_builtins ) && isdefined( level.bot_builtins[ "botstop" ] ) )
	{
		self [[ level.bot_builtins[ "botstop" ] ]]();
	}
}

/*
	Sets the bot's movement
	<client> botmovement(<int forward>, <int right>)
*/
BotBuiltinBotMovement( forward, right )
{
	if ( isdefined( level.bot_builtins ) && isdefined( level.bot_builtins[ "botmovement" ] ) )
	{
		self [[ level.bot_builtins[ "botmovement" ] ]]( forward, right );
	}
}

/*
	Cod4x built-in
*/
BotBuiltinBotMoveTo( where )
{
	if ( isdefined( level.bot_builtins ) && isdefined( level.bot_builtins[ "botmoveto" ] ) )
	{
		self [[ level.bot_builtins[ "botmoveto" ] ]]( where );
	}
}

/*
	Sets melee params
*/
BotBuiltinBotMeleeParams( yaw, dist )
{
	if ( isdefined( level.bot_builtins ) && isdefined( level.bot_builtins[ "botmeleeparams" ] ) )
	{
		self [[ level.bot_builtins[ "botmeleeparams" ] ]]( yaw, dist );
	}
}

/*
	Test if is a bot
*/
BotBuiltinIsBot()
{
	if ( isdefined( level.bot_builtins ) && isdefined( level.bot_builtins[ "isbot" ] ) )
	{
		return self [[ level.bot_builtins[ "isbot" ] ]]();
	}
	
	return false;
}

/*
	Opens the file
*/
BotBuiltinFileOpen( file, mode )
{
	if ( isdefined( level.bot_builtins ) && isdefined( level.bot_builtins[ "fs_fopen" ] ) )
	{
		return [[ level.bot_builtins[ "fs_fopen" ] ]]( file, mode );
	}
	
	return 0;
}

/*
	Closes the file
*/
BotBuiltinFileClose( fh )
{
	if ( isdefined( level.bot_builtins ) && isdefined( level.bot_builtins[ "fs_fclose" ] ) )
	{
		[[ level.bot_builtins[ "fs_fclose" ] ]]( fh );
	}
}

/*
	Closes the file
*/
BotBuiltinReadLine( fh )
{
	if ( isdefined( level.bot_builtins ) && isdefined( level.bot_builtins[ "fs_readline" ] ) )
	{
		return [[ level.bot_builtins[ "fs_readline" ] ]]( fh );
	}
	
	return undefined;
}

/*
	Closes the file
*/
BotBuiltinWriteLine( fh, contents )
{
	if ( isdefined( level.bot_builtins ) && isdefined( level.bot_builtins[ "fs_writeline" ] ) )
	{
		[[ level.bot_builtins[ "fs_writeline" ] ]]( fh, contents );
	}
}

/*
	Returns if player is the host
*/
is_host()
{
	return ( isdefined( self.pers[ "bot_host" ] ) && self.pers[ "bot_host" ] );
}

/*
	Setups the host variable on the player
*/
doHostCheck()
{
	self.pers[ "bot_host" ] = false;
	
	if ( self is_bot() )
	{
		return;
	}
	
	result = false;
	
	if ( getdvar( "bots_main_firstIsHost" ) != "0" )
	{
		BotBuiltinPrintConsole( "WARNING: bots_main_firstIsHost is enabled" );
		
		if ( getdvar( "bots_main_firstIsHost" ) == "1" )
		{
			setdvar( "bots_main_firstIsHost", self getguid() );
		}
		
		if ( getdvar( "bots_main_firstIsHost" ) == self getguid() + "" )
		{
			result = true;
		}
	}
	
	DvarGUID = getdvar( "bots_main_GUIDs" );
	
	if ( DvarGUID != "" )
	{
		guids = strtok( DvarGUID, "," );
		
		for ( i = 0; i < guids.size; i++ )
		{
			if ( self getguid() + "" == guids[ i ] )
			{
				result = true;
			}
		}
	}
	
	if ( !result )
	{
		return;
	}
	
	self.pers[ "bot_host" ] = true;
}

/*
	Returns if the player is a bot.
*/
is_bot()
{
	return self BotBuiltinIsBot();
}

/*
	Set the bot's stance
*/
BotSetStance( stance )
{
	switch ( stance )
	{
		case "stand":
			self maps\mp\bots\_bot_internal::stand();
			break;
			
		case "crouch":
			self maps\mp\bots\_bot_internal::crouch();
			break;
			
		case "prone":
			self maps\mp\bots\_bot_internal::prone();
			break;
	}
}

/*
	Bot presses the button for time.
*/
BotPressAttack( time )
{
	self maps\mp\bots\_bot_internal::pressFire( time );
}

/*
	Bot presses the ads button for time.
*/
BotPressADS( time )
{
	self maps\mp\bots\_bot_internal::pressADS( time );
}

/*
	Bot presses the use button for time.
*/
BotPressUse( time )
{
	self maps\mp\bots\_bot_internal::use( time );
}

/*
	Bot presses the frag button for time.
*/
BotPressFrag( time )
{
	self maps\mp\bots\_bot_internal::frag( time );
}

/*
	Bot presses the smoke button for time.
*/
BotPressSmoke( time )
{
	self maps\mp\bots\_bot_internal::smoke( time );
}

/*
	Returns the bot's random assigned number.
*/
BotGetRandom()
{
	return self.bot.rand;
}

/*
	Returns a random number thats different everytime it changes target
*/
BotGetTargetRandom()
{
	if ( !isdefined( self.bot.target ) )
	{
		return undefined;
	}
	
	return self.bot.target.rand;
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
	Is bot knifing
*/
IsBotKnifing()
{
	return self.bot.isknifingafter;
}

/*
	If the model of the player is good
*/
IsPlayerModelOK()
{
	return ( isdefined( self.bot_model_fix ) );
}

/*
	Freezes the bot's controls.
*/
BotFreezeControls( what )
{
	self.bot.isfrozen = what;
	
	if ( what )
	{
		self notify( "kill_goal" );
	}
}

/*
	Returns if the bot is script frozen.
*/
BotIsFrozen()
{
	return self.bot.isfrozen;
}

/*
	Bot will stop moving
*/
BotStopMoving( what )
{
	self.bot.stop_move = what;
	
	if ( what )
	{
		self notify( "kill_goal" );
	}
}

/*
	Notify the bot chat message
*/
BotNotifyBotEvent( msg, a, b, c, d, e, f, g )
{
	self notify( "bot_event", msg, a, b, c, d, e, f, g );
}

/*
	Returns if the bot has a script goal.
	(like t5 gsc bot)
*/
HasScriptGoal()
{
	return ( isdefined( self GetScriptGoal() ) );
}

/*
	Returns the pos of the bot's goal
*/
GetScriptGoal()
{
	return self.bot.script_goal;
}

/*
	Sets the bot's goal, will acheive it when dist away from it.
*/
SetScriptGoal( goal, dist )
{
	if ( !isdefined( dist ) )
	{
		dist = 16;
	}
	
	self.bot.script_goal = goal;
	self.bot.script_goal_dist = dist;
	waittillframeend;
	self notify( "new_goal_internal" );
	self notify( "new_goal" );
}

/*
	Clears the bot's goal.
*/
ClearScriptGoal()
{
	self SetScriptGoal( undefined, 0 );
}

/*
	Returns whether the bot has a priority objective
*/
HasPriorityObjective()
{
	return self.bot.prio_objective;
}

/*
	Sets the bot to prioritize the objective over targeting enemies
*/
SetPriorityObjective()
{
	self.bot.prio_objective = true;
	self notify( "kill_goal" );
}

/*
	Clears the bot's priority objective to allow the bot to target enemies automatically again
*/
ClearPriorityObjective()
{
	self.bot.prio_objective = false;
	self notify( "kill_goal" );
}

/*
	Sets the aim position of the bot
*/
SetScriptAimPos( pos )
{
	self.bot.script_aimpos = pos;
}

/*
	Clears the aim position of the bot
*/
ClearScriptAimPos()
{
	self SetScriptAimPos( undefined );
}

/*
	Returns the aim position of the bot
*/
GetScriptAimPos()
{
	return self.bot.script_aimpos;
}

/*
	Returns if the bot has a aim pos
*/
HasScriptAimPos()
{
	return isdefined( self GetScriptAimPos() );
}

/*
	Sets the bot's target to be this ent.
*/
SetAttacker( att )
{
	self.bot.target_this_frame = att;
}

/*
	Sets the script enemy for a bot.
*/
SetScriptEnemy( enemy, offset )
{
	self.bot.script_target = enemy;
	self.bot.script_target_offset = offset;
}

/*
	Removes the script enemy of the bot.
*/
ClearScriptEnemy()
{
	self SetScriptEnemy( undefined, undefined );
}

/*
	Returns the entity of the bot's target.
*/
getThreat()
{
	if ( !isdefined( self.bot.target ) )
	{
		return undefined;
	}
	
	return self.bot.target.entity;
}

/*
	Returns if the bot has a script enemy.
*/
HasScriptEnemy()
{
	return ( isdefined( self.bot.script_target ) );
}

/*
	Returns if the bot has a threat.
*/
HasThreat()
{
	return ( isdefined( self getThreat() ) );
}

/*
	If the player is defusing
*/
isDefusing()
{
	return ( isdefined( self.isdefusing ) && self.isdefusing );
}

/*
	If the play is planting
*/
isPlanting()
{
	return ( isdefined( self.isplanting ) && self.isplanting );
}

/*
	If the player is in laststand
*/
inLastStand()
{
	return ( isdefined( self.laststand ) && self.laststand );
}

/*
	If the player is carrying a bomb
*/
isBombCarrier()
{
	return ( isdefined( self.isbombcarrier ) && self.isbombcarrier );
}

/*
	If the site is in use
*/
isInUse()
{
	return ( isdefined( self.inuse ) && self.inuse );
}

/*
	Returns if we are stunned.
*/
IsStunned()
{
	return ( isdefined( self.concussionendtime ) && self.concussionendtime > gettime() );
}

/*
	Returns if we are beingArtilleryShellshocked
*/
isArtShocked()
{
	return ( isdefined( self.beingartilleryshellshocked ) && self.beingartilleryshellshocked );
}

/*
	Returns a valid grenade launcher weapon
*/
getValidTube()
{
	weaps = self getweaponslist();
	
	for ( i = 0; i < weaps.size; i++ )
	{
		weap = weaps[ i ];
		
		if ( !self getammocount( weap ) )
		{
			continue;
		}
		
		if ( issubstr( weap, "gl_" ) && !issubstr( weap, "_gl_" ) )
		{
			return weap;
		}
	}
	
	return undefined;
}

/*
	Returns a random grenade in the bot's inventory.
*/
getValidGrenade()
{
	grenadeTypes = [];
	grenadeTypes[ grenadeTypes.size ] = "frag_grenade_mp";
	grenadeTypes[ grenadeTypes.size ] = "smoke_grenade_mp";
	grenadeTypes[ grenadeTypes.size ] = "flash_grenade_mp";
	grenadeTypes[ grenadeTypes.size ] = "concussion_grenade_mp";
	
	possibles = [];
	
	for ( i = 0; i < grenadeTypes.size; i++ )
	{
		if ( !self hasweapon( grenadeTypes[ i ] ) )
		{
			continue;
		}
		
		if ( !self getammocount( grenadeTypes[ i ] ) )
		{
			continue;
		}
		
		possibles[ possibles.size ] = grenadeTypes[ i ];
	}
	
	return random( possibles );
}

/*
	CoD4 meme
*/
getWinningTeam()
{
	if ( maps\mp\gametypes\_globallogic::getgamescore( "allies" ) == maps\mp\gametypes\_globallogic::getgamescore( "axis" ) )
	{
		winner = "tie";
	}
	else if ( maps\mp\gametypes\_globallogic::getgamescore( "allies" ) > maps\mp\gametypes\_globallogic::getgamescore( "axis" ) )
	{
		winner = "allies";
	}
	else
	{
		winner = "axis";
	}
	
	return winner;
}

/*
	CoD4
*/
getBaseWeaponName( weap )
{
	return strtok( weap, "_" )[ 0 ];
}

/*
	Returns if the given weapon is full auto.
*/
WeaponIsFullAuto( weap )
{
	weaptoks = strtok( weap, "_" );
	
	return isdefined( weaptoks[ 0 ] ) && isstring( weaptoks[ 0 ] ) && isdefined( level.bots_fullautoguns[ weaptoks[ 0 ] ] );
}

/*
	Returns what our eye height is.
*/
getEyeHeight()
{
	stance = self getstance();
	
	if ( self inLastStand() || stance == "prone" )
	{
		return 11;
	}
	
	if ( stance == "crouch" )
	{
		return 40;
	}
	
	return 60;
}

/*
	Returns (iw4) eye pos.
*/
getEyePos()
{
	return self.origin + ( 0, 0, self getEyeHeight() );
}

/*
	helper
*/
waittill_either_return_( str1, str2 )
{
	self endon( str1 );
	self waittill( str2 );
	return true;
}

/*
	Returns which string gets notified first
*/
waittill_either_return( str1, str2 )
{
	if ( !isdefined( self waittill_either_return_( str1, str2 ) ) )
	{
		return str1;
	}
	
	return str2;
}

/*
	Waits until either of the nots.
*/
waittill_either( not, not1 )
{
	self endon( not );
	self waittill( not1 );
}

/*
	iw5
*/
allowClassChoice()
{
	return true;
}

/*
	iw5
*/
allowTeamChoice()
{
	return true;
}

/*
	Taken from iw4 script
*/
waittill_any_timeout( timeOut, string1, string2, string3, string4, string5 )
{
	if ( ( !isdefined( string1 ) || string1 != "death" ) && ( !isdefined( string2 ) || string2 != "death" ) && ( !isdefined( string3 ) || string3 != "death" ) && ( !isdefined( string4 ) || string4 != "death" ) && ( !isdefined( string5 ) || string5 != "death" ) )
	{
		self endon( "death" );
	}
	
	ent = spawnstruct();
	
	if ( isdefined( string1 ) )
	{
		self thread waittill_string( string1, ent );
	}
	
	if ( isdefined( string2 ) )
	{
		self thread waittill_string( string2, ent );
	}
	
	if ( isdefined( string3 ) )
	{
		self thread waittill_string( string3, ent );
	}
	
	if ( isdefined( string4 ) )
	{
		self thread waittill_string( string4, ent );
	}
	
	if ( isdefined( string5 ) )
	{
		self thread waittill_string( string5, ent );
	}
	
	ent thread _timeout( timeOut );
	
	ent waittill( "returned", msg );
	ent notify( "die" );
	return msg;
}

/*
	Used for waittill_any_timeout
*/
_timeout( delay )
{
	self endon( "die" );
	
	wait( delay );
	self notify( "returned", "timeout" );
}

/*
	Returns if we have the create a class object unlocked.
*/
isItemUnlocked( what, lvl )
{
	switch ( what )
	{
		case "ak47":
			return true;
			
		case "ak74u":
			return ( lvl >= 28 );
			
		case "barrett":
			return ( lvl >= 49 );
			
		case "dragunov":
			return ( lvl >= 22 );
			
		case "g3":
			return ( lvl >= 25 );
			
		case "g36c":
			return ( lvl >= 37 );
			
		case "m1014":
			return ( lvl >= 31 );
			
		case "m14":
			return ( lvl >= 46 );
			
		case "m16":
			return true;
			
		case "m21":
			return ( lvl >= 7 );
			
		case "m4":
			return ( lvl >= 10 );
			
		case "m40a3":
			return true;
			
		case "m60e4":
			return ( lvl >= 19 );
			
		case "mp44":
			return ( lvl >= 52 );
			
		case "mp5":
			return true;
			
		case "p90":
			return ( lvl >= 40 );
			
		case "rpd":
			return true;
			
		case "saw":
			return true;
			
		case "skorpion":
			return true;
			
		case "uzi":
			return ( lvl >= 13 );
			
		case "winchester1200":
			return true;
			
		case "remington700":
			return ( lvl >= 34 );
			
		case "beretta":
			return true;
			
		case "colt45":
			return ( lvl >= 16 );
			
		case "deserteagle":
			return ( lvl >= 43 );
			
		case "deserteaglegold":
			return ( lvl >= 55 );
			
		case "usp":
			return true;
			
		case "specialty_bulletdamage":
			return true;
			
		case "specialty_armorvest":
			return true;
			
		case "specialty_fastreload":
			return ( lvl >= 20 );
			
		case "specialty_rof":
			return ( lvl >= 29 );
			
		case "specialty_twoprimaries":
			return ( lvl >= 38 );
			
		case "specialty_gpsjammer":
			return ( lvl >= 11 );
			
		case "specialty_explosivedamage":
			return true;
			
		case "specialty_longersprint":
			return true;
			
		case "specialty_bulletaccuracy":
			return true;
			
		case "specialty_pistoldeath":
			return ( lvl >= 8 );
			
		case "specialty_grenadepulldeath":
			return ( lvl >= 17 );
			
		case "specialty_bulletpenetration":
			return true;
			
		case "specialty_holdbreath":
			return ( lvl >= 26 );
			
		case "specialty_quieter":
			return ( lvl >= 44 );
			
		case "specialty_parabolic":
			return ( lvl >= 35 );
			
		case "specialty_specialgrenade":
			return true;
			
		case "specialty_weapon_rpg":
			return true;
			
		case "specialty_weapon_claymore":
			return ( lvl >= 23 );
			
		case "specialty_fraggrenade":
			return ( lvl >= 41 );
			
		case "specialty_extraammo":
			return ( lvl >= 32 );
			
		case "specialty_detectexplosive":
			return ( lvl >= 14 );
			
		case "specialty_weapon_c4":
			return true;
			
		default:
			return true;
	}
}

/*
	ModWarfare removes this func from _missions
*/
getweaponclass( weapon )
{
	tokens = strtok( weapon, "_" );
	weaponClass = tablelookup( "mp/statstable.csv", 4, tokens[ 0 ], 2 );
	
	if ( ismg( weapon ) )
	{
		weaponClass = "weapon_mg";
	}
	
	return weaponClass;
}

/*
	If the weapon  is allowed to be dropped
*/
isWeaponDroppable( weap )
{
	return ( maps\mp\gametypes\_weapons::maydropweapon( weap ) );
}

/*
	Selects a random element from the array.
*/
random( arr )
{
	size = arr.size;
	
	if ( !size )
	{
		return undefined;
	}
	
	return arr[ randomint( size ) ];
}

/*
	Removes an item from the array.
*/
array_remove( ents, remover )
{
	newents = [];
	
	for ( i = 0; i < ents.size; i++ )
	{
		index = ents[ i ];
		
		if ( index != remover )
		{
			newents[ newents.size ] = index;
		}
	}
	
	return newents;
}

/*
	Waits until not or tim.
*/
waittill_notify_or_timeout( not, tim )
{
	self endon( not );
	wait tim;
}

/*
	Gets a player who is host
*/
GetHostPlayer()
{
	for ( i = 0; i < level.players.size; i++ )
	{
		player = level.players[ i ];
		
		if ( !player is_host() )
		{
			continue;
		}
		
		return player;
	}
	
	return undefined;
}

/*
    Waits for a host player
*/
bot_wait_for_host()
{
	host = undefined;
	
	while ( !isdefined( level ) || !isdefined( level.players ) )
	{
		wait 0.05;
	}
	
	for ( i = getdvarfloat( "bots_main_waitForHostTime" ); i > 0; i -= 0.05 )
	{
		host = GetHostPlayer();
		
		if ( isdefined( host ) )
		{
			break;
		}
		
		wait 0.05;
	}
	
	if ( !isdefined( host ) )
	{
		return;
	}
	
	for ( i = getdvarfloat( "bots_main_waitForHostTime" ); i > 0; i -= 0.05 )
	{
		if ( isdefined( host.pers[ "team" ] ) )
		{
			break;
		}
		
		wait 0.05;
	}
	
	if ( !isdefined( host.pers[ "team" ] ) )
	{
		return;
	}
	
	for ( i = getdvarfloat( "bots_main_waitForHostTime" ); i > 0; i -= 0.05 )
	{
		if ( host.pers[ "team" ] == "allies" || host.pers[ "team" ] == "axis" )
		{
			break;
		}
		
		wait 0.05;
	}
}

/*
	Pezbot's line sphere intersection.
	http://paulbourke.net/geometry/circlesphere/raysphere.c
*/
RaySphereIntersect( start, end, spherePos, radius )
{
	// check if the start or end points are in the sphere
	r2 = radius * radius;
	
	if ( distancesquared( start, spherePos ) < r2 )
	{
		return true;
	}
	
	if ( distancesquared( end, spherePos ) < r2 )
	{
		return true;
	}
	
	// check if the line made by start and end intersect the sphere
	dp = end - start;
	a = dp[ 0 ] * dp[ 0 ] + dp[ 1 ] * dp[ 1 ] + dp[ 2 ] * dp[ 2 ];
	b = 2 * ( dp[ 0 ] * ( start[ 0 ] - spherePos[ 0 ] ) + dp[ 1 ] * ( start[ 1 ] - spherePos[ 1 ] ) + dp[ 2 ] * ( start[ 2 ] - spherePos[ 2 ] ) );
	c = spherePos[ 0 ] * spherePos[ 0 ] + spherePos[ 1 ] * spherePos[ 1 ] + spherePos[ 2 ] * spherePos[ 2 ];
	c += start[ 0 ] * start[ 0 ] + start[ 1 ] * start[ 1 ] + start[ 2 ] * start[ 2 ];
	c -= 2.0 * ( spherePos[ 0 ] * start[ 0 ] + spherePos[ 1 ] * start[ 1 ] + spherePos[ 2 ] * start[ 2 ] );
	c -= radius * radius;
	bb4ac = b * b - 4.0 * a * c;
	
	if ( abs( a ) < 0.0001 || bb4ac < 0 )
	{
		return false;
	}
	
	mu1 = ( 0 - b + sqrt( bb4ac ) ) / ( 2 * a );
	// mu2 = (0-b - sqrt(bb4ac)) / (2 * a);
	
	// intersection points of the sphere
	ip1 = start + mu1 * dp;
	// ip2 = start + mu2 * dp;
	
	myDist = distancesquared( start, end );
	
	// check if both intersection points far
	if ( distancesquared( start, ip1 ) > myDist/* && distancesquared(start, ip2) > myDist*/ )
	{
		return false;
	}
	
	dpAngles = vectortoangles( dp );
	
	// check if the point is behind us
	if ( getConeDot( ip1, start, dpAngles ) < 0/* || getConeDot(ip2, start, dpAngles) < 0*/ )
	{
		return false;
	}
	
	return true;
}

/*
	Returns if a smoke grenade would intersect start to end line.
*/
SmokeTrace( start, end, rad )
{
	for ( i = level.bots_smokelist.count - 1; i >= 0; i-- )
	{
		nade = level.bots_smokelist.data[ i ];
		
		if ( nade.state != "smoking" )
		{
			continue;
		}
		
		if ( !RaySphereIntersect( start, end, nade.origin, rad ) )
		{
			continue;
		}
		
		return false;
	}
	
	return true;
}

/*
	Returns the cone dot (like fov, or distance from the center of our screen). 1.0 = directly looking at, 0.0 = completely right angle, -1.0, completely 180
*/
getConeDot( to, from, dir )
{
	dirToTarget = vectornormalize( to - from );
	forward = anglestoforward( dir );
	return vectordot( dirToTarget, forward );
}

/*
	Returns the distance squared in a 2d space
*/
distancesquared2D( to, from )
{
	to = ( to[ 0 ], to[ 1 ], 0 );
	from = ( from[ 0 ], from[ 1 ], 0 );
	
	return distancesquared( to, from );
}

/*
	converts a string into a float
*/
float_old( num )
{
	setdvar( "temp_dvar_bot_util", num );
	
	return getdvarfloat( "temp_dvar_bot_util" );
}

/*
	Rounds to the nearest whole number.
*/
Round( x )
{
	y = int( x );
	
	if ( abs( x ) - abs( y ) > 0.5 )
	{
		if ( x < 0 )
		{
			return y - 1;
		}
		else
		{
			return y + 1;
		}
	}
	else
	{
		return y;
	}
}

/*
	clamps angle between -180 and 180
*/
angleclamp180( angle )
{
	angleFrac = angle / 360.0;
	angle = ( angleFrac - floor( angleFrac ) ) * 360.0;
	
	if ( angle > 180.0 )
	{
		return angle - 360.0;
	}
	
	return angle;
}

/*
	Clamps between value
*/
clamp( a, minv, maxv )
{
	return max( min( a, maxv ), minv );
}

/*
	Matches a num to a char
*/
keyCodeToString( a )
{
	b = "";
	
	switch ( a )
	{
		case 0:
			b = "a";
			break;
			
		case 1:
			b = "b";
			break;
			
		case 2:
			b = "c";
			break;
			
		case 3:
			b = "d";
			break;
			
		case 4:
			b = "e";
			break;
			
		case 5:
			b = "f";
			break;
			
		case 6:
			b = "g";
			break;
			
		case 7:
			b = "h";
			break;
			
		case 8:
			b = "i";
			break;
			
		case 9:
			b = "j";
			break;
			
		case 10:
			b = "k";
			break;
			
		case 11:
			b = "l";
			break;
			
		case 12:
			b = "m";
			break;
			
		case 13:
			b = "n";
			break;
			
		case 14:
			b = "o";
			break;
			
		case 15:
			b = "p";
			break;
			
		case 16:
			b = "q";
			break;
			
		case 17:
			b = "r";
			break;
			
		case 18:
			b = "s";
			break;
			
		case 19:
			b = "t";
			break;
			
		case 20:
			b = "u";
			break;
			
		case 21:
			b = "v";
			break;
			
		case 22:
			b = "w";
			break;
			
		case 23:
			b = "x";
			break;
			
		case 24:
			b = "y";
			break;
			
		case 25:
			b = "z";
			break;
			
		case 26:
			b = ".";
			break;
			
		case 27:
			b = " ";
			break;
	}
	
	return b;
}

/*
	Creates indexers for the create a class objects.
*/
cac_init_patch()
{
	// oldschool mode does not create these, we need those tho.
	if ( !isdefined( level.tbl_weaponids ) )
	{
		level.tbl_weaponids = [];
		
		for ( i = 0; i < 150; i++ )
		{
			reference_s = tablelookup( "mp/statsTable.csv", 0, i, 4 );
			
			if ( reference_s != "" )
			{
				level.tbl_weaponids[ i ][ "reference" ] = reference_s;
				level.tbl_weaponids[ i ][ "group" ] = tablelookup( "mp/statstable.csv", 0, i, 2 );
				level.tbl_weaponids[ i ][ "count" ] = int( tablelookup( "mp/statstable.csv", 0, i, 5 ) );
				level.tbl_weaponids[ i ][ "attachment" ] = tablelookup( "mp/statstable.csv", 0, i, 8 );
			}
			else
			{
				continue;
			}
		}
	}
	
	if ( !isdefined( level.tbl_weaponattachment ) )
	{
		level.tbl_weaponattachment = [];
		
		for ( i = 0; i < 8; i++ )
		{
			level.tbl_weaponattachment[ i ][ "bitmask" ] = int( tablelookup( "mp/attachmentTable.csv", 9, i, 10 ) );
			level.tbl_weaponattachment[ i ][ "reference" ] = tablelookup( "mp/attachmentTable.csv", 9, i, 4 );
		}
	}
	
	if ( !isdefined( level.tbl_perkdata ) )
	{
		level.tbl_perkdata = [];
		
		// generating perk data vars collected form statsTable.csv
		for ( i = 150; i < 194; i++ )
		{
			reference_s = tablelookup( "mp/statsTable.csv", 0, i, 4 );
			
			if ( reference_s != "" )
			{
				level.tbl_perkdata[ i ][ "reference" ] = reference_s;
				level.tbl_perkdata[ i ][ "reference_full" ] = tablelookup( "mp/statsTable.csv", 0, i, 6 );
				level.tbl_perkdata[ i ][ "count" ] = int( tablelookup( "mp/statsTable.csv", 0, i, 5 ) );
				level.tbl_perkdata[ i ][ "group" ] = tablelookup( "mp/statsTable.csv", 0, i, 2 );
				level.tbl_perkdata[ i ][ "name" ] = tablelookupistring( "mp/statsTable.csv", 0, i, 3 );
				level.tbl_perkdata[ i ][ "perk_num" ] = tablelookup( "mp/statsTable.csv", 0, i, 8 );
			}
			else
			{
				continue;
			}
		}
	}
	
	level.perkreferencetoindex = [];
	level.weaponreferencetoindex = [];
	level.weaponattachmentreferencetoindex = [];
	
	for ( i = 0; i < 150; i++ )
	{
		if ( !isdefined( level.tbl_weaponids[ i ] ) || !isdefined( level.tbl_weaponids[ i ][ "reference" ] ) )
		{
			continue;
		}
		
		level.weaponreferencetoindex[ level.tbl_weaponids[ i ][ "reference" ] ] = i;
	}
	
	for ( i = 0; i < 8; i++ )
	{
		if ( !isdefined( level.tbl_weaponattachment[ i ] ) || !isdefined( level.tbl_weaponattachment[ i ][ "reference" ] ) )
		{
			continue;
		}
		
		level.weaponattachmentreferencetoindex[ level.tbl_weaponattachment[ i ][ "reference" ] ] = i;
	}
	
	for ( i = 150; i < 194; i++ )
	{
		if ( !isdefined( level.tbl_perkdata[ i ] ) || !isdefined( level.tbl_perkdata[ i ][ "reference_full" ] ) )
		{
			continue;
		}
		
		level.perkreferencetoindex[ level.tbl_perkdata[ i ][ "reference_full" ] ] = i;
	}
}

/*
	Parse frontlines type waypoints
*/
FrontLinesWaypoints()
{
	waypoints = [];
	
	for ( i = 0;; i++ )
	{
		dvar_answer = getdvar( "flwp_" + i );
		
		if ( dvar_answer == "" || dvar_answer == "eof" )
		{
			break;
		}
		
		toks = strtok( dvar_answer, "," );
		
		waypoint = spawnstruct();
		wp_num = int( toks[ 0 ] );
		x = float_old( toks[ 1 ] );
		y = float_old( toks[ 2 ] );
		z = float_old( toks[ 3 ] );
		waypoint.origin = ( x, y, z );
		
		waypoint.type = toks[ 4 ];
		waypoint.children = [];
		
		num_children = int( toks[ 5 ] );
		
		for ( h = 0; h < num_children; h++ )
		{
			waypoint.children[ waypoint.children.size ] = int( toks[ 6 + h ] );
		}
		
		waypoints[ wp_num ] = waypoint;
	}
	
	return waypoints;
}

/*
	Parses tokens into a waypoint obj
*/
parseTokensIntoWaypoint( tokens )
{
	waypoint = spawnstruct();
	
	orgStr = tokens[ 0 ];
	orgToks = strtok( orgStr, " " );
	waypoint.origin = ( float_old( orgToks[ 0 ] ), float_old( orgToks[ 1 ] ), float_old( orgToks[ 2 ] ) );
	
	childStr = tokens[ 1 ];
	childToks = strtok( childStr, " " );
	waypoint.children = [];
	
	for ( j = 0; j < childToks.size; j++ )
	{
		waypoint.children[ j ] = int( childToks[ j ] );
	}
	
	type = tokens[ 2 ];
	waypoint.type = type;
	
	anglesStr = tokens[ 3 ];
	
	if ( isdefined( anglesStr ) && anglesStr != "" )
	{
		anglesToks = strtok( anglesStr, " " );
		
		if ( anglesToks.size >= 3 )
		{
			waypoint.angles = ( float_old( anglesToks[ 0 ] ), float_old( anglesToks[ 1 ] ), float_old( anglesToks[ 2 ] ) );
		}
	}
	
	return waypoint;
}

/*
	Returns a bot's name to be used. Reads from botnames.txt
*/
getABotName()
{
	if ( !isdefined( level.bot_names ) )
	{
		level.bot_names = [];
		
		if ( getdvar( "temp_dvar_bot_name_cursor" ) == "" )
		{
			setdvar( "temp_dvar_bot_name_cursor", 0 );
		}
		
		filename = "botnames.txt";
		
		if ( BotBuiltinFileExists( filename ) )
		{
			f = BotBuiltinFileOpen( filename, "read" );
			
			if ( f > 0 )
			{
				for ( line = BotBuiltinReadLine( f ); isdefined( line ); line = BotBuiltinReadLine( f ) )
				{
					level.bot_names[ level.bot_names.size ] = line;
				}
				
				BotBuiltinFileClose( f );
			}
		}
	}
	
	if ( !level.bot_names.size )
	{
		return undefined;
	}
	
	cur = getdvarint( "temp_dvar_bot_name_cursor" );
	name = level.bot_names[ cur % level.bot_names.size ];
	setdvar( "temp_dvar_bot_name_cursor", cur + 1 );
	
	return name;
}

/*
	Read from file a csv, and returns an array of waypoints
*/
readWpsFromFile( mapname )
{
	waypoints = [];
	filename = "waypoints/" + mapname + "_wp.csv";
	
	if ( !BotBuiltinFileExists( filename ) )
	{
		return waypoints;
	}
	
	f = BotBuiltinFileOpen( filename, "read" );
	
	if ( f < 1 )
	{
		return waypoints;
	}
	
	BotBuiltinPrintConsole( "Attempting to read waypoints from " + filename );
	
	line = BotBuiltinReadLine( f );
	
	if ( isdefined( line ) )
	{
		waypointCount = int( line );
		
		for ( i = 1; i <= waypointCount; i++ )
		{
			line = BotBuiltinReadLine( f );
			
			if ( !isdefined( line ) )
			{
				break;
			}
			
			tokens = strtok( line, "," );
			
			waypoint = parseTokensIntoWaypoint( tokens );
			
			waypoints[ i - 1 ] = waypoint;
		}
	}
	
	BotBuiltinFileClose( f );
	
	return waypoints;
}

/*
	Loads the waypoints. Populating everything needed for the waypoints.
*/
load_waypoints()
{
	mapname = getdvar( "mapname" );
	
	level.waypointcount = 0;
	level.waypointusage = [];
	level.waypointusage[ "allies" ] = [];
	level.waypointusage[ "axis" ] = [];
	
	if ( !isdefined( level.waypoints ) )
	{
		level.waypoints = [];
	}
	
	wps = readWpsFromFile( mapname );
	
	if ( wps.size )
	{
		level.waypoints = wps;
		BotBuiltinPrintConsole( "Loaded " + wps.size + " waypoints from file." );
	}
	else
	{
		switch ( mapname )
		{
			default:
				maps\mp\bots\waypoints\_custom_map::main( mapname );
				break;
		}
		
		if ( level.waypoints.size )
		{
			BotBuiltinPrintConsole( "Loaded " + level.waypoints.size + " waypoints from script." );
		}
	}
	
	if ( !level.waypoints.size )
	{
		level.waypoints = FrontLinesWaypoints();
		
		if ( level.waypoints.size )
		{
			BotBuiltinPrintConsole( "Loaded " + level.waypoints.size + " waypoints from frontlines." );
		}
	}
	
	if ( !level.waypoints.size )
	{
		BotBuiltinPrintConsole( "No waypoints loaded!" );
	}
	
	level.waypointcount = level.waypoints.size;
	
	for ( i = 0; i < level.waypointcount; i++ )
	{
		if ( !isdefined( level.waypoints[ i ].children ) || !isdefined( level.waypoints[ i ].children.size ) )
		{
			level.waypoints[ i ].children = [];
		}
		
		if ( !isdefined( level.waypoints[ i ].origin ) )
		{
			level.waypoints[ i ].origin = ( 0, 0, 0 );
		}
		
		if ( !isdefined( level.waypoints[ i ].type ) )
		{
			level.waypoints[ i ].type = "crouch";
		}
		
		level.waypoints[ i ].childcount = undefined;
	}
}

/*
	Is bot near any of the given waypoints
*/
nearAnyOfWaypoints( dist, waypoints )
{
	dist *= dist;
	
	for ( i = 0; i < waypoints.size; i++ )
	{
		waypoint = level.waypoints[ waypoints[ i ] ];
		
		if ( distancesquared( waypoint.origin, self.origin ) > dist )
		{
			continue;
		}
		
		return true;
	}
	
	return false;
}

/*
	Returns the waypoints that are near
*/
waypointsNear( waypoints, dist )
{
	dist *= dist;
	
	answer = [];
	
	for ( i = 0; i < waypoints.size; i++ )
	{
		wp = level.waypoints[ waypoints[ i ] ];
		
		if ( distancesquared( wp.origin, self.origin ) > dist )
		{
			continue;
		}
		
		answer[ answer.size ] = waypoints[ i ];
	}
	
	return answer;
}

/*
	Returns nearest waypoint of waypoints
*/
getNearestWaypointOfWaypoints( waypoints )
{
	answer = undefined;
	closestDist = 2147483647;
	
	for ( i = 0; i < waypoints.size; i++ )
	{
		waypoint = level.waypoints[ waypoints[ i ] ];
		thisDist = distancesquared( self.origin, waypoint.origin );
		
		if ( isdefined( answer ) && thisDist > closestDist )
		{
			continue;
		}
		
		answer = waypoints[ i ];
		closestDist = thisDist;
	}
	
	return answer;
}

/*
	Returns all waypoints of type
*/
getWaypointsOfType( type )
{
	answer = [];
	
	for ( i = 0; i < level.waypointcount; i++ )
	{
		wp = level.waypoints[ i ];
		
		if ( type == "camp" )
		{
			if ( wp.type != "crouch" )
			{
				continue;
			}
			
			if ( wp.children.size != 1 )
			{
				continue;
			}
		}
		else if ( type != wp.type )
		{
			continue;
		}
		
		answer[ answer.size ] = i;
	}
	
	return answer;
}

/*
	Returns the waypoint for index
*/
getWaypointForIndex( i )
{
	if ( !isdefined( i ) )
	{
		return undefined;
	}
	
	return level.waypoints[ i ];
}

/*
	Returns a good amount of players.
*/
getGoodMapAmount()
{
	switch ( getdvar( "mapname" ) )
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
			if ( level.teambased )
			{
				return 14;
			}
			else
			{
				return 9;
			}
			
		case "mp_vacant":
		case "mp_showdown":
		case "mp_citystreets":
		case "mp_bog":
			if ( level.teambased )
			{
				return 12;
			}
			else
			{
				return 8;
			}
			
		case "mp_killhouse":
		case "mp_shipment":
			if ( level.teambased )
			{
				return 8;
			}
			else
			{
				return 4;
			}
	}
	
	return 2;
}

/*
	Returns the friendly user name for a given map's codename
*/
getMapName( map )
{
	switch ( map )
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
	Does the extra check when adding bots
*/
doExtraCheck()
{
	maps\mp\bots\_bot_internal::checkTheBots();
}

/*
	Returns a bot to be kicked
*/
getBotToKick()
{
	bots = getBotArray();
	
	if ( !isdefined( bots ) || !isdefined( bots.size ) || bots.size <= 0 || !isdefined( bots[ 0 ] ) )
	{
		return undefined;
	}
	
	tokick = undefined;
	axis = 0;
	allies = 0;
	team = getdvar( "bots_team" );
	
	// count teams
	for ( i = 0; i < bots.size; i++ )
	{
		bot = bots[ i ];
		
		if ( !isdefined( bot ) || !isdefined( bot.team ) )
		{
			continue;
		}
		
		if ( bot.team == "allies" )
		{
			allies++;
		}
		else if ( bot.team == "axis" )
		{
			axis++;
		}
		else // choose bots that are not on a team first
		{
			return bot;
		}
	}
	
	// search for a bot on the other team
	if ( team == "custom" || team == "axis" )
	{
		team = "allies";
	}
	else if ( team == "autoassign" )
	{
		// get the team with the most bots
		team = "allies";
		
		if ( axis > allies )
		{
			team = "axis";
		}
	}
	else
	{
		team = "axis";
	}
	
	// get the bot on this team with lowest skill
	for ( i = 0; i < bots.size; i++ )
	{
		bot = bots[ i ];
		
		if ( !isdefined( bot ) || !isdefined( bot.team ) )
		{
			continue;
		}
		
		if ( bot.team != team )
		{
			continue;
		}
		
		if ( !isdefined( bot.pers ) || !isdefined( bot.pers[ "bots" ] ) || !isdefined( bot.pers[ "bots" ][ "skill" ] ) || !isdefined( bot.pers[ "bots" ][ "skill" ][ "base" ] ) )
		{
			continue;
		}
		
		if ( isdefined( tokick ) && bot.pers[ "bots" ][ "skill" ][ "base" ] > tokick.pers[ "bots" ][ "skill" ][ "base" ] )
		{
			continue;
		}
		
		tokick = bot;
	}
	
	if ( isdefined( tokick ) )
	{
		return tokick;
	}
	
	// just kick lowest skill
	for ( i = 0; i < bots.size; i++ )
	{
		bot = bots[ i ];
		
		if ( !isdefined( bot ) || !isdefined( bot.team ) )
		{
			continue;
		}
		
		if ( !isdefined( bot.pers ) || !isdefined( bot.pers[ "bots" ] ) || !isdefined( bot.pers[ "bots" ][ "skill" ] ) || !isdefined( bot.pers[ "bots" ][ "skill" ][ "base" ] ) )
		{
			continue;
		}
		
		if ( isdefined( tokick ) && bot.pers[ "bots" ][ "skill" ][ "base" ] > tokick.pers[ "bots" ][ "skill" ][ "base" ] )
		{
			continue;
		}
		
		tokick = bot;
	}
	
	return tokick;
}

/*
	Returns an array of all the bots in the game.
*/
getBotArray()
{
	result = [];
	playercount = level.players.size;
	
	for ( i = 0; i < playercount; i++ )
	{
		player = level.players[ i ];
		
		if ( !player is_bot() )
		{
			continue;
		}
		
		result[ result.size ] = player;
	}
	
	return result;
}

/*
	We return a balanced KDTree from the waypoints.
*/
WaypointsToKDTree()
{
	kdTree = KDTree();
	
	kdTree _WaypointsToKDTree( level.waypoints, 0 );
	
	return kdTree;
}

/*
	Recurive function. We construct a balanced KD tree by sorting the waypoints using heap sort.
*/
_WaypointsToKDTree( waypoints, dem )
{
	if ( !waypoints.size )
	{
		return;
	}
	
	callbacksort = undefined;
	
	switch ( dem )
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
	
	heap = NewHeap( callbacksort );
	
	for ( i = 0; i < waypoints.size; i++ )
	{
		heap HeapInsert( waypoints[ i ] );
	}
	
	sorted = [];
	
	while ( heap.data.size )
	{
		sorted[ sorted.size ] = heap.data[ 0 ];
		heap HeapRemove();
	}
	
	median = int( sorted.size / 2 ); // use divide and conq
	
	left = [];
	right = [];
	
	for ( i = 0; i < sorted.size; i++ )
	{
		if ( i < median )
		{
			right[ right.size ] = sorted[ i ];
		}
		else if ( i > median )
		{
			left[ left.size ] = sorted[ i ];
		}
	}
	
	self KDTreeInsert( sorted[ median ] );
	
	_WaypointsToKDTree( left, ( dem + 1 ) % 3 );
	
	_WaypointsToKDTree( right, ( dem + 1 ) % 3 );
}

/*
	Returns a new list.
*/
List()
{
	list = spawnstruct();
	list.count = 0;
	list.data = [];
	
	return list;
}

/*
	Adds a new thing to the list.
*/
ListAdd( thing )
{
	self.data[ self.count ] = thing;
	
	self.count++;
}

/*
	Adds to the start of the list.
*/
ListAddFirst( thing )
{
	for ( i = self.count - 1; i >= 0; i-- )
	{
		self.data[ i + 1 ] = self.data[ i ];
	}
	
	self.data[ 0 ] = thing;
	self.count++;
}

/*
	Removes the thing from the list.
*/
ListRemove( thing )
{
	for ( i = 0; i < self.count; i++ )
	{
		if ( self.data[ i ] == thing )
		{
			while ( i < self.count - 1 )
			{
				self.data[ i ] = self.data[ i + 1 ];
				i++;
			}
			
			self.data[ i ] = undefined;
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
	kdTree = spawnstruct();
	kdTree.root = undefined;
	kdTree.count = 0;
	
	return kdTree;
}

/*
	Called on a KDTree. Will insert the object into the KDTree.
*/
KDTreeInsert( data ) // as long as what you insert has a .origin attru, it will work.
{
	self.root = self _KDTreeInsert( self.root, data, 0, -2147483647, -2147483647, -2147483647, 2147483647, 2147483647, 2147483647 );
}

/*
	Recurive function that insert the object into the KDTree.
*/
_KDTreeInsert( node, data, dem, x0, y0, z0, x1, y1, z1 )
{
	if ( !isdefined( node ) )
	{
		r = spawnstruct();
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
	
	switch ( dem )
	{
		case 0:
			if ( data.origin[ 0 ] < node.data.origin[ 0 ] )
			{
				node.left = self _KDTreeInsert( node.left, data, 1, x0, y0, z0, node.data.origin[ 0 ], y1, z1 );
			}
			else
			{
				node.right = self _KDTreeInsert( node.right, data, 1, node.data.origin[ 0 ], y0, z0, x1, y1, z1 );
			}
			
			break;
			
		case 1:
			if ( data.origin[ 1 ] < node.data.origin[ 1 ] )
			{
				node.left = self _KDTreeInsert( node.left, data, 2, x0, y0, z0, x1, node.data.origin[ 1 ], z1 );
			}
			else
			{
				node.right = self _KDTreeInsert( node.right, data, 2, x0, node.data.origin[ 1 ], z0, x1, y1, z1 );
			}
			
			break;
			
		case 2:
			if ( data.origin[ 2 ] < node.data.origin[ 2 ] )
			{
				node.left = self _KDTreeInsert( node.left, data, 0, x0, y0, z0, x1, y1, node.data.origin[ 2 ] );
			}
			else
			{
				node.right = self _KDTreeInsert( node.right, data, 0, x0, y0, node.data.origin[ 2 ], x1, y1, z1 );
			}
			
			break;
	}
	
	return node;
}

/*
	Called on a KDTree, will return the nearest object to the given origin.
*/
KDTreeNearest( origin )
{
	if ( !isdefined( self.root ) )
	{
		return undefined;
	}
	
	return self _KDTreeNearest( self.root, origin, self.root.data, distancesquared( self.root.data.origin, origin ), 0 );
}

/*
	Recurive function that will retrieve the closest object to the query.
*/
_KDTreeNearest( node, point, closest, closestdist, dem )
{
	if ( !isdefined( node ) )
	{
		return closest;
	}
	
	thisDis = distancesquared( node.data.origin, point );
	
	if ( thisDis < closestdist )
	{
		closestdist = thisDis;
		closest = node.data;
	}
	
	if ( node Rectdistancesquared( point ) < closestdist )
	{
		near = node.left;
		far = node.right;
		
		if ( point[ dem ] > node.data.origin[ dem ] )
		{
			near = node.right;
			far = node.left;
		}
		
		closest = self _KDTreeNearest( near, point, closest, closestdist, ( dem + 1 ) % 3 );
		
		closest = self _KDTreeNearest( far, point, closest, distancesquared( closest.origin, point ), ( dem + 1 ) % 3 );
	}
	
	return closest;
}

/*
	Called on a rectangle, returns the distance from origin to the rectangle.
*/
Rectdistancesquared( origin )
{
	dx = 0;
	dy = 0;
	dz = 0;
	
	if ( origin[ 0 ] < self.x0 )
	{
		dx = origin[ 0 ] - self.x0;
	}
	else if ( origin[ 0 ] > self.x1 )
	{
		dx = origin[ 0 ] - self.x1;
	}
	
	if ( origin[ 1 ] < self.y0 )
	{
		dy = origin[ 1 ] - self.y0;
	}
	else if ( origin[ 1 ] > self.y1 )
	{
		dy = origin[ 1 ] - self.y1;
	}
	
	if ( origin[ 2 ] < self.z0 )
	{
		dz = origin[ 2 ] - self.z0;
	}
	else if ( origin[ 2 ] > self.z1 )
	{
		dz = origin[ 2 ] - self.z1;
	}
	
	return dx * dx + dy * dy + dz * dz;
}

/*
	A heap invarient comparitor, used for objects, objects with a higher X coord will be first in the heap.
*/
HeapSortCoordX( item, item2 )
{
	return item.origin[ 0 ] > item2.origin[ 0 ];
}

/*
	A heap invarient comparitor, used for objects, objects with a higher Y coord will be first in the heap.
*/
HeapSortCoordY( item, item2 )
{
	return item.origin[ 1 ] > item2.origin[ 1 ];
}

/*
	A heap invarient comparitor, used for objects, objects with a higher Z coord will be first in the heap.
*/
HeapSortCoordZ( item, item2 )
{
	return item.origin[ 2 ] > item2.origin[ 2 ];
}

/*
	A heap invarient comparitor, used for numbers, numbers with the highest number will be first in the heap.
*/
Heap( item, item2 )
{
	return item > item2;
}

/*
	A heap invarient comparitor, used for numbers, numbers with the lowest number will be first in the heap.
*/
ReverseHeap( item, item2 )
{
	return item < item2;
}

/*
	A heap invarient comparitor, used for traces. Wanting the trace with the largest length first in the heap.
*/
HeapTraceFraction( item, item2 )
{
	return item[ "fraction" ] > item2[ "fraction" ];
}

/*
	Returns a new heap.
*/
NewHeap( compare )
{
	heap_node = spawnstruct();
	heap_node.data = [];
	heap_node.compare = compare;
	
	return heap_node;
}

/*
	Inserts the item into the heap. Called on a heap.
*/
HeapInsert( item )
{
	insert = self.data.size;
	self.data[ insert ] = item;
	
	current = insert + 1;
	
	while ( current > 1 )
	{
		last = current;
		current = int( current / 2 );
		
		if ( ![[ self.compare ]]( item, self.data[ current - 1 ] ) )
		{
			break;
		}
		
		self.data[ last - 1 ] = self.data[ current - 1 ];
		self.data[ current - 1 ] = item;
	}
}

/*
	Helper function to determine what is the next child of the bst.
*/
_HeapNextChild( node, hsize )
{
	left = node * 2;
	right = left + 1;
	
	if ( left > hsize )
	{
		return -1;
	}
	
	if ( right > hsize )
	{
		return left;
	}
	
	if ( [[ self.compare ]]( self.data[ left - 1 ], self.data[ right - 1 ] ) )
	{
		return left;
	}
	else
	{
		return right;
	}
}

/*
	Removes an item from the heap. Called on a heap.
*/
HeapRemove()
{
	remove = self.data.size;
	
	if ( !remove )
	{
		return remove;
	}
	
	move = self.data[ remove - 1 ];
	self.data[ 0 ] = move;
	self.data[ remove - 1 ] = undefined;
	remove--;
	
	if ( !remove )
	{
		return remove;
	}
	
	last = 1;
	next = self _HeapNextChild( 1, remove );
	
	while ( next != -1 )
	{
		if ( [[ self.compare ]]( move, self.data[ next - 1 ] ) )
		{
			break;
		}
		
		self.data[ last - 1 ] = self.data[ next - 1 ];
		self.data[ next - 1 ] = move;
		
		last = next;
		next = self _HeapNextChild( next, remove );
	}
	
	return remove;
}

/*
	A heap invarient comparitor, used for the astar's nodes, wanting the node with the lowest f to be first in the heap.
*/
ReverseHeapAStar( item, item2 )
{
	return item.f < item2.f;
}

/*
	Removes the waypoint usage
*/
RemoveWaypointUsage( wp, team )
{
	if ( !isdefined( level.waypointusage ) )
	{
		return;
	}
	
	if ( !isdefined( level.waypointusage[ team ][ wp + "" ] ) )
	{
		return;
	}
	
	level.waypointusage[ team ][ wp + "" ]--;
	
	if ( level.waypointusage[ team ][ wp + "" ] <= 0 )
	{
		level.waypointusage[ team ][ wp + "" ] = undefined;
	}
}

/*
	Will linearly search for the nearest waypoint to pos that has a direct line of sight.
*/
GetNearestWaypointWithSight( pos )
{
	candidate = undefined;
	dist = 2147483647;
	
	for ( i = 0; i < level.waypointcount; i++ )
	{
		if ( !bullettracepassed( pos + ( 0, 0, 15 ), level.waypoints[ i ].origin + ( 0, 0, 15 ), false, undefined ) )
		{
			continue;
		}
		
		curdis = distancesquared( level.waypoints[ i ].origin, pos );
		
		if ( curdis > dist )
		{
			continue;
		}
		
		dist = curdis;
		candidate = i;
	}
	
	return candidate;
}

/*
	Will linearly search for the nearest waypoint
*/
getNearestWaypoint( pos )
{
	candidate = undefined;
	dist = 2147483647;
	
	for ( i = 0; i < level.waypointcount; i++ )
	{
		curdis = distancesquared( level.waypoints[ i ].origin, pos );
		
		if ( curdis > dist )
		{
			continue;
		}
		
		dist = curdis;
		candidate = i;
	}
	
	return candidate;
}

/*
	Modified Pezbot astar search.
	This makes use of sets for quick look up and a heap for a priority queue instead of simple lists which require to linearly search for elements everytime.
	It is also modified to make paths with bots already on more expensive and will try a less congested path first. Thus spliting up the bots onto more paths instead of just one (the smallest).
*/
AStarSearch( start, goal, team, greedy_path )
{
	open = NewHeap( ::ReverseHeapAStar ); // heap
	openset = []; // set for quick lookup
	closed = []; // set for quick lookup
	
	
	startWp = getNearestWaypoint( start );
	
	if ( !isdefined( startWp ) )
	{
		return [];
	}
	
	_startwp = undefined;
	
	if ( !bullettracepassed( start + ( 0, 0, 15 ), level.waypoints[ startWp ].origin + ( 0, 0, 15 ), false, undefined ) )
	{
		_startwp = GetNearestWaypointWithSight( start );
	}
	
	if ( isdefined( _startwp ) )
	{
		startWp = _startwp;
	}
	
	
	goalWp = getNearestWaypoint( goal );
	
	if ( !isdefined( goalWp ) )
	{
		return [];
	}
	
	_goalwp = undefined;
	
	if ( !bullettracepassed( goal + ( 0, 0, 15 ), level.waypoints[ goalWp ].origin + ( 0, 0, 15 ), false, undefined ) )
	{
		_goalwp = GetNearestWaypointWithSight( goal );
	}
	
	if ( isdefined( _goalwp ) )
	{
		goalWp = _goalwp;
	}
	
	
	node = spawnstruct();
	node.g = 0; // path dist so far
	node.h = distancesquared( level.waypoints[ startWp ].origin, level.waypoints[ goalWp ].origin ); // herustic, distance to goal for path finding
	node.f = node.h + node.g; // combine path dist and heru, use reverse heap to sort the priority queue by this attru
	node.index = startWp;
	node.parent = undefined; // we are start, so we have no parent
	
	// push node onto queue
	openset[ node.index + "" ] = node;
	open HeapInsert( node );
	
	// while the queue is not empty
	while ( open.data.size )
	{
		// pop bestnode from queue
		bestNode = open.data[ 0 ];
		open HeapRemove();
		openset[ bestNode.index + "" ] = undefined;
		wp = level.waypoints[ bestNode.index ];
		
		// check if we made it to the goal
		if ( bestNode.index == goalWp )
		{
			path = [];
			
			while ( isdefined( bestNode ) )
			{
				if ( isdefined( team ) && isdefined( level.waypointusage ) )
				{
					if ( !isdefined( level.waypointusage[ team ][ bestNode.index + "" ] ) )
					{
						level.waypointusage[ team ][ bestNode.index + "" ] = 0;
					}
					
					level.waypointusage[ team ][ bestNode.index + "" ]++;
				}
				
				// construct path
				path[ path.size ] = bestNode.index;
				
				bestNode = bestNode.parent;
			}
			
			return path;
		}
		
		// for each child of bestnode
		for ( i = wp.children.size - 1; i >= 0; i-- )
		{
			child = wp.children[ i ];
			childWp = level.waypoints[ child ];
			
			penalty = 1;
			
			if ( !greedy_path && isdefined( team ) && isdefined( level.waypointusage ) )
			{
				temppen = 1;
				
				if ( isdefined( level.waypointusage[ team ][ child + "" ] ) )
				{
					temppen = level.waypointusage[ team ][ child + "" ]; // consider how many bots are taking this path
				}
				
				if ( temppen > 1 )
				{
					penalty = temppen;
				}
			}
			
			// have certain types of nodes more expensive
			if ( childWp.type == "climb" || childWp.type == "prone" )
			{
				penalty += 4;
			}
			
			// calc the total path we have took
			newg = bestNode.g + distancesquared( wp.origin, childWp.origin ) * penalty; // bots on same team's path are more expensive
			
			// check if this child is in open or close with a g value less than newg
			inopen = isdefined( openset[ child + "" ] );
			
			if ( inopen && openset[ child + "" ].g <= newg )
			{
				continue;
			}
			
			inclosed = isdefined( closed[ child + "" ] );
			
			if ( inclosed && closed[ child + "" ].g <= newg )
			{
				continue;
			}
			
			node = undefined;
			
			if ( inopen )
			{
				node = openset[ child + "" ];
			}
			else if ( inclosed )
			{
				node = closed[ child + "" ];
			}
			else
			{
				node = spawnstruct();
			}
			
			node.parent = bestNode;
			node.g = newg;
			node.h = distancesquared( childWp.origin, level.waypoints[ goalWp ].origin );
			node.f = node.g + node.h;
			node.index = child;
			
			// check if in closed, remove it
			if ( inclosed )
			{
				closed[ child + "" ] = undefined;
			}
			
			// check if not in open, add it
			if ( !inopen )
			{
				open HeapInsert( node );
				openset[ child + "" ] = node;
			}
		}
		
		// done with children, push onto closed
		closed[ bestNode.index + "" ] = bestNode;
	}
	
	return [];
}

/*
	Returns the natural log of x using harmonic series.
*/
Log( x )
{
	// thanks Bob__ at stackoverflow
	old_sum = 0.0;
	xmlxpl = ( x - 1 ) / ( x + 1 );
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
	return answer;
}

/*
	Taken from t5 gsc.
*/
array_combine( array1, array2 )
{
	if ( !array1.size )
	{
		return array2;
	}
	
	array3 = [];
	keys = getarraykeys( array1 );
	
	for ( i = 0; i < keys.size; i++ )
	{
		key = keys[ i ];
		array3[ array3.size ] = array1[ key ];
	}
	
	keys = getarraykeys( array2 );
	
	for ( i = 0; i < keys.size; i++ )
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
	assert( array.size > 0 );
	total = 0;
	
	for ( i = 0; i < array.size; i++ )
	{
		total += array[ i ];
	}
	
	return ( total / array.size );
}

/*
	Taken from t5 gsc.
	Returns an array of number's standard deviation.
*/
array_std_deviation( array, mean )
{
	assert( array.size > 0 );
	tmp = [];
	
	for ( i = 0; i < array.size; i++ )
	{
		tmp[ i ] = ( array[ i ] - mean ) * ( array[ i ] - mean );
	}
	
	total = 0;
	
	for ( i = 0; i < tmp.size; i++ )
	{
		total = total + tmp[ i ];
	}
	
	return sqrt( total / array.size );
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
		x1 = 2 * randomfloatrange( 0, 1 ) - 1;
		x2 = 2 * randomfloatrange( 0, 1 ) - 1;
		w = x1 * x1 + x2 * x2;
	}
	
	w = sqrt( ( -2.0 * Log( w ) ) / w );
	y1 = x1 * w;
	number = mean + y1 * std_deviation;
	
	if ( isdefined( lower_bound ) && number < lower_bound )
	{
		number = lower_bound;
	}
	
	if ( isdefined( upper_bound ) && number > upper_bound )
	{
		number = upper_bound;
	}
	
	return ( number );
}

/*
	We patch the bomb planted for sd so we have access to defuseObject.
*/
onUsePlantObjectFix( player )
{
	// planted the bomb
	if ( !self maps\mp\gametypes\_gameobjects::isfriendlyteam( player.pers[ "team" ] ) )
	{
		level thread bombPlantedFix( self, player );
		player logstring( "bomb planted: " + self.label );
		
		// disable all bomb zones except this one
		for ( index = 0; index < level.bombzones.size; index++ )
		{
			if ( level.bombzones[ index ] == self )
			{
				continue;
			}
			
			level.bombzones[ index ] maps\mp\gametypes\_gameobjects::disableobject();
		}
		
		player playsound( "mp_bomb_plant" );
		player notify ( "bomb_planted" );
		
		if ( !level.hardcoremode )
		{
			iprintln( &"MP_EXPLOSIVES_PLANTED_BY", player );
		}
		
		maps\mp\gametypes\_globallogic::leaderdialog( "bomb_planted" );
		
		maps\mp\gametypes\_globallogic::giveplayerscore( "plant", player );
		player thread [[ level.onxpevent ]]( "plant" );
	}
}

/*
	We patch the bomb planted for sd so we have access to defuseObject.
*/
bombPlantedFix( destroyedObj, player )
{
	maps\mp\gametypes\_globallogic::pausetimer();
	level.bombplanted = true;
	
	destroyedObj.visuals[ 0 ] thread maps\mp\gametypes\_globallogic::playtickingsound();
	level.tickingobject = destroyedObj.visuals[ 0 ];
	
	level.timelimitoverride = true;
	setgameendtime( int( gettime() + ( level.bombtimer * 1000 ) ) );
	setdvar( "ui_bomb_timer", 1 );
	
	if ( !level.multibomb )
	{
		level.sdbomb maps\mp\gametypes\_gameobjects::allowcarry( "none" );
		level.sdbomb maps\mp\gametypes\_gameobjects::setvisibleteam( "none" );
		level.sdbomb maps\mp\gametypes\_gameobjects::setdropped();
		level.sdbombmodel = level.sdbomb.visuals[ 0 ];
	}
	else
	{
		for ( index = 0; index < level.players.size; index++ )
		{
			if ( isdefined( level.players[ index ].carryicon ) )
			{
				level.players[ index ].carryicon destroyelem();
			}
		}
		
		trace = bullettrace( player.origin + ( 0, 0, 20 ), player.origin - ( 0, 0, 2000 ), false, player );
		
		tempAngle = randomfloat( 360 );
		forward = ( cos( tempAngle ), sin( tempAngle ), 0 );
		forward = vectornormalize( forward - vector_scale( trace[ "normal" ], vectordot( forward, trace[ "normal" ] ) ) );
		dropAngles = vectortoangles( forward );
		
		level.sdbombmodel = spawn( "script_model", trace[ "position" ] );
		level.sdbombmodel.angles = dropAngles;
		level.sdbombmodel setmodel( "prop_suitcase_bomb" );
	}
	
	destroyedObj maps\mp\gametypes\_gameobjects::allowuse( "none" );
	destroyedObj maps\mp\gametypes\_gameobjects::setvisibleteam( "none" );
	/*
	    destroyedObj maps\mp\gametypes\_gameobjects::set2dicon( "friendly", undefined );
	    destroyedObj maps\mp\gametypes\_gameobjects::set2dicon( "enemy", undefined );
	    destroyedObj maps\mp\gametypes\_gameobjects::set3dicon( "friendly", undefined );
	    destroyedObj maps\mp\gametypes\_gameobjects::set3dicon( "enemy", undefined );
	*/
	label = destroyedObj maps\mp\gametypes\_gameobjects::getlabel();
	
	// create a new object to defuse with.
	trigger = destroyedObj.bombdefusetrig;
	trigger.origin = level.sdbombmodel.origin;
	visuals = [];
	defuseObject = maps\mp\gametypes\_gameobjects::createuseobject( game[ "defenders" ], trigger, visuals, ( 0, 0, 32 ) );
	defuseObject maps\mp\gametypes\_gameobjects::allowuse( "friendly" );
	defuseObject maps\mp\gametypes\_gameobjects::setusetime( level.defusetime );
	defuseObject maps\mp\gametypes\_gameobjects::setusetext( &"MP_DEFUSING_EXPLOSIVE" );
	defuseObject maps\mp\gametypes\_gameobjects::setusehinttext( &"PLATFORM_HOLD_TO_DEFUSE_EXPLOSIVES" );
	defuseObject maps\mp\gametypes\_gameobjects::setvisibleteam( "any" );
	defuseObject maps\mp\gametypes\_gameobjects::set2dicon( "friendly", "compass_waypoint_defuse" + label );
	defuseObject maps\mp\gametypes\_gameobjects::set2dicon( "enemy", "compass_waypoint_defend" + label );
	defuseObject maps\mp\gametypes\_gameobjects::set3dicon( "friendly", "waypoint_defuse" + label );
	defuseObject maps\mp\gametypes\_gameobjects::set3dicon( "enemy", "waypoint_defend" + label );
	defuseObject.label = label;
	defuseObject.onbeginuse = maps\mp\gametypes\sd::onbeginuse;
	defuseObject.onenduse = maps\mp\gametypes\sd::onenduse;
	defuseObject.onuse = maps\mp\gametypes\sd::onusedefuseobject;
	defuseObject.useweapon = "briefcase_bomb_defuse_mp";
	
	level.defuseobject = defuseObject;
	
	maps\mp\gametypes\sd::bombtimerwait();
	setdvar( "ui_bomb_timer", 0 );
	
	destroyedObj.visuals[ 0 ] maps\mp\gametypes\_globallogic::stoptickingsound();
	
	if ( level.gameended || level.bombdefused )
	{
		return;
	}
	
	level.bombexploded = true;
	
	explosionOrigin = level.sdbombmodel.origin;
	level.sdbombmodel hide();
	
	if ( isdefined( player ) )
	{
		destroyedObj.visuals[ 0 ] radiusdamage( explosionOrigin, 512, 200, 20, player );
	}
	else
	{
		destroyedObj.visuals[ 0 ] radiusdamage( explosionOrigin, 512, 200, 20 );
	}
	
	rot = randomfloat( 360 );
	explosionEffect = spawnfx( level._effect[ "bombexplosion" ], explosionOrigin + ( 0, 0, 50 ), ( 0, 0, 1 ), ( cos( rot ), sin( rot ), 0 ) );
	triggerfx( explosionEffect );
	
	thread maps\mp\gametypes\sd::playsoundinspace( "exp_suitcase_bomb_main", explosionOrigin );
	
	if ( isdefined( destroyedObj.exploderindex ) )
	{
		exploder( destroyedObj.exploderindex );
	}
	
	for ( index = 0; index < level.bombzones.size; index++ )
	{
		level.bombzones[ index ] maps\mp\gametypes\_gameobjects::disableobject();
	}
	
	defuseObject maps\mp\gametypes\_gameobjects::disableobject();
	
	setgameendtime( 0 );
	
	wait 3;
	
	maps\mp\gametypes\sd::sd_endgame( game[ "attackers" ], game[ "strings" ][ "target_destroyed" ] );
}
