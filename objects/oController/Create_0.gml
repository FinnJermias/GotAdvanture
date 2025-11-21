window_set_fullscreen(true);

var w = display_get_width();
var h = display_get_height();

surface_resize(application_surface, w, h);
display_set_gui_size(w, h);


