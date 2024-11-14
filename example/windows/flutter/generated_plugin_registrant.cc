//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <highlights_plugin/highlights_plugin_c_api.h>
#include <kode_view/kode_view_plugin_c_api.h>

void RegisterPlugins(flutter::PluginRegistry* registry) {
  HighlightsPluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("HighlightsPluginCApi"));
  KodeViewPluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("KodeViewPluginCApi"));
}
