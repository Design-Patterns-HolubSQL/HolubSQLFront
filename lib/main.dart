import 'dart:async';
import 'dart:developer';
import 'dart:convert';
import 'package:provider/provider.dart';

import 'search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:http/http.dart' as http;

late Future<Map<String, dynamic>> _restaurantData;

void main() async {
  await _initialize();

  runApp(
    ChangeNotifierProvider(
      create: (context) => MapControllerProvider(),
      child: MaterialApp(
        title: 'Map',
        home: NaverMapApp(),
      ),
    ),
  );
}

// 지도 초기화하기
Future<void> _initialize() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NaverMapSdk.instance.initialize(
      clientId: 'bhfr4cuhpe', // 클라이언트 ID 설정
      onAuthFailed: (e) => log("네이버맵 인증오류 : $e", name: "onAuthFailed"));
}

class MapControllerProvider extends ChangeNotifier {
  NaverMapController? _mapController;

  NaverMapController? get mapController => _mapController;

  void setMapController(NaverMapController controller) {
    _mapController = controller;
    notifyListeners();
  }
}

class NaverMapApp extends StatefulWidget {
  const NaverMapApp({Key? key});

  @override
  State<NaverMapApp> createState() => _NaverMapAppState();
}

class _NaverMapAppState extends State<NaverMapApp> {
  List<String> selectedList = [];
  List<Map<String, String>> restaurantList = [];
  List<Map<String, String>> findList = [];
  late NaverMapController _mapController;

  @override
  void initState() {
    super.initState();
    initializeRestaurantList();
  }

  Future<void> initializeRestaurantList() async {
    // API에서 데이터 가져오기
    const apiUrl = 'http://192.168.0.7:8080/api/restaurants';
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonMap = json.decode(response.body);

      List<dynamic> restaurants = jsonMap['restaurant'];

      for (var restaurant in restaurants) {
        String restaurantId = restaurant['restaurant_id'];
        String restaurantName = restaurant['restaurant_name'];
        String longitude = restaurant['longitude'];
        String latitude = restaurant['latitude'];

        restaurantList.add({
          'restaurant_id': restaurantId,
          'restaurant_name': restaurantName,
          'longitude': longitude,
          'latitude': latitude,
        });
      }
    } else {
      // API 호출 실패 시 에러 처리
      throw Exception('Failed to load restaurant data');
    }
  }

  Future<void> findRestaurants(List<String> inputList) async {
    findList = [];
    print(inputList.length);

    var apiUrl =
        'http://192.168.0.7:8080/api/restaurants?name=${inputList[0]}&tag1=${inputList[1]}&tag2=${inputList[2]},${inputList[3]},${inputList[4]}&tag3=${inputList[5]}';

    final response = await http.get(Uri.parse(apiUrl));

    log(apiUrl);

    if (response.statusCode == 200) {
      var jsonMap = json.decode(response.body);
      List<dynamic> finds = jsonMap['restaurant'];

      for (var restaurant in finds) {
        String restaurantId = restaurant['restaurant_id'];
        String restaurantName = restaurant['restaurant_name'];
        String longitude = restaurant['longitude'];
        String latitude = restaurant['latitude'];

        findList.add({
          'restaurant_id': restaurantId,
          'restaurant_name': restaurantName,
          'longitude': longitude,
          'latitude': latitude,
        });
      }
    } else {
      // 응답이 실패인 경우 예외 처리
      throw Exception('Failed to load restaurant data');
    }
  }

  @override
  Widget build(BuildContext context) {
    // NaverMapController 객체의 비동기 작업 완료를 나타내는 Completer 생성
    final Completer<NaverMapController> mapControllerCompleter = Completer();
    final mapControllerProvider = context.watch<MapControllerProvider>();
    final mapController = mapControllerProvider.mapController;

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('Category Map'),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //Text('$selectedList'),
                IconButton(
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MySearchScreen(),
                        ),
                      );

                      setState(() {
                        selectedList = result ?? [];
                        print('$selectedList');
                        addMarker(mapController!, selectedList);
                      });
                    },
                    icon: Icon(Icons.search))
              ],
            ),
            SizedBox(
              height: 500,
              child: NaverMap(
                options: const NaverMapViewOptions(
                  indoorEnable: true, // 실내 맵 사용 가능 여부 설정
                  locationButtonEnable: false, // 위치 버튼 표시 여부 설정
                  consumeSymbolTapEvents: false, // 심볼 탭 이벤트 소비 여부 설정
                ),
                onMapReady: (controller) async {
                  _mapController = controller;
                  mapControllerProvider.setMapController(controller);
                  log("onMapReady", name: "onMapReady");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> addMarker(
      NaverMapController mapController, List<String> select) async {
    if (select.length > 4) {
      await findRestaurants(select);
      log(findList.toString());
      mapController.clearOverlays();
      for (var restaurant in findList) {
        double latitude = double.parse(restaurant['latitude']!);
        double longitude = double.parse(restaurant['longitude']!);

        final marker = NMarker(
          id: restaurant['restaurant_id']!,
          position: NLatLng(latitude, longitude),
        );

        mapController.addOverlayAll({marker});
      }
    } else {
      for (var restaurant in restaurantList) {
        double latitude = double.parse(restaurant['latitude']!);
        double longitude = double.parse(restaurant['longitude']!);

        final marker = NMarker(
          id: restaurant['restaurant_id']!,
          position: NLatLng(latitude, longitude),
        );

        mapController.addOverlayAll({marker});
      }
    }
  }
}

class MySearchScreen extends StatelessWidget {
  const MySearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mapControllerProvider = context.watch<MapControllerProvider>();
    final mapController = mapControllerProvider.mapController;
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Screen'),
      ),
      body: SearchSelect(),
    );
  }
}
