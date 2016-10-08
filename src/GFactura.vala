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
namespace GFactura {

    public class GFacturaApp : Gtk.Application {

        private MainWindow window;

        public GFacturaApp () {
            application_id = "org.gtk.gfactura";
            flags |= GLib.ApplicationFlags.HANDLES_OPEN;
        }

        public override void activate () {
            if (get_windows () == null) {
                window = new MainWindow (this);
                window.show_all ();
            } else {
                window.present ();
            }
        }

        public override void open (File [] files, string hint) {
            //TODO
        }
    }

    public static int main (string[] args) {
        var app = new GFacturaApp ();
        return app.run (args);
    }
}
