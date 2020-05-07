'use strict';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "index.html": "ead4818b92a21b59deb2929bb08ed087",
"/": "ead4818b92a21b59deb2929bb08ed087",
"main.dart.js.deps": "5b8b0e59bd0013d60f97349c99942a78",
"main.dart.js": "9d62ace90ac58ce1e00d8d59c4804b43",
"assets/LICENSE": "5adbfec201afe2b462928fa60f26db09",
"assets/AssetManifest.json": "7de30399d130d90f2c3489d8825f31f6",
"assets/FontManifest.json": "e72e5fb5b510c86125a24438cde276f7",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "115e937bb829a890521f72d2e664b632",
"assets/fonts/MaterialIcons-Regular.ttf": "56d3ffdef7a25659eab6a68a3fbfaf16",
"assets/assets/ani_ge_flog03.mp3": "304f394d690afc15290c2ef5551890b2",
"assets/assets/ani_ge_horse01.mp3": "cd727e28bdd9740e190392851d81b796",
"assets/assets/ani_ge_ushi02.mp3": "661696feb800d69220abb4b601c97930",
"assets/assets/ani_ge_chicken_koke03.mp3": "34fa5cecd871dcfa165912df46f7d6f3",
"assets/assets/LuckiestGuy-Regular.ttf": "08010c3c508ed427652ebcc7f1926f38",
"assets/assets/ani_ge_owl02.mp3": "210c9d3e64be1d4c83a61cc22c0f1d57",
"assets/assets/ani_ge_dog_wan01.mp3": "15202b1031e2df8af57e4cf82ebf5684"
};

self.addEventListener('activate', function (event) {
  event.waitUntil(
    caches.keys().then(function (cacheName) {
      return caches.delete(cacheName);
    }).then(function (_) {
      return caches.open(CACHE_NAME);
    }).then(function (cache) {
      return cache.addAll(Object.keys(RESOURCES));
    })
  );
});

self.addEventListener('fetch', function (event) {
  event.respondWith(
    caches.match(event.request)
      .then(function (response) {
        if (response) {
          return response;
        }
        return fetch(event.request);
      })
  );
});
