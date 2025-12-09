//window_set_fullscreen(true);
window_set_size(1280, 720);

var w = display_get_width();
var h = display_get_height();

surface_resize(application_surface, w, h);
display_set_gui_size(w, h);

audio_play_sound(_356_8_bit_chiptune_game_music_357518, 0, true);