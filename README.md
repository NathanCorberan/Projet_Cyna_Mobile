# nathancorberan-projet_cyna_mobile

## Description
**nathancorberan-projet_cyna_mobile** est une application mobile développée avec **Flutter**. Elle est compatible avec **Android** et **iOS**, offrant une interface utilisateur fluide et une intégration avec l'API backend pour la gestion des utilisateurs, des produits et des commandes.

## Prérequis
Avant d'installer et d'exécuter ce projet, assurez-vous d'avoir les outils suivants installés :

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Dart](https://dart.dev/get-dart)
- [Android Studio](https://developer.android.com/studio) (avec le SDK Android et l'émulateur configuré)
- [Xcode](https://developer.apple.com/xcode/) (pour exécuter sur iOS)

## Installation

### 1. Cloner le dépôt
```sh
git clone https://github.com/votre-repo/nathancorberan-projet_cyna_mobile.git
cd nathancorberan-projet_cyna_mobile
```

### 2. Installer les dépendances
```sh
flutter pub get
```

### 3. Configuration de l'environnement
Créez un fichier `.env` pour stocker vos variables d'environnement si nécessaire.

### 4. Lancer l'application
#### Sur un émulateur ou un appareil physique Android
```sh
flutter run
```
#### Sur iOS (Mac uniquement)
```sh
flutter run --release --no-sound-null-safety
```

## Structure du projet
Le projet suit une structure modulaire pour une meilleure organisation :

- **`lib/`** : Contient le code source principal de l'application
  - **`main.dart`** : Point d'entrée de l'application
  - **`pages/`** : Contient les différentes pages de l'application (connexion, accueil, création de compte...)
  - **`providers/`** : Gestion de l'état global de l'application
  - **`widgets/`** : Composants réutilisables
  - **`generated/`** : Fichiers générés automatiquement pour les assets
- **`assets/`** : Contient les images et autres fichiers statiques
- **`android/`** et **`ios/`** : Configuration spécifique aux plateformes respectives

## Fonctionnalités principales
- **Authentification** (Connexion / Création de compte)
- **Navigation entre les pages** (Accueil, Paramètres, Produits...)
- **Intégration API** pour récupérer les données en temps réel
- **Gestion de l'état avec Provider**

## Tests
Pour exécuter les tests unitaires :
```sh
flutter test
```

## Déploiement
### 1. Générer l'APK pour Android
```sh
flutter build apk --release
```
### 2. Générer l'IPA pour iOS (Mac uniquement)
```sh
flutter build ios --release
``` 

## Auteur
Nathan Corberan - [GitHub](https://github.com/nathancorberan)

