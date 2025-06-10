plugins {
    id("com.android.application")
    id("kotlin-android")
    id("com.google.gms.google-services")
    id("dev.flutter.flutter-gradle-plugin")
}

dependencies {
    implementation(platform("com.google.firebase:firebase-bom:33.15.0"))
    implementation("com.google.firebase:firebase-analytics")
}

android {
    namespace = "com.gabriellybassetto.leitor_acessivel"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Especifique sua própria ID de aplicativo (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.gabriellybassetto.leitor_acessivel"
        // Você pode atualizar os valores a seguir para atender às necessidades do seu aplicativo.
        // Para obter mais informações, consulte: https://flutter.dev/to/review-gradle-config.
        minSdk = 23
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = "1.0.0"  // You can set this to your desired version name // LINHA ALTERADA: Adicionado .toString()
    }

    buildTypes {
        release {
            // TODO: adicione sua própria configuração de assinatura para o build de versão.
            // Assinando com as chaves de depuração por enquanto, então 'flutter run --release' funciona.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../../"
}