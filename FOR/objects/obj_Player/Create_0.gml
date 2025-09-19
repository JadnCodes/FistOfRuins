//Movement Varibles
move_speed = 4;
jump_speed = -8;
gravity_val = 0.5;
max_fall_speed = 10;
gamepad_index = 0;

//State Varibles
hsp = 0;
vsp = 0;
on_ground = false;



// ================== CAMERA SETTINGS ==================
cam_width  = 320;   // camera world width
cam_height = 180;   // camera world height
cam_speed  = 0.1;   // smooth follow factor

// Create camera
view_camera = camera_create_view(0, 0, cam_width, cam_height);
camera_set_view_target(view_camera, id);  // initial target = player

