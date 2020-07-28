import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

final FirebaseMessaging firebaseMessaging = FirebaseMessaging();

int totalSteps = 5;
int currentStep = 0;

double yielding() => ++currentStep / totalSteps;

Stream<double> initializeApplication() async* {
  yield yielding();
  await firebaseMessaging.requestNotificationPermissions(
    const IosNotificationSettings(
        sound: true, badge: true, alert: true, provisional: false),
  );
  yield yielding();
  final remoteConfig = await RemoteConfig.instance;
  yield yielding();
  await remoteConfig.fetch(expiration: const Duration(hours: 5));
  yield yielding();
  await remoteConfig.activateFetched();
  yield yielding();
}
