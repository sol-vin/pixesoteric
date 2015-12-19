#!/usr/bin/env ruby

require 'gtk3'
require_relative '../machine'

#container for the whole window
window_box = Gtk::Box.new(:vertical, 0)

#container for the viewer
viewer_box = Gtk::Box.new(:horizontal, 0)

#container for stats
stats_box = Gtk::Box.new(:horizontal, 0)

#box with the tool bar
toolbar_box = Gtk::Box.new(:horizontal, 0)

#special group for play pause restart
machine_controls = Gtk::Table.new(2, 2, true)

#original instructions image
pixbuf = Gdk::Pixbuf.new("../programs/project_euler_2.bmp")
#Scale up so we can see it
pixbuf = pixbuf.scale(pixbuf.width * 8.0, pixbuf.height * 8.0, Gdk::Pixbuf::INTERP_TILES)

##image widget to draw
image = Gtk::Image.new(file: "../programs/project_euler_2.bmp")
image.pixbuf = pixbuf

#put the image into the viewer box
viewer_box.pack_start(image, expand: true, fill: true, padding: 0)


#stats box controls
cycles_label = Gtk::Label.new("Cycles: 0")

stats_box.pack_start(cycles_label, expand: false, fill: false, padding: 0)

#tool bar buttons
previous_step_button = Gtk::Button.new(label: "<-")
zoom_in_button = Gtk::Button.new(label: "Z+")
zoom_out_button = Gtk::Button.new(label: "Z-")
inspect_machine_button = Gtk::Button.new(label: "IM")
inspect_thread_button = Gtk::Button.new(label: "IT")
run_machine_button = Gtk::Button.new(label: "Run")
pause_machine_button = Gtk::Button.new(label: "Pause")
restart_machine_button = Gtk::Button.new(label: "Restart")
next_step_button = Gtk::Button.new(label: "->")

#put them into the toolbar
toolbar_box.pack_start(previous_step_button, expand: true, fill: true, padding: 0)
toolbar_box.pack_start(zoom_in_button, expand: true, fill: true, padding: 0)
toolbar_box.pack_start(zoom_out_button, expand: true, fill: true, padding: 0)
toolbar_box.pack_start(inspect_machine_button, expand: true, fill: true, padding: 0)
toolbar_box.pack_start(inspect_thread_button, expand: true, fill: true, padding: 0)
toolbar_box.pack_start(machine_controls, expand: true, fill: true, padding: 0)
toolbar_box.pack_start(next_step_button, expand: true, fill: true, padding: 0)

#options for the play pause restart table
options = Gtk::AttachOptions::EXPAND|Gtk::AttachOptions::FILL
#put our controls on the table
machine_controls.attach(run_machine_button, 0, 2, 0, 1, options, options, 0, 0)
machine_controls.attach(pause_machine_button, 0, 1, 1, 2, options, options, 0, 0)
machine_controls.attach(restart_machine_button, 1, 2, 1, 2, options, options, 0, 0)

#put all the boxes into the window
window_box.pack_start(viewer_box, expand: true, fill: false, padding: 20)
window_box.pack_start(stats_box, expand: true, fill: false, padding: 20)
window_box.pack_start(toolbar_box, expand: true, fill: true, padding: 0)

window = Gtk::Window.new
window.title = "Pixesoteric Viewer"
window.set_size_request 400, 300

window.signal_connect(:delete_event) {
  puts "delete event occurred"
  #true
  false
}

window.signal_connect(:destroy) {
  puts "destroy event occurred"
  Gtk.main_quit
}

window.border_width = 10
window.add(window_box)
window.show_all

Gtk.main