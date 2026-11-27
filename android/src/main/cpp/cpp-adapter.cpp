#include <NitroImage/private/NitroImageOnLoad.hpp>
#include <fbjni/fbjni.h>
#include <jni.h>

JNIEXPORT jint JNICALL JNI_OnLoad(JavaVM* vm, void*) {
  return facebook::jni::initialize(vm, []() {
    margelo::nitro::image::registerAllNatives();
  });
}
