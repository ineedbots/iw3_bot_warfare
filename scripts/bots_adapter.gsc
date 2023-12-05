init()
{
	level.bot_builtins["printconsole"] = ::do_printconsole;
	level.bot_builtins["filewrite"] = ::do_filewrite;
	level.bot_builtins["fileread"] = ::do_fileread;
	level.bot_builtins["fileexists"] = ::do_fileexists;
	level.bot_builtins["botaction"] = ::do_botaction;
	level.bot_builtins["botstop"] = ::do_botstop;
	level.bot_builtins["botmovement"] = ::do_botmovement;
	level.bot_builtins["botmoveto"] = ::do_botmoveto;
	level.bot_builtins["isbot"] = ::do_isbot;
	level.bot_builtins["fs_fopen"] = ::do_fs_fopen;
	level.bot_builtins["fs_fclose"] = ::do_fs_fclose;
	level.bot_builtins["fs_readline"] = ::do_fs_readline;
	level.bot_builtins["fs_writeline"] = ::do_fs_writeline;
}

do_printconsole( s )
{
	println( s );
}

do_filewrite( file, contents, mode )
{
	file = "scriptdata/" + file;
	f = FS_FOpen( file, mode );

	// always adds newline, strip from contents
	if ( contents[contents.size - 1] == "\n" )
	{
		contents = getsubstr( contents, 0, contents.size - 1 );
	}

	FS_WriteLine( f, contents );

	FS_FClose( f );
}

do_fileread( file )
{
	file = "scriptdata/" + file;
	answer = "";

	f = FS_FOpen( file, "read" );
	line = FS_ReadLine( f );

	while ( isDefined( line ) )
	{
		answer += line + "\n";
		line = FS_ReadLine( f );
	}

	FS_FClose( f );
	return answer;
}

do_fileexists( file )
{
	file = "scriptdata/" + file;
	return FS_TestFile( file );
}

do_botaction( action )
{
	self BotAction( action );
}

do_botstop()
{
	self BotStop();
}

do_botmovement( left, forward )
{
}

do_botmoveto( where )
{
	self BotMoveTo( where );
}

do_isbot()
{
	return self.isbot;
}

do_fs_fopen( file, mode )
{
	file = "scriptdata/" + file;
	return FS_FOpen( file, mode );
}

do_fs_fclose( fh )
{
	FS_FClose( fh );
}

do_fs_readline( fh )
{
	return FS_ReadLine( fh );
}

do_fs_writeline( fh, contents )
{
	FS_WriteLine( fh, contents );
}