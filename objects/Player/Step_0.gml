// Camera
if(window_has_focus())
{
	look_dir -= (window_mouse_get_x() - window_get_width() / 2) / camera_speed;
	look_pitch += (window_mouse_get_y() - window_get_height() / 2) / camera_speed;
	look_pitch = clamp(look_pitch, camera_min_y, camera_max_y);
	
	window_mouse_set(window_get_width() / 2, window_get_height() / 2);
	
	if(!keyboard_check(vk_tab))
	{ window_set_cursor(cr_none); }
	else
	{ window_set_cursor(cr_default); }
	
	// Interaction with BackPack
    if (!backpack && Camera.interact && mouse_check_button_pressed(mb_right) && (playerstate = state.Crouch || playerstate = state.Prone))
	{
		instance_destroy(BackPack);
		Camera.interact = false;
		backpack = true;
	}
}

// Movement
// Run
if (keyboard_check(vk_shift) && playerstate != state.Crouch && playerstate != state.Prone)
{ playerstate = state.Run; }
if (keyboard_check_released(vk_shift) && playerstate != state.Crouch && playerstate != state.Prone)
{ playerstate = state.Idle; }

// Crouch
if (keyboard_check_pressed(vk_control) && !under_solid)
{
	if (playerstate = state.Idle || playerstate = state.Walk || playerstate == state.Prone || playerstate == state.Run)
	{ playerstate = state.Crouch }
	else
	{ playerstate = state.Idle  }
}

// Prone
if (keyboard_check_pressed(ord("C")) && !under_solid)
{
	if (playerstate = state.Idle || playerstate = state.Walk || playerstate == state.Crouch || playerstate == state.Run)
	{ playerstate = state.Prone; }
	else
	{ playerstate = state.Crouch;  }
	
}

// Basic movement
if (keyboard_check(ord("Q"))) {
    x -= dsin(look_dir) * move_speed;
    y -= dcos(look_dir) * move_speed;
	
	if(playerstate = state.Idle)
	{ playerstate = state.Walk; }
}
if (keyboard_check(ord("D"))) {
    x += dsin(look_dir) * move_speed;
    y += dcos(look_dir) * move_speed;
	
	if(playerstate = state.Idle)
	{ playerstate = state.Walk; }
}
if (keyboard_check(ord("Z"))) {
    x += dcos(look_dir) * move_speed;
    y -= dsin(look_dir) * move_speed;
	
	if(playerstate = state.Idle)
	{ playerstate = state.Walk; }
}
if (keyboard_check(ord("S"))) {
    x -= dcos(look_dir) * move_speed;
    y += dsin(look_dir) * move_speed;
	
	if(playerstate = state.Idle)
	{ playerstate = state.Walk; }
}
if (!keyboard_check(ord("Q")) && !keyboard_check(ord("D")) && !keyboard_check(ord("Z")) && !keyboard_check(ord("S")))
{
	if (playerstate != state.Crouch && playerstate != state.Prone)
	{ playerstate = state.Idle }
}

// Backpack
if (keyboard_check_pressed(ord("B")) && backpack)
{
	var bp = instance_create_depth(x, y, 0, BackPack);
	bp.image_xscale = 3;
	bp.image_yscale = 3;
	backpack = false;
}

// State machine
switch(playerstate)
{
	case state.Idle:
		headbob = 1 * abs(sin(current_time/1000)) + 5;
		z = headbob + baselevel + 64;
		break;
		
	case state.Walk:
		headbob = 2 * abs(sin(current_time/300)) + 1;
		z = headbob + baselevel + 64;
		move_speed = 2;
		break;
		
	case state.Run:
		headbob = 5 * abs(sin(current_time/100)) + 3;
		z = headbob + baselevel + 64;
		move_speed = 4;
		break;
		
	case state.Crouch:
		headbob = 0;
		z = headbob + baselevel + 32;
		move_speed = .5;
		break;
		
	case state.Prone:
		headbob = 0;
		z = headbob + baselevel + 8;
		move_speed = .25;
		break;
}

under_solid = false; 

if(keyboard_check_pressed(ord("R")))
{ game_restart(); }

if(mouse_check_button_pressed(mb_left) && !shooting)
{
	shooting = true;
	alarm[0] = 2;
}