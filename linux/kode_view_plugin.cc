#include "include/kode_view/kode_view_plugin.h"

#include <flutter_linux/flutter_linux.h>
#include <gtk/gtk.h>
#include <sys/utsname.h>

#include <cstring>

#define KODE_VIEW_PLUGIN(obj) \
  (G_TYPE_CHECK_INSTANCE_CAST((obj), kode_view_plugin_get_type(), \
                              KodeViewPlugin))

struct _KodeViewPlugin {
  GObject parent_instance;
};

G_DEFINE_TYPE(KodeViewPlugin, kode_view_plugin, g_object_get_type())

// Called when a method call is received from Flutter.
static void kode_view_plugin_handle_method_call(
    KodeViewPlugin* self,
    FlMethodCall* method_call) {
  g_autoptr(FlMethodResponse) response = nullptr;

  const gchar* method = fl_method_call_get_name(method_call);

  if (strcmp(method, "getPlatformVersion") == 0) {
    struct utsname uname_data = {};
    uname(&uname_data);
    g_autofree gchar *version = g_strdup_printf("Linux %s", uname_data.version);
    g_autoptr(FlValue) result = fl_value_new_string(version);
    response = FL_METHOD_RESPONSE(fl_method_success_response_new(result));
  } else {
    response = FL_METHOD_RESPONSE(fl_method_not_implemented_response_new());
  }

  fl_method_call_respond(method_call, response, nullptr);
}

static void kode_view_plugin_dispose(GObject* object) {
  G_OBJECT_CLASS(kode_view_plugin_parent_class)->dispose(object);
}

static void kode_view_plugin_class_init(KodeViewPluginClass* klass) {
  G_OBJECT_CLASS(klass)->dispose = kode_view_plugin_dispose;
}

static void kode_view_plugin_init(KodeViewPlugin* self) {}

static void method_call_cb(FlMethodChannel* channel, FlMethodCall* method_call,
                           gpointer user_data) {
  KodeViewPlugin* plugin = KODE_VIEW_PLUGIN(user_data);
  kode_view_plugin_handle_method_call(plugin, method_call);
}

void kode_view_plugin_register_with_registrar(FlPluginRegistrar* registrar) {
  KodeViewPlugin* plugin = KODE_VIEW_PLUGIN(
      g_object_new(kode_view_plugin_get_type(), nullptr));

  g_autoptr(FlStandardMethodCodec) codec = fl_standard_method_codec_new();
  g_autoptr(FlMethodChannel) channel =
      fl_method_channel_new(fl_plugin_registrar_get_messenger(registrar),
                            "kode_view",
                            FL_METHOD_CODEC(codec));
  fl_method_channel_set_method_call_handler(channel, method_call_cb,
                                            g_object_ref(plugin),
                                            g_object_unref);

  g_object_unref(plugin);
}
