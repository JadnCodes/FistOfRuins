/// STEP EVENT

// --- Horizontal input (keyboard + controller) ---
var move = keyboard_check(vk_right) - keyboard_check(vk_left);

// Add controller input
var axisX = gamepad_axis_value(gamepad_index, gp_axislh);

// Deadzone check (to avoid stick drift)
if (abs(axisX) > 0.2) {
    move = axisX; // analog movement
}

// Convert to horizontal speed
hsp = move * move_speed;

// --- Apply gravity ---
vsp += gravity_val;
if (vsp > max_fall_speed) vsp = max_fall_speed;

// --- Ground check ---
if (place_meeting(x, y + 1, obj_Wall)) {
    on_ground = true;
} else {
    on_ground = false;
}

// --- Jump input (keyboard + controller) ---
var jump_pressed = keyboard_check_pressed(vk_space) 
                || gamepad_button_check_pressed(gamepad_index, gp_face1);

if (on_ground && jump_pressed) {
    vsp = jump_speed;
}

// --- Variable jump (keyboard + controller) ---
var jump_held = keyboard_check(vk_space) 
             || gamepad_button_check(gamepad_index, gp_face1);

if (!jump_held && vsp < 0) {
    vsp += gravity_val * 2;
}

// --- Horizontal collision ---
if (place_meeting(x + hsp, y, obj_Wall)) {
    while (!place_meeting(x + sign(hsp), y, obj_Wall)) {
        x += sign(hsp);
    }
    hsp = 0;
}
x += hsp;

// --- Vertical collision ---
if (place_meeting(x, y + vsp, obj_Wall)) {
    while (!place_meeting(x, y + sign(vsp), obj_Wall)) {
        y += sign(vsp);
    }
    vsp = 0;
}
y += vsp;





// --- SNAP PLAYER TO INTEGER PIXELS ---
x = floor(x);
y = floor(y);

// --- CAMERA SMOOTH FOLLOW ---
var player_cx = x + sprite_width / 2;
var player_cy = y + sprite_height / 2;

var cam_x = player_cx - cam_width / 2;
var cam_y = player_cy - cam_height / 2;

var target_x = lerp(camera_get_view_x(view_camera), cam_x, cam_speed);
var target_y = lerp(camera_get_view_y(view_camera), cam_y, cam_speed);

camera_set_view_pos(view_camera, floor(target_x), floor(target_y));