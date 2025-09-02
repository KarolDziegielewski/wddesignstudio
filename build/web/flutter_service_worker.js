'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "5d8bdf5f690e4cf44dcf861cf163c4d3",
"flutter.js": "888483df48293866f9f41d3d9274a779",
"version.json": "83c0621ad240f6bc7938358201533f9a",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"canvaskit/skwasm_heavy.js": "413f5b2b2d9345f37de148e2544f584f",
"canvaskit/canvaskit.wasm": "07b9f5853202304d3b0749d9306573cc",
"canvaskit/skwasm.js": "1ef3ea3a0fec4569e5d531da25f34095",
"canvaskit/skwasm_heavy.wasm": "8034ad26ba2485dab2fd49bdd786837b",
"canvaskit/skwasm.js.symbols": "0088242d10d7e7d6d2649d1fe1bda7c1",
"canvaskit/skwasm_heavy.js.symbols": "3c01ec03b5de6d62c34e17014d1decd3",
"canvaskit/canvaskit.js.symbols": "58832fbed59e00d2190aa295c4d70360",
"canvaskit/canvaskit.js": "140ccb7d34d0a55065fbd422b843add6",
"canvaskit/chromium/canvaskit.wasm": "24c77e750a7fa6d474198905249ff506",
"canvaskit/chromium/canvaskit.js.symbols": "193deaca1a1424049326d4a91ad1d88d",
"canvaskit/chromium/canvaskit.js": "5e27aae346eee469027c80af0751d53d",
"canvaskit/skwasm.wasm": "264db41426307cfc7fa44b95a7772109",
"main.dart.js": "51f69e4679c46c54e6247d3487ffc3dc",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"index.html": "16f883253b7f71b90fd3fe1b2f3b2255",
"/": "16f883253b7f71b90fd3fe1b2f3b2255",
"assets/AssetManifest.json": "019e687b5036877a88ebd3aad8b84762",
"assets/AssetManifest.bin.json": "5a2d7540e4b47b96debfa62de62fa530",
"assets/packages/font_awesome_flutter/lib/fonts/Font%2520Awesome%25207%2520Free-Regular-400.otf": "df86a1976d76bd04cf3fcaf5add2dd0f",
"assets/packages/font_awesome_flutter/lib/fonts/Font%2520Awesome%25207%2520Free-Solid-900.otf": "e151d7a6f42f17e9ea335c91d07b3739",
"assets/packages/font_awesome_flutter/lib/fonts/Font%2520Awesome%25207%2520Brands-Regular-400.otf": "00f63634abc6bb4e0a8ad6fc1fccf332",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/fonts/MaterialIcons-Regular.otf": "5763083ab2264dc206e4f121d40ff9eb",
"assets/AssetManifest.bin": "8cf4b23102772eccf794f503125595b2",
"assets/NOTICES": "446a68f8467ad452452de6d7bf48fb8f",
"assets/FontManifest.json": "1a5cd219969f67a595124c1bbb0bd5f6",
"assets/assets/images/proj3_1.jpg": "62b9d9b72e70e5ebb9b127cea163f640",
"assets/assets/images/proj1_2.jpg": "61a94f3d587cfd8fb422ae6519805c31",
"assets/assets/images/proj3_2.jpg": "50f88c030ab007375c56040e030d27c7",
"assets/assets/images/proj4_5.jpg": "8a1112ac6f81c99d64f64b1ade4ad173",
"assets/assets/images/proj4_6.jpg": "0d02e6d64a4ee8ebbc7872dd6f0d0660",
"assets/assets/images/proj2_1.jpg": "a2d9978d65bbe00f988334e0b8b84f7d",
"assets/assets/images/weronika.jpg": "270f167d96a1fb12a14b247d6b3a5b94",
"assets/assets/images/proj2_3.jpg": "72dc32a080285a9167fd08c152f4d65c",
"assets/assets/images/proj4_4.jpg": "8a1112ac6f81c99d64f64b1ade4ad173",
"assets/assets/images/mini_proj3.jpg": "4d71c8ba7cf5c4bcfb685fc08005994e",
"assets/assets/images/proj4_7.jpg": "b03ef3925d6cc38ee49f127fe175bd51",
"assets/assets/images/proj4_3.jpg": "644f670185be51069cc867aeea779418",
"assets/assets/images/proj4_2.jpg": "c1b462f97c2dcc471467476c4e977ea9",
"assets/assets/images/hero.jpg": "873537b308907397f52afa93abf9c7df",
"assets/assets/images/proj1_1.jpg": "0bfbcf60160549f86c8afa28919943ca",
"assets/assets/images/mini_proj4.jpg": "c1b462f97c2dcc471467476c4e977ea9",
"assets/assets/images/mini_proj2.jpg": "79af2671d26ba9c1653b358cced569ea",
"assets/assets/images/proj3_3.jpg": "8ab7d897fbeaf580b4f09268c8680d4e",
"assets/assets/images/mini_proj1.jpg": "bcd8aebf6ca99517af35968858e8a417",
"assets/assets/images/proj2_2.jpg": "4bc81d6620f55a12485fbd6ea0f9361f",
"assets/assets/images/proj4_1.jpg": "b03ef3925d6cc38ee49f127fe175bd51",
"manifest.json": "a910a2594b0c04cfc000c7598ff6d4c9"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
