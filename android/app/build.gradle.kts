plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")
}

android {
    namespace = "com.example.tcc_ceclimar"
    compileSdk = 35
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    signingConfigs {
        create("release") {
            storeFile = file(project.property("MY_KEYSTORE_FILE") as String)
            storePassword = project.property("MY_KEYSTORE_PASSWORD") as String
            keyAlias = project.property("MY_KEY_ALIAS") as String
            keyPassword = project.property("MY_KEY_PASSWORD") as String
        }
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
        freeCompilerArgs += "-Xlint:deprecation"
    }

    defaultConfig {
        applicationId = "com.example.tcc_ceclimar"
        minSdk = 23
        targetSdk = 35
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        getByName("release") {
            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
            signingConfig = signingConfigs.getByName("release")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    implementation(platform("com.google.firebase:firebase-bom:33.11.0"))
    implementation("com.google.firebase:firebase-analytics")
    implementation("com.google.firebase:firebase-appcheck-playintegrity")
}
