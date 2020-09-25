getRemoteWaypoints(mapname)
{
  println("MAP");
}

getRemoteVersion()
{
  println("VERSION");
}

doVersionCheck()
{
	remoteVersion = getRemoteVersion();

	if (!isDefined(remoteVersion))
	{
		println("Error getting remote version of Bot Warfare.");
		return false;
	}

	if (level.bw_VERSION != remoteVersion)
	{
		println("There is a new version of Bot Warfare!");
		println("You are on version " + level.bw_VERSION + " but " + remoteVersion + " is available!");
		return false;
	}

	println("You are on the latest version of Bot Warfare!");
	return true;
}
