//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <kode_view/kode_view_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) kode_view_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "KodeViewPlugin");
  kode_view_plugin_register_with_registrar(kode_view_registrar);
}
