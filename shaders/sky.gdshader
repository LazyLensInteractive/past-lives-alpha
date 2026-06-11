shader_type sky;
uniform vec3 color_zenith : source_color = vec3(0.00, 0.00, 0.02);
uniform vec3 color_horizon : source_color = vec3(0.04, 0.02, 0.08);
uniform float star_density : hint_range(1.0, 100.0) = 40.0;
uniform float star_size : hint_range(0.01, 0.5) = 0.15;
uniform float flicker_speed : hint_range(0.5, 10.0) = 3.0;
float rand(vec2 co) {
    return fract(sin(dot(co.xy, vec2(12.9898, 78.233))) * 43758.5453123);
}
void sky() {
    float horizon_mask = smoothstep(-0.1, 0.6, EYEDIR.y);
    vec3 sky_color = mix(color_horizon, color_zenith, horizon_mask);
    vec2 sky_uv = vec2(atan(EYEDIR.z, EYEDIR.x), asin(EYEDIR.y));
    vec2 scaled_uv = sky_uv * star_density;
    vec2 grid_coord = floor(scaled_uv);
    vec2 grid_frac = fract(scaled_uv);
    vec2 star_offset = vec2(rand(grid_coord), rand(grid_coord + 1.0));
    float dist = distance(grid_frac, star_offset);
    float star_shape = smoothstep(star_size, 0.0, dist);
    float unique_star_id = rand(grid_coord);
    float flicker = mix(0.2, 1.0, sin(TIME * flicker_speed + (unique_star_id * 50.0)) * 0.5 + 0.5);
    float final_stars = star_shape * flicker;
    COLOR = sky_color + vec3(final_stars);
}