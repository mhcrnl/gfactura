/*
* Copyright (C) 2016 bitseater <bitseater@gmail.com>
*
* This file is part of GFactura.
*
* GFactura is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
*
* GFactura is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with GFactura. If not, see <http://www.gnu.org/licenses/>.
*
* Author: bitseater <bitseater@gmail.com>
*/
namespace GFactura.Widgets {

    public class General : Gtk.Box {

        public General (Gtk.Application app) {
            this.orientation = Gtk.Orientation.HORIZONTAL;
            this.spacing = 0;
            var builder = new Gtk.Builder ();
            try {
                builder.add_from_file ("ui/general.ui");
                builder.connect_signals (app);
            } catch (Error e) {
                error ("Unable to load file: %s", e.message);
            }
            this.pack_start ((Gtk.Grid) builder.get_object ("gengrid"), true, true, 0);
        }

        [CCode (instance_pos = -1)]
        public void on_gen_close () {
            var mainstack = (Gtk.Stack) this.get_parent ().get_parent ().get_parent ();
            mainstack.set_visible_child_name ("welcome");
        }

        [CCode (instance_pos = -1)]
        public void on_gen_save () {
            //TODO Save data to DB;
            var mainstack = (Gtk.Stack) this.get_parent ().get_parent ().get_parent ();
            mainstack.visible_child_name = "welcome";
        }
    }
}
