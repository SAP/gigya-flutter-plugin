# Add project specific ProGuard rules here.
# You can control the set of applied configuration files using the
# proguardFiles setting in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

# Uncomment this to preserve the line number information for
# debugging stack traces.
#-keepattributes SourceFile,LineNumberTable

# If you keep the line number information, uncomment this to
# hide the original source file name.
#-renamesourcefileattribute SourceFile

-keep class com.gigya.** { *; }
-keepdirectories */gigyaSdkConfiguration.json

# Keep classes for Volley
-keep class com.android.volley.** { *; }

# Keep classes for OkHttp
-keep class okhttp3.** { *; }

# Keep Firebase classes
-keep class com.google.firebase.** { *; }

# Keep Material classes
-keep class com.google.android.material.** { *; }

-dontwarn org.bouncycastle.**
-dontwarn org.chromium.net.**
-dontwarn org.conscrypt.**
-dontwarn org.openjsse.**
-dontwarn com.google.android.play.core.**

# Keep Flutter plugin classes
-keep class com.sap.gigya_flutter_plugin.** { *; }

# Keep Flutter method channel classes
-keep class io.flutter.plugin.common.MethodChannel$* { *; }
-keep class io.flutter.plugins.** { *; }

# Keep Gson TypeToken and related classes
-keep class com.google.gson.reflect.TypeToken { *; }

# Keep the CustomGSONDeserializer class
-keep class com.sap.gigya_android_sdk.utils.CustomGSONDeserializer { *; }

# Keep generic type information for Gson
-keepattributes Signature

## Keep SplitCompat classes
#-keep class com.google.android.play.core.splitcompat.** { *; }
#
## Keep SplitInstall classes
#-keep class com.google.android.play.core.splitinstall.** { *; }
#
## Keep Play Core tasks
#-keep class com.google.android.play.core.tasks.** { *; }

