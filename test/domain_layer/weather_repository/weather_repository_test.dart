// ignore_for_file: prefer_const_constructors
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:weather/data_layer/data_layer.dart';
// import 'package:weather/data_layer/data_layer.dart' as open_meteo_api;
import 'package:weather/domain_layer/domain_layer.dart';

class MockOpenMeteoApiClient extends Mock implements OpenMeteoApiClient {}

class MockLocation extends Mock implements Location {}

class MockWeather extends Mock implements WeatherDataLayer {}

void main() {
  group('WeatherRepository', () {
    late OpenMeteoApiClient weatherApiClient;
    late WeatherRepository weatherRepository;

    setUp(() {
      weatherApiClient = MockOpenMeteoApiClient();
      weatherRepository = WeatherRepository(
        weatherApiClient: weatherApiClient,
      );
    });

    group('constructor', () {
      test('instantiates internal weather api client when not injected', () {
        expect(WeatherRepository(), isNotNull);
      });
    });

    group('getWeather |', () {
      //arrange
      const city = 'chicago';
      const latitude = 41.85003;
      const longitude = -87.65005;

      test('calls locationSearch with correct city', () async {
        // act
        try {
          await weatherRepository.getWeather(city);
        } catch (_) {}
        // assert
        verify(() => weatherApiClient.locationSearch(city)).called(1);
      });

      test('throws when locationSearch fails', () async {
        // arrange
        final exception = Exception('oops');
        when(() => weatherApiClient.locationSearch(any())).thenThrow(exception);
        // act & assert
        expect(
          () async => weatherRepository.getWeather(city),
          throwsA(exception),
        );
      });

      test('calls getWeather with correct latitude/longitude', () async {
        //arrange
        final location = MockLocation();
        when(() => location.latitude).thenReturn(latitude);
        when(() => location.longitude).thenReturn(longitude);
        when(() => weatherApiClient.locationSearch(any())).thenAnswer(
          (_) async => location,
        );
        //act
        try {
          await weatherRepository.getWeather(city);
        } catch (_) {}
        //assert
        verify(
          () => weatherApiClient.getWeather(
            latitude: latitude,
            longitude: longitude,
          ),
        ).called(1);
      });

      test('throws when getWeather fails', () async {
        //arrange
        final exception = Exception('oops');
        final location = MockLocation();
        when(() => location.latitude).thenReturn(latitude);
        when(() => location.longitude).thenReturn(longitude);
        when(() => weatherApiClient.locationSearch(any())).thenAnswer(
          (_) async => location,
        );
        when(
          () => weatherApiClient.getWeather(
            latitude: any(named: 'latitude'),
            longitude: any(named: 'longitude'),
          ),
        ).thenThrow(exception);
        //act & assert
        expect(
          () async => weatherRepository.getWeather(city),
          throwsA(exception),
        );
      });

      test('returns correct weather on success (clear)', () async {
        //arrange
        final location = MockLocation();
        final weather = MockWeather();
        when(() => location.name).thenReturn(city);
        when(() => location.latitude).thenReturn(latitude);
        when(() => location.longitude).thenReturn(longitude);
        when(() => weather.temperature).thenReturn(42.42);
        when(() => weather.weatherCode).thenReturn(0);
        when(() => weatherApiClient.locationSearch(any())).thenAnswer(
          (_) async => location,
        );
        when(
          () => weatherApiClient.getWeather(
            latitude: any(named: 'latitude'),
            longitude: any(named: 'longitude'),
          ),
        ).thenAnswer((_) async => weather);
        //act
        final actual = await weatherRepository.getWeather(city);
        //assert
        expect(
          actual,
          WeatherDomainLayer(
            temperature: 42.42,
            location: city,
            condition: WeatherCondition.clear,
          ),
        );
      });

      test('returns correct weather on success (cloudy)', () async {
        //arrange
        final location = MockLocation();
        final weather = MockWeather();
        when(() => location.name).thenReturn(city);
        when(() => location.latitude).thenReturn(latitude);
        when(() => location.longitude).thenReturn(longitude);
        when(() => weather.temperature).thenReturn(42.42);
        when(() => weather.weatherCode).thenReturn(1);
        when(() => weatherApiClient.locationSearch(any())).thenAnswer(
          (_) async => location,
        );
        when(
          () => weatherApiClient.getWeather(
            latitude: any(named: 'latitude'),
            longitude: any(named: 'longitude'),
          ),
        ).thenAnswer((_) async => weather);
        //act
        final actual = await weatherRepository.getWeather(city);
        //assert
        expect(
          actual,
          WeatherDomainLayer(
            temperature: 42.42,
            location: city,
            condition: WeatherCondition.cloudy,
          ),
        );
      });

      test('returns correct weather on success (rainy)', () async {
        // arrange
        final location = MockLocation();
        final weather = MockWeather();
        when(() => location.name).thenReturn(city);
        when(() => location.latitude).thenReturn(latitude);
        when(() => location.longitude).thenReturn(longitude);
        when(() => weather.temperature).thenReturn(42.42);
        when(() => weather.weatherCode).thenReturn(51);
        when(() => weatherApiClient.locationSearch(any())).thenAnswer(
          (_) async => location,
        );
        when(
          () => weatherApiClient.getWeather(
            latitude: any(named: 'latitude'),
            longitude: any(named: 'longitude'),
          ),
        ).thenAnswer((_) async => weather);
        //act
        final actual = await weatherRepository.getWeather(city);
        //assert
        expect(
          actual,
          WeatherDomainLayer(
            temperature: 42.42,
            location: city,
            condition: WeatherCondition.rainy,
          ),
        );
      });

      test('returns correct weather on success (snowy)', () async {
        //arrange
        final location = MockLocation();
        final weather = MockWeather();
        when(() => location.name).thenReturn(city);
        when(() => location.latitude).thenReturn(latitude);
        when(() => location.longitude).thenReturn(longitude);
        when(() => weather.temperature).thenReturn(42.42);
        when(() => weather.weatherCode).thenReturn(71);
        when(() => weatherApiClient.locationSearch(any())).thenAnswer(
          (_) async => location,
        );
        when(
          () => weatherApiClient.getWeather(
            latitude: any(named: 'latitude'),
            longitude: any(named: 'longitude'),
          ),
        ).thenAnswer((_) async => weather);
        //act
        final actual = await weatherRepository.getWeather(city);
        //assert
        expect(
          actual,
          WeatherDomainLayer(
            temperature: 42.42,
            location: city,
            condition: WeatherCondition.snowy,
          ),
        );
      });

      test('returns correct weather on success (unknown)', () async {
        //arrange
        final location = MockLocation();
        final weather = MockWeather();
        when(() => location.name).thenReturn(city);
        when(() => location.latitude).thenReturn(latitude);
        when(() => location.longitude).thenReturn(longitude);
        when(() => weather.temperature).thenReturn(42.42);
        when(() => weather.weatherCode).thenReturn(-1);
        when(() => weatherApiClient.locationSearch(any())).thenAnswer(
          (_) async => location,
        );
        when(
          () => weatherApiClient.getWeather(
            latitude: any(named: 'latitude'),
            longitude: any(named: 'longitude'),
          ),
        ).thenAnswer((_) async => weather);
        //act
        final actual = await weatherRepository.getWeather(city);
        //assert
        expect(
          actual,
          WeatherDomainLayer(
            temperature: 42.42,
            location: city,
            condition: WeatherCondition.unknown,
          ),
        );
      });
    });
  });
}
