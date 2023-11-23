import 'dart:async';
import 'dart:developer';

import 'search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:choice/choice.dart';

void main() async {
  await _initialize();
  runApp(MaterialApp(title: 'Map', home: NaverMapApp()));
}

// 지도 초기화하기
Future<void> _initialize() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NaverMapSdk.instance.initialize(
      clientId: 'bhfr4cuhpe', // 클라이언트 ID 설정
      onAuthFailed: (e) => log("네이버맵 인증오류 : $e", name: "onAuthFailed"));
}

class NaverMapApp extends StatefulWidget {
  const NaverMapApp({Key? key});

  @override
  State<NaverMapApp> createState() => _NaverMapAppState();
}

class _NaverMapAppState extends State<NaverMapApp> {
  List<String> selectedList = [];
  @override
  Widget build(BuildContext context) {
    // NaverMapController 객체의 비동기 작업 완료를 나타내는 Completer 생성
    final Completer<NaverMapController> mapControllerCompleter = Completer();

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
                Text('$selectedList'),
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
                      });
                    },
                    icon: Icon(Icons.search))
              ],
            ),
            SizedBox(
              height: 600,
              child: NaverMap(
                options: const NaverMapViewOptions(
                  indoorEnable: true, // 실내 맵 사용 가능 여부 설정
                  locationButtonEnable: false, // 위치 버튼 표시 여부 설정
                  consumeSymbolTapEvents: false, // 심볼 탭 이벤트 소비 여부 설정
                ),
                onMapReady: (controller) async {
                  // 지도 준비 완료 시 호출되는 콜백 함수
                  mapControllerCompleter
                      .complete(controller); // Completer에 지도 컨트롤러 완료 신호 전송
                  log("onMapReady", name: "onMapReady");
                  final marker = NMarker(
                      id: 'test',
                      position: const NLatLng(
                          37.506932467450326, 127.05578661133796));
                  final marker1 = NMarker(
                      id: 'test1',
                      position: const NLatLng(
                          37.606932467450326, 127.05578661133796));
                  controller.addOverlayAll({marker, marker1});

                  final onMarkerInfoWindow =
                      NInfoWindow.onMarker(id: marker.info.id, text: "test");
                  marker.openInfoWindow(onMarkerInfoWindow);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MySearchScreen extends StatelessWidget {
  const MySearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Screen'),
      ),
      body: SearchSelect(),
    );
  }
}
