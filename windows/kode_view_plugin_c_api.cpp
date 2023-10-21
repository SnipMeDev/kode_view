#include "include/kode_view/kode_view_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "kode_view_plugin.h"

void KodeViewPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  kode_view::KodeViewPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
