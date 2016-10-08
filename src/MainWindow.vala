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

    public class MainWindow : Gtk.ApplicationWindow {

        private GFacturaApp app;
        private Gtk.Stack mainstack = new Gtk.Stack ();
        private Gtk.ActionBar footbar = new Gtk.ActionBar ();
        private Gtk.Box box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);

        private const ActionEntry[] actions = {
            { "empresa", empresa_cb },
            { "general", general_cb },
            { "prefer", prefer_cb },
            { "help", help_cb },
            { "about", about_cb },
            { "quit", quit_cb }
        };

        // Callbacks
        private void empresa_cb (SimpleAction action, Variant? parameter) {
            mainstack.visible_child_name = "empresa";
        }

        private void general_cb (SimpleAction action, Variant? parameter) {
            //TODO;
        }

        private void prefer_cb (SimpleAction action, Variant? parameter) {
            //TODO;
        }

        private void help_cb (SimpleAction action, Variant? parameter) {
            try {
                Gtk.show_uri (this.get_screen (),
                        "help:GFactura",
                        Gtk.get_current_event_time ());
            } catch (GLib.Error e) {
                warning ("Error mostrando ayuda: %s", e.message);
            }
        }

        private void about_cb (SimpleAction action, Variant? parameter) {
            string[] authors = {"bitseater <bitseater@gmail.com>", null};
            string web = "https://github.com/bitseater/gfactura";

            Gtk.show_about_dialog (this, "artists", authors,
                    "authors", authors,
                    "comments", "Programa de gestión de clientes y facturación en Vala y Gtk+",
                    "copyright", ("Copyright \xc2\xa9 2016 bitseater"),
                    "documenters", authors,
                    "license_type", Gtk.License.GPL_3_0,
                    "logo_icon_name", "gfactura",
                    "program-name", ("GFactura"),
                    "translator_credits", web,
                    "version", "0.1",
                    "website", web,
                    "website_label", "Sitio web de GFactura",
                    "wrap_license", true);
        }

        private void quit_cb (SimpleAction action, Variant? parameter) {
            app.quit ();
        }

        public MainWindow (GFacturaApp app) {
            this.app = app;
            this.application = app;
            this.show_menubar = true;
            this.maximize ();

            this.set_size_request (1024, 768);
            this.window_position = Gtk.WindowPosition.CENTER;

            // Headerbar
            var header = new Gtk.HeaderBar ();
            header.show_close_button = true;
            header.title = "GFactura";
            this.set_titlebar (header);
            var button1 = new Gtk.Button.from_icon_name ("open-menu-symbolic", Gtk.IconSize.BUTTON);
            button1.clicked.connect (() => {
               //TODO
            });
            var button2 = new Gtk.Button.from_icon_name ("edit-find-symbolic", Gtk.IconSize.BUTTON);
            button2.clicked.connect (() => {
               //TODO
            });
            header.pack_end (button1);
            header.pack_end (button2);

            // Menú
            this.add_action_entries (actions, this);
            var builder = new Gtk.Builder ();
            try {
                builder.add_from_file ("ui/menus.ui");
            } catch (Error e) {
                error ("No se puede cargar el archivo : %s", e.message);
            }
            app.menubar = (MenuModel) builder.get_object ("menubar");

            // Mainstack
            mainstack.transition_type = Gtk.StackTransitionType.SLIDE_LEFT_RIGHT;
            var label = new Gtk.Label ("<big>Bienvenidos a GFactura</big>");
            label.use_markup = true;
            mainstack.add_named (label, "welcome");
            mainstack.visible_child_name = "welcome";
            var empresa = new GFactura.Widgets.Empresa (app);
            mainstack.add_named (empresa, "empresa");

            // Footbar
            footbar.pack_start (new Gtk.Label ("Bienvenidos a GFactura"));

            box.pack_start (mainstack, true, false, 0);
            box.pack_end (footbar, false, false, 0);

            this.add (box);

            this.show_all ();
        }
    }
}
