//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <connectivity_plus/connectivity_plus_windows_plugin.h>
#include <flutter_device_info_plus/flutter_device_info_plus_plugin_c_api.h>

void RegisterPlugins(flutter::PluginRegistry* registry) {
  ConnectivityPlusWindowsPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("ConnectivityPlusWindowsPlugin"));
  FlutterDeviceInfoPlusPluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("FlutterDeviceInfoPlusPluginCApi"));
}
