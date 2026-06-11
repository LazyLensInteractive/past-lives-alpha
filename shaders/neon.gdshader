shader_type spatial;
render_mode diffuse_burley;
uniform vec2 window_scale = vec2(10.0, 70.0);
uniform sampler2D neon_gradient : hint_default_black;
uniform sampler2D noise_tex : hint_default_white, repeat_enable;
uniform float noise_scale : hint_range(0.1, 5.0) = 1.0;
uniform float movement_speed : hint_range(-2.0, 2.0) = 0.2;
uniform float min_brightness : hint_range(1.0, 10.0) = 3.0;
uniform float max_brightness : hint_range(1.0, 10.0) = 2.0;
uniform float pulse_speed : hint_range(0.1, 5.0) = 1.0;
float rand(vec2 co) {
    return fract(sin(dot(co.xy, vec2(12.9898, 78.233))) * 43758.5453123);
}

void fragment() {
    ALBEDO = vec3(0.0);
    vec2 grid_uv = UV * window_scale;
    vec2 grid = fract(grid_uv);
    vec2 grid_coord = floor(grid_uv);
    float windows_x = step(0.1, grid.x) * step(grid.x, 0.9);
    float windows_y = step(0.2, grid.y) * step(grid.y, 0.8);
    float window_pattern = 1.0 - (windows_x * windows_y);
    vec2 moving_uv = UV;
    moving_uv.y += TIME * movement_speed;
    float noise_val = texture(noise_tex, moving_uv * noise_scale).r;
    vec3 mixed_color = texture(neon_gradient, vec2(noise_val, 0.0)).rgb;
    float pulse_wave = (sin(TIME * pulse_speed) + 1.0) * 0.5;
    float current_brightness = mix(min_brightness, max_brightness, pulse_wave);
    float rand_var = 1.0 - rand(grid_coord) * 0.15;
    vec3 dynamic_color = mixed_color * rand_var * current_brightness;
    EMISSION = dynamic_color * window_pattern;
}