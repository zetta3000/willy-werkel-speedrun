// https://github.com/LiveSplit/LiveSplit.AutoSplitters

// Example:
// https://github.com/tduva/LiveSplit-ASL/blob/master/AlanWake.asl

state("Willy32")
{
	// 0 no, 18 yes
	int is_intro_finished : 0x1355E0;
	
	// 0 no, 1 yes
	byte is_cutscene_playing : 0x1368F1;
	
	// 5 Fia found
	// 11 Fia returned
	// 6 Cyberspace
	// 6 Villa Mia
	// 5 Tires found
	// 5 Megaphon found
	// 6 Ocean
	byte cutscene_id : 0x12F79C;
}

init
{
	vars.counter = 1;
	// The reaason for needing the cutscene_triggered variable is that different cutscenes can have the same cutscene_id.
	// Once a cutscene runs and triggers a split, we do not want this cutscene to trigger a second split.
	// After a cutscene is over, cutscene_triggered is changed back to 0.
	vars.cutscene_triggered = 0;
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
	if (current.is_cutscene_playing == 1 && vars.cutscene_triggered == 0)
	{
		if (current.cutscene_id == 5 && vars.counter == 1)
		{
			vars.counter = vars.counter + 1;
			vars.cutscene_triggered = 1;
			return true;
		}
		if (current.cutscene_id == 11 && vars.counter == 2)
		{
			vars.counter = vars.counter + 1;
			vars.cutscene_triggered = 1;
			return true;
		}
		if (current.cutscene_id == 6 && vars.counter == 3)
		{
			vars.counter = vars.counter + 1;
			vars.cutscene_triggered = 1;
			return true;
		}
		if (current.cutscene_id == 6 && vars.counter == 4)
		{
			vars.counter = vars.counter + 1;
			vars.cutscene_triggered = 1;
			return true;
		}
		if (current.cutscene_id == 5 && vars.counter == 5)
		{
			vars.counter = vars.counter + 1;
			vars.cutscene_triggered = 1;
			return true;
		}
		if (current.cutscene_id == 5 && vars.counter == 6)
		{
			vars.counter = vars.counter + 1;
			vars.cutscene_triggered = 1;
			return true;
		}
		if (current.cutscene_id == 6 && vars.counter == 7)
		{
			vars.counter = vars.counter + 1;
			vars.cutscene_triggered = 1;
			return true;
		}
	}
}

update
{
	if (current.is_cutscene_playing == 0 && vars.cutscene_triggered == 1)
	{
		vars.cutscene_triggered = 0;
	}
}
	