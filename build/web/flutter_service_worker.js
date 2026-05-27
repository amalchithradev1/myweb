'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "a523467d14a316211e0fd359dd48b282",
"version.json": "40e7b06505e2c3869ae177334fa1b1b4",
"index.html": "b931dbd5cc17e0849b9a977a166aeac8",
"/": "b931dbd5cc17e0849b9a977a166aeac8",
"main.dart.js": "f22834baa7301d49a40595fe4b1a8c49",
"flutter.js": "888483df48293866f9f41d3d9274a779",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "bebc59895b217a9c11a75c3ddf719789",
"assets/AmalResume_A4.pdf": "3a5376e5e773572fbd2e75ba54c09f80",
"assets/AssetManifest.json": "489b284d2714eabf4428648029fd67f9",
"assets/NOTICES": "70ad3ac32f549cf4388875d296dac59e",
"assets/FontManifest.json": "05983c8daacd1dd87fd6fad730af6495",
"assets/AssetManifest.bin.json": "5c94b879be66f374731986cbcf630113",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "6a548ff9e0b0139f736a00ffdba4bc10",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "b4f5c74cedccadebb5774c48b0714de8",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "bddd7677f1534903e422bf150cc2478b",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "2b0c8de81c080780d297f9667e62ae63",
"assets/fonts/MaterialIcons-Regular.otf": "9a2b1d12a938f2b36e7212c75c03d875",
"assets/assets/images/me.png": "d0b6d4c17e38f277a5eacad947313ce4",
"assets/assets/images/devasthanam_thump.png": "c144ba48e4e1c5dacda6ec7d0848d02a",
"assets/assets/images/alsanafer_thump.png": "680a45dd7d73460156c21a3d47eaf1e2",
"assets/assets/images/worryfree_thump.png": "e6c40c0b2ab294659ea499fa469a583b",
"assets/assets/images/olopo_thump.png": "a1abc17828b77c87ddc6212e30a44394",
"assets/assets/images/nailaura_thump.png": "9c4410f81b04b3fd4170214f5c806a82",
"assets/assets/images/ekasys_thump.png": "114e5159937623c677ef17e651797e16",
"assets/assets/images/waw_thump.png": "92804cf3286236e72881b40a83ca8e9b",
"assets/assets/images/spotfeed_thump.png": "0e4f3b08e586d77e5bed7423b2a65a21",
"assets/assets/images/me1.jpeg": "97eb8a455a46b07af40dc0e46404f372",
"assets/assets/images/project.png": "be845ec37244b937e1bcce80445a6582",
"assets/assets/images/iphone_frame.png": "1eb2dc3a2f31a7456962cfadc2c3bb07",
"assets/assets/images/alaysh_thump.png": "47962b85a2d1f200c382b5294b6d88db",
"assets/assets/images/jbs_thump.png": "019b2114db3bf6a8de3e15378726f5fd",
"assets/assets/images/rentiq_thump.png": "607ebccab19d037a2a301f3425bf6c6a",
"assets/assets/images/desktop_frame.png": "c1c3135991bfd6b65bc2fa1e6fb09c72",
"assets/assets/images/deepusec_thump.png": "85deb34b39591fc279b0e0afd53dd285",
"assets/assets/images/tna_thump.png": "a23c90f8fba903cc8957519f5a027bdd",
"assets/assets/images/fragranzia_thump.png": "7cbe456e629accb4450a7923251db793",
"assets/assets/images/me5.png": "80fd462630cde74e2007148926f37160",
"assets/assets/images/livzz_thump.png": "3820b62fc1399e655436cf8e3f2121e3",
"assets/assets/images/profile_new.jpg": "b2c1630e32004fb37c609f67705b64e5",
"assets/assets/images/olobilzz_thump.png": "191c2f9029a7a5447e31f5ef63f0ccbb",
"assets/assets/videos/waw_ad.mp4": "d4af215d67f752b9f5a553c8782ba939",
"assets/assets/videos/livzz.mp4": "40b3c2a80da017dc5a54895023e1e355",
"assets/assets/videos/jbs.mp4": "4b055a96d2254bdce8cb3bb831cff4ea",
"assets/assets/videos/olopo-mob.mp4": "3e79e0df237912b47c202cde45dc286e",
"assets/assets/videos/olobillz_ad.mp4": "8eb6204222567d886f91a4def157f4b8",
"assets/assets/videos/medoc.mp4": "d9fb10a2c92ca4fe34ad7c47ca1fbce2",
"assets/assets/videos/tna.mp4": "556ef6f880a180077d74d571673e5365",
"assets/assets/videos/deepus_ec_ad.mp4": "9882f32f6bad07d6043aa81b31e5ec97",
"assets/assets/videos/devasthanam-ad.mp4": "86727d721a76326b9efc210e7961778d",
"assets/assets/videos/rentiq.mp4": "28e23f146ba701d743dcdb89ab726b11",
"assets/assets/videos/alsanafer_ad.mp4": "f32ee2782cbb470c9c606e9ae9e2e684",
"assets/assets/videos/fragranzia.mp4": "c02ca152d0f03515525db4db2f3b90e6",
"assets/assets/videos/nailaura.mp4": "01e45060eaf56e5405eb2e286ab6a9d1",
"assets/assets/videos/worryfree.mp4": "ee7670c13f7191de47cdd24cbca6d23c",
"assets/assets/videos/alaysh.mp4": "f940cb5496f1fc0b8655b8c8ae609d80",
"assets/assets/videos/spotfeed.mp4": "232271e4f524eea59180f55cf8b77443",
"assets/assets/videos/ekasys.mp4": "bd372809a177c92d651805c1d9bc3dcf",
"assets/assets/lottie/applottie.json": "ada5cbbe628a7911c85048a2c162dd01",
"assets/assets/files/AmalResume_A4.pdf": "3a5376e5e773572fbd2e75ba54c09f80",
"assets/assets/files/Amal-CVA5.pdf": "755ba69c8a0726130d947e0946a8aa76",
"assets/assets/fonts/Poppins-Light.ttf": "fcc40ae9a542d001971e53eaed948410",
"assets/assets/fonts/Poppins-Medium.ttf": "bf59c687bc6d3a70204d3944082c5cc0",
"assets/assets/fonts/Poppins-ExtraBold.ttf": "d45bdbc2d4a98c1ecb17821a1dbbd3a4",
"assets/assets/fonts/Poppins-Regular.ttf": "093ee89be9ede30383f39a899c485a82",
"assets/assets/fonts/Poppins-Bold.ttf": "08c20a487911694291bd8c5de41315ad",
"assets/assets/fonts/Poppins-Black.ttf": "14d00dab1f6802e787183ecab5cce85e",
"canvaskit/skwasm.js": "1ef3ea3a0fec4569e5d531da25f34095",
"canvaskit/skwasm_heavy.js": "413f5b2b2d9345f37de148e2544f584f",
"canvaskit/skwasm.js.symbols": "0088242d10d7e7d6d2649d1fe1bda7c1",
"canvaskit/canvaskit.js.symbols": "58832fbed59e00d2190aa295c4d70360",
"canvaskit/skwasm_heavy.js.symbols": "3c01ec03b5de6d62c34e17014d1decd3",
"canvaskit/skwasm.wasm": "264db41426307cfc7fa44b95a7772109",
"canvaskit/chromium/canvaskit.js.symbols": "193deaca1a1424049326d4a91ad1d88d",
"canvaskit/chromium/canvaskit.js": "5e27aae346eee469027c80af0751d53d",
"canvaskit/chromium/canvaskit.wasm": "24c77e750a7fa6d474198905249ff506",
"canvaskit/canvaskit.js": "140ccb7d34d0a55065fbd422b843add6",
"canvaskit/canvaskit.wasm": "07b9f5853202304d3b0749d9306573cc",
"canvaskit/skwasm_heavy.wasm": "8034ad26ba2485dab2fd49bdd786837b"};
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
