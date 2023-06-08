baselevel = 0;
headbob = 0;
z = headbob + baselevel + 64;

hitbox = .5;

look_dir = 0;
look_pitch = 0;
camera_speed = 4;
camera_min_y = -80;
camera_max_y = 80;
move_speed = 5;
playerstate = state.Walk;
backpack = true;
interact_distance = 32;
under_solid = false;

shooting = false;

enum state {
	Idle,
	Walk,
	Run,
	Crouch,
	Prone,
}

image_xscale = hitbox;
image_yscale = hitbox;