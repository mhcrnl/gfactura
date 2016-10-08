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

    public class Empresa : Gtk.Box {

        public Empresa (Gtk.Application app) {
            this.orientation = Gtk.Orientation.HORIZONTAL;
            this.spacing = 0;
            var builder = new Gtk.Builder ();
            try {
                builder.add_from_file ("ui/empresa.ui");
                builder.connect_signals (app);
            } catch (Error e) {
                error ("Unable to load file: %s", e.message);
            }
            this.pack_start ((Gtk.Grid) builder.get_object ("grid"), true, true, 0);
        }

        [CCode (instance_pos = -1)]
        public void on_emp_close () {
            var mainstack = (Gtk.Stack) this.get_parent ().get_parent ().get_parent ();
            mainstack.set_visible_child_name ("welcome");
        }

        [CCode (instance_pos = -1)]
        public void on_change_photo (Gtk.Button e_logo) {
            var image = new Gtk.Image.from_file ("");
            var filter = new Gtk.FileFilter ();
            var dialog = new Gtk.FileChooserDialog ("Seleccionar logo",
                                        (Gtk.Window) e_logo.get_toplevel (),
                                        Gtk.FileChooserAction.OPEN,
                                        "Guardar", Gtk.ResponseType.ACCEPT,
                                        "Cancelar", Gtk.ResponseType.CANCEL);
            filter.set_filter_name ("Imágenes");
            dialog.add_filter (filter);
            filter.add_mime_type ("image/jpeg");
            filter.add_mime_type ("image/jpg");
            filter.add_mime_type ("image/png");

            switch (dialog.run ())
            {
                case Gtk.ResponseType.ACCEPT:
                    try {
                        var filename = dialog.get_filename ();
                        Gdk.Pixbuf pixbuf = new Gdk.Pixbuf.from_file_at_scale (filename, 96, 96, true);
                        image.set_from_pixbuf (pixbuf);
                    } catch (Error e) {
                        image.set_from_icon_name ("image-missing", Gtk.IconSize.DIALOG);
                    }
                    break;
                default:
                    break;
            }
            dialog.destroy ();
            e_logo.set_image (image);
            //TODO Save photo and data to DB;
        }

        [CCode (instance_pos = -1)]
        public void on_emp_save () {
            //TODO Save photo and data to DB;
            var mainstack = (Gtk.Stack) this.get_parent ().get_parent ().get_parent ();
            mainstack.visible_child_name = "welcome";
        }
    }
}
