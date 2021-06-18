/*
	_bot_http
	Author: INeedGames
	Date: 12/16/2020
	The HTTP module
*/

#include maps\mp\bots\_bot_utility;

/*
	Will attempt to retreive waypoints from the internet
*/
getRemoteWaypoints( mapname )
{
	url = "https://raw.githubusercontent.com/ineedbots/cod4x_waypoints/master/" + mapname + "_wp.csv";
	filename = "waypoints/" + mapname + "_wp.csv";

	printToConsole( "Attempting to get remote waypoints from " + url );
	res = getLinesFromUrl( url, filename );

	if ( !res.lines.size )
		return;

	waypointCount = int( res.lines[0] );

	waypoints = [];
	printToConsole( "Loading remote waypoints..." );

	for ( i = 1; i <= waypointCount; i++ )
	{
		tokens = tokenizeLine( res.lines[i], "," );

		waypoint = parseTokensIntoWaypoint( tokens );

		waypoints[i - 1] = waypoint;
	}

	if ( waypoints.size )
	{
		level.waypoints = waypoints;
		printToConsole( "Loaded " + waypoints.size + " waypoints from remote." );
	}
}

/*
	Does the version check, if we are up too date
*/
doVersionCheck()
{
	remoteVersion = getRemoteVersion();

	if ( !isDefined( remoteVersion ) )
	{
		printToConsole( "Error getting remote version of Bot Warfare." );
		return false;
	}

	if ( level.bw_VERSION != remoteVersion )
	{
		printToConsole( "There is a new version of Bot Warfare!" );
		printToConsole( "You are on version " + level.bw_VERSION + " but " + remoteVersion + " is available!" );
		return false;
	}

	printToConsole( "You are on the latest version of Bot Warfare!" );
	return true;
}

/*
	Returns the version of bot warfare found on the internet
*/
getRemoteVersion()
{
#if isSyscallDefined HTTPS_GetString
	data = HTTPS_GetString( "https://raw.githubusercontent.com/ineedbots/cod4x_waypoints/master/version.txt" );
#else
	data = undefined;
#endif

	if ( !isDefined( data ) )
		return undefined;

	return strtok( data, "\n" )[0];
}

/*
	Returns an array of each line from the response of the http url request
*/
getLinesFromUrl( url, filename )
{
	result = spawnStruct();
	result.lines = [];

#if isSyscallDefined HTTPS_GetString
	data = HTTPS_GetString( url );
#else
	data = undefined;
#endif

	if ( !isDefined( data ) )
		return result;

	fd = FS_FOpen( filename, "write" );

	line = "";

	for ( i = 0; i < data.size; i++ )
	{
		c = data[i];

		if ( c == "\n" )
		{
			result.lines[result.lines.size] = line;

			if ( fd > 0 )
			{
				if ( !FS_WriteLine( fd, line ) )
				{
					FS_FClose( fd );
					fd = 0;
				}
			}

			line = "";
			continue;
		}

		line += c;
	}

	result.lines[result.lines.size] = line;

	if ( fd > 0 )
		FS_FClose( fd );

	return result;
}
