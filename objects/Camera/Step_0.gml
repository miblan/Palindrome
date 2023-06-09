if(Player.shooting)
{
	lightrange = 100;
	randomize();
	recoil_x += irandom_range(-4, 4);
	recoil_y = irandom_range(16,48);
}
else
{
	lightrange = 0
	recoil_x = lerp(recoil_x, 0, .5);
	recoil_y = lerp(recoil_y, 0, .1)
}