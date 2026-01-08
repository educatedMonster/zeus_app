plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "ph.servoitsolutions.zeus_app"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "ph.servoitsolutions.zeus_app"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        multiDexEnabled = true
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }

    // Include Epson SDK libraries (.jar + .so)
    sourceSets {
        getByName("main") {
            jniLibs.srcDirs("libs")
        }
    }
}

dependencies {
    // Include all .jar files inside libs/
//    implementation(fileTree(mapOf("dir" to "libs", "include" to listOf("*.jar"))))
    implementation(files("libs/Epos2.jar"))

    // Kotlin stdlib
    implementation("org.jetbrains.kotlin:kotlin-stdlib")

    // Optional but recommended for Epson SDK
    implementation("androidx.multidex:multidex:2.0.1")

    // AndroidX core and AppCompat
    implementation("androidx.core:core-ktx:1.17.0")
    implementation("androidx.appcompat:appcompat:1.7.1")

    // Flutter Gradle Plugin dependency (required)
    // implementation("dev.flutter:flutter_embedding_debug:1.0.0") // usually managed by Flutter

    // OkHttp for WebSocket
    implementation("com.squareup.okhttp3:okhttp:5.3.0")

    // Kotlin coroutines for async/reconnection logic
    implementation("org.jetbrains.kotlinx:kotlinx-coroutines-core:1.10.2")

    // Optional: Logging
    implementation("androidx.constraintlayout:constraintlayout:2.2.1")

    // Test dependencies (optional)
    testImplementation("junit:junit:4.13.2")
    androidTestImplementation("androidx.test.ext:junit:1.3.0")
    androidTestImplementation("androidx.test.espresso:espresso-core:3.7.0")
}

flutter {
    source = "../.."
}
