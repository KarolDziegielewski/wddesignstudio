'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter.js": "83d881c1dbb6d6bcd6b42e274605b69c",
"version.json": "83c0621ad240f6bc7938358201533f9a",
"index.html": "61731abcfe71080b2c2698c1385ac197",
"/": "61731abcfe71080b2c2698c1385ac197",
"main.dart.js": "4c77523b466641438ba1b9d55caec4da",
"flutter_bootstrap.js": "86bdd92fe166be674cd63987bf300314",
"assets/AssetManifest.bin": "4bb2d72aff6c08d18293a61a80f6821c",
"assets/NOTICES": "6d3376222c7de28b648a68e7d4a3f2ec",
"assets/AssetManifest.bin.json": "856c09d28c14a2dbe28c9d6c6be3af5d",
"assets/assets/logo.png": "ea3b34d876182f438bc8d862cb9d72e5",
"assets/AssetManifest.json": "052da70fd40d9ece64632d0aeba49f8f",
"assets/FontManifest.json": "7b2a36307916a9721811788013e65289",
"assets/fonts/MaterialIcons-Regular.otf": "730f0cef2c08e0d566107ceda45b5ad2",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"manifest.json": "27e6ad0899fe3edd5491fcb5ea20e6ef",
"canvaskit/skwasm.js": "ea559890a088fe28b4ddf70e17e60052",
"canvaskit/canvaskit.js": "728b2d477d9b8c14593d4f9b82b484f3",
"canvaskit/canvaskit.wasm": "7a3f4ae7d65fc1de6a6e7ddd3224bc93",
"canvaskit/canvaskit.js.symbols": "bdcd3835edf8586b6d6edfce8749fb77",
"canvaskit/skwasm.js.symbols": "e72c79950c8a8483d826a7f0560573a1",
"canvaskit/skwasm.wasm": "39dd80367a4e71582d234948adc521c0",
"canvaskit/chromium/canvaskit.js": "8191e843020c832c9cf8852a4b909d4c",
"canvaskit/chromium/canvaskit.wasm": "f504de372e31c8031018a9ec0a9ef5f0",
"canvaskit/chromium/canvaskit.js.symbols": "b61b5f4673c9698029fa0a746a9ad581",
".git/index": "4ff9cc81ddd49ac78480c4312c4fd19c",
".git/config": "5c45ecb5c0fbc00a5c51fd8e825bd84c",
".git/COMMIT_EDITMSG": "c3be117041a113540deb0ff532b19543",
".git/refs/remotes/origin/main": "6beed54329294560770e7668d8e597aa",
".git/refs/heads/main": "6beed54329294560770e7668d8e597aa",
".git/description": "a0a7c3fff21f2aea3cfa1d0316dd816c",
".git/objects/eb/9b4d76e525556d5d89141648c724331630325d": "37c0954235cbe27c4d93e74fe9a578ef",
".git/objects/3c/e5449c5a07c0579eafe18ad29756b301b1c2d6": "9f108e1124d0e5edeb2d4f22818f267d",
".git/objects/3c/86dd180372ab5b29faab8bbd1cde8e1a97563c": "398774aefd1ed8405f2f41ae22c3d65a",
".git/objects/1b/65e550119154f72f201699953087461b8abd88": "d8f2406ed16c659d43c45038fc4c2fbf",
".git/objects/ff/13edc473c75c15d3653a04e62ade3cab970688": "07e9b11c9ba9a23b58c4fc479a274dc3",
".git/objects/87/dd4164436ac0c784f400ebfda0dd0be474b784": "b007ba6335bfc7a1434c58029dfd9169",
".git/objects/e0/7ac7b837115a3d31ed52874a73bd277791e6bf": "74ebcb23eb10724ed101c9ff99cfa39f",
".git/objects/b9/6a5236065a6c0fb7193cb2bb2f538b2d7b4788": "4227e5e94459652d40710ef438055fe5",
".git/objects/b9/2a0d854da9a8f73216c4a0ef07a0f0a44e4373": "f62d1eb7f51165e2a6d2ef1921f976f3",
".git/objects/01/cbf91742977e9d881883d02c20093b79ebaa7d": "ae553bd4a7ef3dd53041574cccd5280f",
".git/objects/53/3d2508cc1abb665366c7c8368963561d8c24e0": "4592c949830452e9c2bb87f305940304",
".git/objects/53/18a6956a86af56edbf5d2c8fdd654bcc943e88": "a686c83ba0910f09872b90fd86a98a8f",
".git/objects/3a/bf18c41c58c933308c244a875bf383856e103e": "30790d31a35e3622fd7b3849c9bf1894",
".git/objects/c5/6847026b3a981ee5d5ddb87742111c914a872f": "b355b2a77e904f8bfd8b8f3448d11743",
".git/objects/c5/232232b71986ec109a2996748dcca0a00612ce": "3597bf9b7cdb100d6d2d6bdcf3908a62",
".git/objects/7d/acd5d007a1a15affd077413085b7818f34a588": "5c9116ad547d98ee92f34c97c8510624",
".git/objects/6f/43ebc1cf7792fcc657457252cef20e6172d316": "36c1926e63920b8ef41ce8011ac09d9b",
".git/objects/b3/7eebad7537c6fe86ced6c151322f8bcff5aed0": "3401e3e0bd534c1f7d192ed28b237183",
".git/objects/71/44772862e33095fb9ad6b44b28402350a31eb8": "ea466ad372e5e8c3e307e8271ba821da",
".git/objects/54/6715188153665cc5fd5b99a74cbf7f20648aa9": "cb5c480b20c6ad7b22589b29d34f4a6b",
".git/objects/05/79c6a1203afb22570eb5832a0eb01021368091": "94e6dba05d39acd7594cbcea03f3e3df",
".git/objects/d4/3532a2348cc9c26053ddb5802f0e5d4b8abc05": "3dad9b209346b1723bb2cc68e7e42a44",
".git/objects/fe/8c820df05f39183abafb59144d230edb540552": "ed1fd121c607d59b641967097bf18704",
".git/objects/d6/9c56691fbdb0b7efa65097c7cc1edac12a6d3e": "868ce37a3a78b0606713733248a2f579",
".git/objects/88/cfd48dff1169879ba46840804b412fe02fefd6": "e42aaae6a4cbfbc9f6326f1fa9e3380c",
".git/objects/4e/87d371d974f74dddd0f4093261c44cbecab754": "e9c6a0043f6be7492679ec58ecc57d59",
".git/objects/c8/5d260f5bd5513d28d9c8c2626280aa2a7e2a6d": "dfa6371dd43f7879795c6663db53b17c",
".git/objects/c8/08fb85f7e1f0bf2055866aed144791a1409207": "92cdd8b3553e66b1f3185e40eb77684e",
".git/objects/6c/576537d96a245698ab1fd9ac369fcebc852ca0": "53cc353eaf27bdfc95d1a29713ac3008",
".git/objects/4c/51fb2d35630595c50f37c2bf5e1ceaf14c1a1e": "a20985c22880b353a0e347c2c6382997",
".git/objects/b6/1556fb0c8033b7b3802818b457d20a9f8e5fc8": "92e44e9775ba98bcda54423d62226c1d",
".git/objects/9b/d3accc7e6a1485f4b1ddfbeeaae04e67e121d8": "784f8e1966649133f308f05f2d98214f",
".git/objects/f5/533b912524b1705a5112093723efd3ba0573c6": "a734c8887a331294ed7fc69cf593944c",
".git/objects/8a/aa46ac1ae21512746f852a42ba87e4165dfdd1": "1d8820d345e38b30de033aa4b5a23e7b",
".git/objects/1a/d7683b343914430a62157ebf451b9b2aa95cac": "94fdc36a022769ae6a8c6c98e87b3452",
".git/objects/be/ccabbcb0a65c6ac3b3ae551d2349b557c58e41": "3997b434d399a1e29b815e2d756a0037",
".git/objects/b7/49bfef07473333cf1dd31e9eed89862a5d52aa": "36b4020dca303986cad10924774fb5dc",
".git/objects/83/6106ba07ac25c1bf531d5f51f8dd8ac44f0de9": "1df9c96545e45f5ec1ea11bcf6abc849",
".git/objects/a2/eab4590ad126113cf59114ac1e53d808d0eb4c": "d900778d9f5da43b03f543d8ea47f715",
".git/objects/70/a234a3df0f8c93b4c4742536b997bf04980585": "d95736cd43d2676a49e58b0ee61c1fb9",
".git/objects/dc/11fdb45a686de35a7f8c24f3ac5f134761b8a9": "761c08dfe3c67fe7f31a98f6e2be3c9c",
".git/objects/e6/0ea1fdebe5fa8430497474d38200cdb2fa61a6": "9f37e45afbd9670201eef397142dcd48",
".git/objects/9f/c9e419db4eac147aa3da9ed1aa0cd3e7c8bcf1": "c2d171dd9b34d8f1f19068f74c393081",
".git/objects/df/501174f6c62ac97286bfc2c3c0a2c179718a31": "9f4c96a95fd4440d3e450c0e7f45eb1e",
".git/objects/12/520811584b0b6374b0d96def1d2c9405a17203": "f4037349603c541b4877f44aff1cb2f1",
".git/objects/8e/3c7d6bbbef6e7cefcdd4df877e7ed0ee4af46e": "025a3d8b84f839de674cd3567fdb7b1b",
".git/objects/47/6e90be826914b081f7051d45d7b66155722bcf": "570862ebfbe02c4c74db5b40e6e08c67",
".git/objects/73/c63bcf89a317ff882ba74ecb132b01c374a66f": "6ae390f0843274091d1e2838d9399c51",
".git/objects/f2/04823a42f2d890f945f70d88b8e2d921c6ae26": "6b47f314ffc35cf6a1ced3208ecc857d",
".git/objects/21/ad60c0c4c118cd949b89216451a230214b4bd6": "b842fe348ea0f599c0d2ba7f59d966c5",
".git/HEAD": "cf7dd3ce51958c5f13fece957cc417fb",
".git/info/exclude": "036208b4a1ab4a235d75c181e685e5a3",
".git/FETCH_HEAD": "f70ef833a601f7d874a859f21b365e99",
".git/hooks/commit-msg.sample": "579a3c1e12a1e74a98169175fb913012",
".git/hooks/push-to-checkout.sample": "c7ab00c7784efeadad3ae9b228d4b4db",
".git/hooks/pre-rebase.sample": "56e45f2bcbc8226d2b4200f7c46371bf",
".git/hooks/pre-applypatch.sample": "054f9ffb8bfe04a599751cc757226dda",
".git/hooks/update.sample": "647ae13c682f7827c22f5fc08a03674e",
".git/hooks/pre-receive.sample": "2ad18ec82c20af7b5926ed9cea6aeedd",
".git/hooks/pre-commit.sample": "305eadbbcd6f6d2567e033ad12aabbc4",
".git/hooks/applypatch-msg.sample": "ce562e08d8098926a3862fc6e7905199",
".git/hooks/sendemail-validate.sample": "4d67df3a8d5c98cb8565c07e42be0b04",
".git/hooks/post-update.sample": "2b7ea5cee3c49ff53d41e00785eb974c",
".git/hooks/fsmonitor-watchman.sample": "a0b2633a2c8e97501610bd3f73da66fc",
".git/hooks/pre-push.sample": "2c642152299a94e05ea26eae11993b13",
".git/hooks/prepare-commit-msg.sample": "2b5c047bdb474555e1787db32b2d2fc5",
".git/hooks/pre-merge-commit.sample": "39cb268e2a85d436b9eb6f47614c3cbc",
".git/logs/refs/remotes/origin/main": "d86ffd2df499a4b5f7e2b053a209713a",
".git/logs/refs/heads/main": "71ba3260f985681ad2b3e1108137a8ec",
".git/logs/HEAD": "a717948308f96fce636fa62b467d876b",
".git/ORIG_HEAD": "6beed54329294560770e7668d8e597aa",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea"};
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
