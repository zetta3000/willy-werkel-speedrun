// https://github.com/LiveSplit/LiveSplit.AutoSplitters

// Example:
// https://github.com/tduva/LiveSplit-ASL/blob/master/AlanWake.asl


state("Willy32")
{
	// 0 no, 18 yes
	byte is_intro_finished : 0x1355E0;
	
	// 0 no, 1 yes
	byte is_cutscene_playing : 0x1368F1;
	
	// cutscene_id01 / cutscene_id02
	// 5 / 1,3,5,7,...	Fia found
	// 11 / 59,61,...	Fia returned
	// 7 / 1,2			Return to garage (from world map or front yard)
	// 7 / 40,41		Leave the garage (big left door)
	// 5 / 3,7,13,...	Megaphone found
	// 6 / 16,17,18,...	Sea
	byte cutscene_id01 : 0x12F79C;
	byte cutscene_id02 : 0x12F798;
}

init
{
	vars.splits = 0;
	
	// When a cutscene is running (is_cutscene_playing==1) and triggers an event, we set has_cutscene_triggered to 1.
	// After the cutscene has ended (is_cutscene_playing==0) we set has_cutscene_triggered back to 0.
	// This way, a cutscene cannot trigger more than one event.
	vars.has_cutscene_triggered = 0;
	
	// After returning Fia, return_counter_enabled is set to 1 (enabled).
	// From then on, return_counter counts the number of returns to the garage from the world map.
	// The 1st delivery happens after 3 returns, the 2nd delivery after 6 returns, and so on.
	vars.return_counter_enabled = 0;
	vars.return_counter = 0;
}

start
{
	if (current.is_intro_finished == 18)
	{
		return true;
	}
}

split
{
	if (current.is_cutscene_playing == 1 && vars.has_cutscene_triggered == 0)
	{
		// Fia found
		if (current.cutscene_id01 == 5 && vars.splits == 0)
		{
			vars.splits = vars.splits + 1;
			vars.has_cutscene_triggered = 1;
			return true;
		}
		// Fia returned
		if (current.cutscene_id01 == 11 && vars.splits == 1)
		{
			vars.splits = vars.splits + 1;
			vars.has_cutscene_triggered = 1;
			vars.return_counter_enabled = 1;
			return true;
		}
		// Megaphone
		if (current.cutscene_id01 == 5 && vars.splits == 7)
		{
			vars.splits = vars.splits + 1;
			vars.has_cutscene_triggered = 1;
			return true;
		}
		// Sea
		if (current.cutscene_id01 == 6 && vars.splits == 8)
		{
			vars.splits = vars.splits + 1;
			vars.has_cutscene_triggered = 1;
			return true;
		}
	}
	// The 2nd delivery happens after 6 returns.
	if (vars.return_counter == 6 && vars.splits == 2)
	{
		vars.splits = vars.splits + 1;
		return true;
	}
	// The 4th delivery happens after 12 returns.
	if (vars.return_counter == 12 && vars.splits == 3)
	{
		vars.splits = vars.splits + 1;
		return true;
	}
	// The 6th delivery happens after 18 returns.
	if (vars.return_counter == 18 && vars.splits == 4)
	{
		vars.splits = vars.splits + 1;
		return true;
	}
	// The 8th delivery happens after 24 returns.
	if (vars.return_counter == 24 && vars.splits == 5)
	{
		vars.splits = vars.splits + 1;
		return true;
	}
	// The 10th delivery happens after 30 returns.
	if (vars.return_counter == 30 && vars.splits == 6)
	{
		vars.splits = vars.splits + 1;
		return true;
	}
}

update
{
	// Set has_cutscene_triggered back to 0 after a cutscene has ended.
	if (current.is_cutscene_playing == 0 && vars.has_cutscene_triggered == 1)
	{
		vars.has_cutscene_triggered = 0;
	}
	// Count the number of returns to the garage after return_counter_enabled has been set to 1 (when returning Fia).
	if (vars.return_counter_enabled == 1 && current.is_cutscene_playing == 1 && vars.has_cutscene_triggered == 0 && current.cutscene_id01 == 7 && current.cutscene_id02 == 1)
	{
		vars.has_cutscene_triggered = 1;
		vars.return_counter = vars.return_counter + 1;
	}	
}
	
