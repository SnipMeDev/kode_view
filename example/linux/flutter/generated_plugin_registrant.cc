//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <highlights_plugin/highlights_plugin.h>
#include <kode_view/kode_view_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) highlights_plugin_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "HighlightsPlugin");
  highlights_plugin_register_with_registrar(highlights_plugin_registrar);
  g_autoptr(FlPluginRegistrar) kode_view_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "KodeViewPlugin");
  kode_view_plugin_register_with_registrar(kode_view_registrar);
}
