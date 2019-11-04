if (elementType == 1)
{
	var changeSpeed = 300000;
	
	if (!mouse_check_button(mb_left) && elementButtonWasDown)
		elementButtonWasDown = false;
	
	if (mouse_x > x && mouse_x < x + elementButtonWidth && mouse_y > y && mouse_y < y + elementButtonHeight)
	{
		var change = (delta_time / changeSpeed);
		
		if (!mouse_check_button(mb_left))
		{
			if (elementButtonFade - change > 0.8)
				elementButtonFade -= change;
			else
				elementButtonFade = 0.8;
		}
		else if (!global.button_down)
		{
			global.button_down = true;
			global.button_down_anti_mouse_left = true;
			elementButtonWasDown = true;
			elementButtonFade = 0.65;
			
			script_execute(elementButtonCallback);
		}
	}
	else
	{
		var change = (delta_time / changeSpeed);
		
		if (!mouse_check_button(mb_left) && !elementButtonWasDown)
		{
			if (elementButtonFade + change < 1.0)
				elementButtonFade += change;
			else
				elementButtonFade = 1.0;
		}
	}
}