init()
{
	level.bot_builtins[ "printconsole" ] = ::do_printconsole;
	level.bot_builtins[ "fileexists" ] = ::do_fileexists;
	level.bot_builtins[ "botaction" ] = ::do_botaction;
	level.bot_builtins[ "botstop" ] = ::do_botstop;
	level.bot_builtins[ "botmovement" ] = ::do_botmovement;
	level.bot_builtins[ "botmoveto" ] = ::do_botmoveto;
	level.bot_builtins[ "botmeleeparams" ] = ::do_botmeleeparams;
	level.bot_builtins[ "isbot" ] = ::do_isbot;
	level.bot_builtins[ "fs_fopen" ] = ::do_fs_fopen;
	level.bot_builtins[ "fs_fclose" ] = ::do_fs_fclose;
	level.bot_builtins[ "fs_readline" ] = ::do_fs_readline;
	level.bot_builtins[ "fs_writeline" ] = ::do_fs_writeline;
}

do_printconsole( s )
{
	println( s );
}

do_fileexists( file )
{
	file = "scriptdata/" + file;
	return fs_testfile( file );
}

do_botaction( action )
{
	self botaction( action );
}

do_botstop()
{
	self botstop();
}

do_botmovement( forward, right )
{
}

do_botmoveto( where )
{
	self botmoveto( where );
}

do_botmeleeparams( yaw, dist )
{
	// cod4x removed lunging due to movement exploits
}

do_isbot()
{
	return self.isbot;
}

do_fs_fopen( file, mode )
{
	file = "scriptdata/" + file;
	return fs_fopen( file, mode );
}

do_fs_fclose( fh )
{
	fs_fclose( fh );
}

do_fs_readline( fh )
{
	return fs_readline( fh );
}

do_fs_writeline( fh, contents )
{
	fs_writeline( fh, contents );
}
