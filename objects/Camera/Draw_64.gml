/// @description Draw stuff on the GUI
var stateText;

switch(Player.playerstate)
{
	case 0:
		stateText = "idle";
		break;
		
	case 1:
		stateText = "walking";
		break;
		
	case 2:
		stateText = "running";
		break;
		
	case 3:
		stateText = "crouching";
		break;
		
	case 4:
		stateText = "prone";
		break;
}

// Log
if (keyboard_check(vk_tab))
{
	draw_text(0, 0, $"Player is {stateText}. X: {Player.x} Y: {Player.y} Z: {Player.z}");
	draw_text(0, 15, $"Visible solid [SOLID]: {instance_number(Solid)}");
	draw_text(0, 30, $"Invisible solid [BARRIER]: {instance_number(Barrier)}");
	draw_text(0, 45, $"Roofs: {instance_number(Roof)}");
	draw_text(0, 60, $"Backpack: {GameController.hasbackpack}");
	draw_text(0, 75, $"Interact: {interact}");
	draw_text(0, 90, $"FPS: {string(round(fps_real))}");
	draw_text(0, 105, $"Look direction {Player.look_dir} | Look pitch {Player.look_pitch} | Interact point {Player.interactpoint[0]} | {Player.interactpoint[1]} | {Player.interactpoint[2]}");
	
}

// Draw interactible hand
if (interact)
{ draw_sprite(spr_hand, 0, mouse_x, mouse_y); }
else
{
	// Draw crosshair
	draw_point(room_width/2, room_height/2);
	draw_circle(room_width/2 + lerp(0 + recoil_x, window_mouse_get_x() - window_get_width() / 2, .1), room_height/2 + lerp(0 - recoil_y, window_mouse_get_y() - window_get_height() / 2, .1), 8, 1);
}



// Draw equipped weapon
draw_sprite_ext(spr_gui_pistol, 0, room_width + lerp(0, window_mouse_get_x() - window_get_width() / 2, .1), room_height + (Player.headbob * 3), 3, 3, 0, c_dkgray, 1);