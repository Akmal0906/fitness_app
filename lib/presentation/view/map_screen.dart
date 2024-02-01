import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/domain/locals/local_model.dart';
import 'package:fitness_app/domain/textfield_model.dart';
import 'package:fitness_app/presentation/blocs/register_bloc.dart';
import 'package:fitness_app/presentation/view/my_textfield.dart';
import 'package:fitness_app/presentation/widgets/show_modal_bottom.dart';
import 'package:fitness_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> with WidgetsBindingObserver{
  List<MapObject> list = [];
  YandexMapController? yandexMapController;
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  double zoomLevel = 15;

  @override
  void initState() {
    super.initState();
    list.addAll([
      PlacemarkMapObject(
        mapId: const MapObjectId('SALOMLAR'),
        point: const Point(longitude: 69.240562, latitude: 41.311081),
        isVisible: true,
        isDraggable: true,
        icon: PlacemarkIcon.single(
          PlacemarkIconStyle(
            scale: 0.15,
            image: BitmapDescriptor.fromAssetImage(
              'assets/images/location.png',
            ),
          ),
        ),
      ),
      PlacemarkMapObject(
        mapId: const MapObjectId('SALOM Jizzakh'),
        point: const Point(longitude: 67.8808, latitude: 40.1250),
        isVisible: true,
        isDraggable: true,
        icon: PlacemarkIcon.single(
          PlacemarkIconStyle(
            scale: 0.15,
            image: BitmapDescriptor.fromAssetImage(
              'assets/images/location.png',
            ),
          ),
        ),
      ),
    ]);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
    }
  }
  List<LocalModel> listAddress = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var _pageSize = MediaQuery.of(context).size.height;
    var _notifySize = MediaQuery.of(context).padding.top;
    return SafeArea(
      child: BlocConsumer<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state is LoadingState) {
          } else if (state is SuccessSavedAddressState) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Successfully upload!',
                    style: customStyle,
                  ),
                  duration: const Duration(seconds: 3),
                ),
              );
            });
          }

          print('SUCCESSSAVEDADRESSSTATE');

          titleController.clear();
          descController.clear();
          addressController.clear();
        },
        builder: (context, state) {
          if (state is LoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SuccessSavedAddressState) {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  'Save address',
                  style: customStyle,
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        if (listAddress.isNotEmpty) {
                          context.read<RegisterBloc>().add(SaveAdressEvent(
                              localModel: LocalModel(
                                  title: titleController.text.trim(),
                                  description: descController.text.trim(),
                                  lat: listAddress.first.lat,
                                  lot: listAddress.first.lot)));
                        }
                      },
                      child: Text(
                        'save',
                        style: customStyle,
                      ))
                ],
              ),
              body: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: SizedBox(
                  height: _pageSize - (_notifySize),
                  child: Column(
                    children: [
                      SizedBox(
                        width: size.width,
                        child: Column(
                          children: [
                            MyTextFieldWidget(
                              model: TextFieldModel(
                                  controller: titleController,
                                  hintText: 'Enter product title',
                                  obscureText: false,
                                  isNeed: false),
                              text: 'Title',
                              maxLine: 1,
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            MyTextFieldWidget(
                              model: TextFieldModel(
                                  controller: descController,
                                  hintText: 'Enter the description',
                                  obscureText: false,
                                  isNeed: false),
                              text: 'Description',
                              maxLine: 8,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 12),
                              child: Row(
                                children: [
                                  const Expanded(
                                      child: Divider(
                                    thickness: 1,
                                  )),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12),
                                    child: Text(
                                      'Change Location'.tr(),
                                      style: customStyle,
                                    ),
                                  ),
                                  const Expanded(
                                      child: Divider(
                                    thickness: 1,
                                  ))
                                ],
                              ),
                            ),
                            MyTextFieldWidget(
                              model: TextFieldModel(
                                  controller: addressController,
                                  hintText: 'Enter address',
                                  obscureText: false,
                                  isNeed: false),
                              text: 'Address by location',
                              maxLine: 1,
                            ),
                            const SizedBox(
                              height: 28,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Stack(
                          children: [
                            YandexMap(
                              mode2DEnabled: true,
                              mapType: MapType.map,
                              fastTapEnabled: true,
                              mapObjects: list,
                              onMapCreated: (YandexMapController controller) {
                                yandexMapController = controller;
                              },
                              onMapTap: (Point point) async {
                                try {
                                  final placemarks =
                                  await placemarkFromCoordinates(
                                      point.latitude, point.longitude,
                                      localeIdentifier: "en");
                                  setState(() {
                                    listAddress.clear();
                                    listAddress.add(LocalModel(
                                        title: placemarks.first.name!,
                                        description: placemarks.first.street!,
                                        lat: point.latitude,
                                        lot: point.longitude));
                                    descController.text =
                                    placemarks.first.street!;
                                    titleController.text = placemarks.first.name!;
                                    addressController.text =
                                    placemarks.first.administrativeArea!;
                                    showBottomFunc(context,
                                        '${placemarks.first.name},${placemarks.first.administrativeArea},${point.latitude},${point.longitude}',point.latitude,point.longitude);
                                    print(
                                        'Titlecontroller=${titleController.text.trim()}');
                                    print(
                                        'DESCRIPTIONCONTROLLER=${descController.text.trim()}');
                                    print(
                                        'ADDRESSCONTROLLER=${addressController.text.trim()}');
                                  });
                                } catch (e) {
                                  print(e);
                                }
                              },
                              onObjectTap: (GeoObject object) {
                                print('Ishlavotti');
                                print('OBJECT NAME=${object.name}');
                              },
                            ),
                            Positioned(
                              bottom: 80,
                              right: 20,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.my_location,
                                  color: Colors.black54,
                                  size: 32,
                                ),
                                onPressed: () async {
                                  await _getCurrentLocation();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else if (state is ErrorState) {
            return Center(
              child: Text(state.error, style: customStyle),
            );
          }
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Save address',
                style: customStyle,
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      if (listAddress.isNotEmpty) {
                        context.read<RegisterBloc>().add(SaveAdressEvent(
                            localModel: LocalModel(
                                title: titleController.text.trim(),
                                description: descController.text.trim(),
                                lat: listAddress.first.lat,
                                lot: listAddress.first.lot)));
                      }
                    },
                    child: Text(
                      'save',
                      style: customStyle,
                    ))
              ],
            ),
            body: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: SizedBox(
                height: _pageSize - (_notifySize),
                child: Column(
                  children: [
                    SizedBox(
                      width: size.width,
                      child: Column(
                        children: [
                          MyTextFieldWidget(
                            model: TextFieldModel(
                                controller: titleController,
                                hintText: 'Enter product title',
                                obscureText: false,
                                isNeed: false),
                            text: 'Title',
                            maxLine: 1,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          MyTextFieldWidget(
                            model: TextFieldModel(
                                controller: descController,
                                hintText: 'Enter the description',
                                obscureText: false,
                                isNeed: false),
                            text: 'Description',
                            maxLine: 8,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 12),
                            child: Row(
                              children: [
                                const Expanded(
                                    child: Divider(
                                  thickness: 1,
                                )),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  child: Text(
                                    'Change Location'.tr(),
                                    style: customStyle,
                                  ),
                                ),
                                const Expanded(
                                    child: Divider(
                                  thickness: 1,
                                ))
                              ],
                            ),
                          ),
                          MyTextFieldWidget(
                            model: TextFieldModel(
                                controller: addressController,
                                hintText: 'Enter address',
                                obscureText: false,
                                isNeed: false),
                            text: 'Address by location',
                            maxLine: 1,
                          ),
                          const SizedBox(
                            height: 28,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          YandexMap(
                            mode2DEnabled: true,
                            mapType: MapType.map,
                            fastTapEnabled: true,
                            mapObjects: list,
                            onMapCreated: (YandexMapController controller) {
                              yandexMapController = controller;
                            },
                            onMapTap: (Point point) async {
                              try {
                                final placemarks =
                                    await placemarkFromCoordinates(
                                        point.latitude, point.longitude,
                                        localeIdentifier: "en");
                                setState(() {
                                  listAddress.clear();
                                  listAddress.add(LocalModel(
                                      title: placemarks.first.name!,
                                      description: placemarks.first.street!,
                                      lat: point.latitude,
                                      lot: point.longitude));
                                  descController.text =
                                      placemarks.first.street!;
                                  titleController.text = placemarks.first.name!;
                                  addressController.text =
                                      placemarks.first.administrativeArea!;
                                  showBottomFunc(context,
                                      '${placemarks.first.name},${placemarks.first.administrativeArea},${point.latitude},${point.longitude}',point.latitude,point.longitude);
                                  print(
                                      'Titlecontroller=${titleController.text.trim()}');
                                  print(
                                      'DESCRIPTIONCONTROLLER=${descController.text.trim()}');
                                  print(
                                      'ADDRESSCONTROLLER=${addressController.text.trim()}');
                                });
                              } catch (e) {
                                print(e);
                              }
                            },
                            onObjectTap: (GeoObject object) {
                              print('Ishlavotti');
                              print('OBJECT NAME=${object.name}');
                            },
                          ),
                          Positioned(
                            bottom: 80,
                            right: 20,
                            child: IconButton(
                              icon: const Icon(
                                Icons.my_location,
                                color: Colors.black54,
                                size: 32,
                              ),
                              onPressed: () async {
                                await _getCurrentLocation();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  _getCurrentLocation() async {
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    setState(() {
      list.add(
        PlacemarkMapObject(
          mapId: const MapObjectId('SALOM Tashkent'),
          point:
              Point(longitude: position.longitude, latitude: position.latitude),
          isVisible: true,
          isDraggable: true,
          icon: PlacemarkIcon.single(
            PlacemarkIconStyle(
              scale: 0.05,
              image: BitmapDescriptor.fromAssetImage(
                'assets/images/location.png',
              ),
            ),
          ),
        ),
      );
    });

    print(position);
    print('list=====$list');
    await _moveToCurrentLocation(position);
  }

  Future<void> _moveToCurrentLocation(
    Position position,
  ) async {
    await yandexMapController!.moveCamera(
      animation: const MapAnimation(
        type: MapAnimationType.linear,
        duration: 1,
      ),
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: Point(
            latitude: position.latitude,
            longitude: position.longitude,
          ),
          zoom: zoomLevel,
        ),
      ),
    );
    //   await yandexMapController!.getFocusRegion();
    await yandexMapController!.toggleTrafficLayer(visible: true);
  }
}
