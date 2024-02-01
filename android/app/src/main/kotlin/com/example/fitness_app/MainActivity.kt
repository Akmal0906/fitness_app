package com.example.fitness_app

import androidx.annotation.NonNull // Make sure this import is present
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import com.yandex.mapkit.MapKitFactory

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        MapKitFactory.setApiKey("f5ef39f2-e42c-483c-ae64-5e77e79dd2d5") // Your generated API key
        super.configureFlutterEngine(flutterEngine)
    }
}
