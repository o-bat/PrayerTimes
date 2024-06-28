// To parse this JSON data, do
//
//     final calendar = calendarFromJson(jsonString);

import 'dart:convert';

Calendar calendarFromJson(String str) => Calendar.fromJson(json.decode(str));

String calendarToJson(Calendar data) => json.encode(data.toJson());

class Calendar {
  int code;
  String status;
  List<Datum> data;

  Calendar({
    required this.code,
    required this.status,
    required this.data,
  });

  factory Calendar.fromJson(Map<String, dynamic> json) => Calendar(
        code: json["code"],
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Timings timings;
  Date date;
  Meta meta;

  Datum({
    required this.timings,
    required this.date,
    required this.meta,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        timings: Timings.fromJson(json["timings"]),
        date: Date.fromJson(json["date"]),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "timings": timings.toJson(),
        "date": date.toJson(),
        "meta": meta.toJson(),
      };
}

class Date {
  String readable;
  String timestamp;
  Gregorian gregorian;
  Hijri hijri;

  Date({
    required this.readable,
    required this.timestamp,
    required this.gregorian,
    required this.hijri,
  });

  factory Date.fromJson(Map<String, dynamic> json) => Date(
        readable: json["readable"],
        timestamp: json["timestamp"],
        gregorian: Gregorian.fromJson(json["gregorian"]),
        hijri: Hijri.fromJson(json["hijri"]),
      );

  Map<String, dynamic> toJson() => {
        "readable": readable,
        "timestamp": timestamp,
        "gregorian": gregorian.toJson(),
        "hijri": hijri.toJson(),
      };
}

class Gregorian {
  String date;
  Format format;
  String day;
  GregorianWeekday weekday;
  GregorianMonth month;
  String year;
  Designation designation;

  Gregorian({
    required this.date,
    required this.format,
    required this.day,
    required this.weekday,
    required this.month,
    required this.year,
    required this.designation,
  });

  factory Gregorian.fromJson(Map<String, dynamic> json) => Gregorian(
        date: json["date"],
        format: formatValues.map[json["format"]]!,
        day: json["day"],
        weekday: GregorianWeekday.fromJson(json["weekday"]),
        month: GregorianMonth.fromJson(json["month"]),
        year: json["year"],
        designation: Designation.fromJson(json["designation"]),
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "format": formatValues.reverse[format],
        "day": day,
        "weekday": weekday.toJson(),
        "month": month.toJson(),
        "year": year,
        "designation": designation.toJson(),
      };
}

class Designation {
  Abbreviated abbreviated;
  Expanded expanded;

  Designation({
    required this.abbreviated,
    required this.expanded,
  });

  factory Designation.fromJson(Map<String, dynamic> json) => Designation(
        abbreviated: abbreviatedValues.map[json["abbreviated"]]!,
        expanded: expandedValues.map[json["expanded"]]!,
      );

  Map<String, dynamic> toJson() => {
        "abbreviated": abbreviatedValues.reverse[abbreviated],
        "expanded": expandedValues.reverse[expanded],
      };
}

enum Abbreviated { AD, AH }

final abbreviatedValues =
    EnumValues({"AD": Abbreviated.AD, "AH": Abbreviated.AH});

enum Expanded { ANNO_DOMINI, ANNO_HEGIRAE }

final expandedValues = EnumValues({
  "Anno Domini": Expanded.ANNO_DOMINI,
  "Anno Hegirae": Expanded.ANNO_HEGIRAE
});

enum Format { DD_MM_YYYY }

final formatValues = EnumValues({"DD-MM-YYYY": Format.DD_MM_YYYY});

class GregorianMonth {
  int number;
  PurpleEn en;

  GregorianMonth({
    required this.number,
    required this.en,
  });

  factory GregorianMonth.fromJson(Map<String, dynamic> json) => GregorianMonth(
        number: json["number"],
        en: purpleEnValues.map[json["en"]]!,
      );

  Map<String, dynamic> toJson() => {
        "number": number,
        "en": purpleEnValues.reverse[en],
      };
}

enum PurpleEn { JUNE }

final purpleEnValues = EnumValues({"June": PurpleEn.JUNE});

class GregorianWeekday {
  String en;

  GregorianWeekday({
    required this.en,
  });

  factory GregorianWeekday.fromJson(Map<String, dynamic> json) =>
      GregorianWeekday(
        en: json["en"],
      );

  Map<String, dynamic> toJson() => {
        "en": en,
      };
}

class Hijri {
  String date;
  Format format;
  String day;
  HijriWeekday weekday;
  HijriMonth month;
  String year;
  Designation designation;
  List<String> holidays;

  Hijri({
    required this.date,
    required this.format,
    required this.day,
    required this.weekday,
    required this.month,
    required this.year,
    required this.designation,
    required this.holidays,
  });

  factory Hijri.fromJson(Map<String, dynamic> json) => Hijri(
        date: json["date"],
        format: formatValues.map[json["format"]]!,
        day: json["day"],
        weekday: HijriWeekday.fromJson(json["weekday"]),
        month: HijriMonth.fromJson(json["month"]),
        year: json["year"],
        designation: Designation.fromJson(json["designation"]),
        holidays: List<String>.from(json["holidays"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "format": formatValues.reverse[format],
        "day": day,
        "weekday": weekday.toJson(),
        "month": month.toJson(),
        "year": year,
        "designation": designation.toJson(),
        "holidays": List<dynamic>.from(holidays.map((x) => x)),
      };
}

class HijriMonth {
  int number;
  FluffyEn en;
  Ar ar;

  HijriMonth({
    required this.number,
    required this.en,
    required this.ar,
  });

  factory HijriMonth.fromJson(Map<String, dynamic> json) => HijriMonth(
        number: json["number"],
        en: fluffyEnValues.map[json["en"]]!,
        ar: arValues.map[json["ar"]]!,
      );

  Map<String, dynamic> toJson() => {
        "number": number,
        "en": fluffyEnValues.reverse[en],
        "ar": arValues.reverse[ar],
      };
}

enum Ar { AR, EMPTY }

final arValues = EnumValues({"ذوالحجة": Ar.AR, "ذوالقعدة": Ar.EMPTY});

enum FluffyEn { DH_AL_IJJAH, DH_AL_QA_DAH }

final fluffyEnValues = EnumValues({
  "Dhū al-Ḥijjah": FluffyEn.DH_AL_IJJAH,
  "Dhū al-Qaʿdah": FluffyEn.DH_AL_QA_DAH
});

class HijriWeekday {
  String en;
  String ar;

  HijriWeekday({
    required this.en,
    required this.ar,
  });

  factory HijriWeekday.fromJson(Map<String, dynamic> json) => HijriWeekday(
        en: json["en"],
        ar: json["ar"],
      );

  Map<String, dynamic> toJson() => {
        "en": en,
        "ar": ar,
      };
}

class Meta {
  int latitude;
  int longitude;
  Timezone timezone;
  Method method;
  LatitudeAdjustmentMethod latitudeAdjustmentMethod;
  MidnightMode midnightMode;
  MidnightMode school;
  Map<String, int> offset;

  Meta({
    required this.latitude,
    required this.longitude,
    required this.timezone,
    required this.method,
    required this.latitudeAdjustmentMethod,
    required this.midnightMode,
    required this.school,
    required this.offset,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        latitude: json["latitude"],
        longitude: json["longitude"],
        timezone: timezoneValues.map[json["timezone"]]!,
        method: Method.fromJson(json["method"]),
        latitudeAdjustmentMethod: latitudeAdjustmentMethodValues
            .map[json["latitudeAdjustmentMethod"]]!,
        midnightMode: midnightModeValues.map[json["midnightMode"]]!,
        school: midnightModeValues.map[json["school"]]!,
        offset:
            Map.from(json["offset"]).map((k, v) => MapEntry<String, int>(k, v)),
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
        "timezone": timezoneValues.reverse[timezone],
        "method": method.toJson(),
        "latitudeAdjustmentMethod":
            latitudeAdjustmentMethodValues.reverse[latitudeAdjustmentMethod],
        "midnightMode": midnightModeValues.reverse[midnightMode],
        "school": midnightModeValues.reverse[school],
        "offset":
            Map.from(offset).map((k, v) => MapEntry<String, dynamic>(k, v)),
      };
}

enum LatitudeAdjustmentMethod { ANGLE_BASED }

final latitudeAdjustmentMethodValues =
    EnumValues({"ANGLE_BASED": LatitudeAdjustmentMethod.ANGLE_BASED});

class Method {
  int id;
  Name name;
  Params params;
  Location location;

  Method({
    required this.id,
    required this.name,
    required this.params,
    required this.location,
  });

  factory Method.fromJson(Map<String, dynamic> json) => Method(
        id: json["id"],
        name: nameValues.map[json["name"]]!,
        params: Params.fromJson(json["params"]),
        location: Location.fromJson(json["location"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": nameValues.reverse[name],
        "params": params.toJson(),
        "location": location.toJson(),
      };
}

class Location {
  double latitude;
  double longitude;

  Location({
    required this.latitude,
    required this.longitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
      };
}

enum Name { DIYANET_LERI_BAKANL_TURKEY_EXPERIMENTAL }

final nameValues = EnumValues({
  "Diyanet İşleri Başkanlığı, Turkey (experimental)":
      Name.DIYANET_LERI_BAKANL_TURKEY_EXPERIMENTAL
});

class Params {
  int fajr;
  int isha;

  Params({
    required this.fajr,
    required this.isha,
  });

  factory Params.fromJson(Map<String, dynamic> json) => Params(
        fajr: json["Fajr"],
        isha: json["Isha"],
      );

  Map<String, dynamic> toJson() => {
        "Fajr": fajr,
        "Isha": isha,
      };
}

enum MidnightMode { STANDARD }

final midnightModeValues = EnumValues({"STANDARD": MidnightMode.STANDARD});

enum Timezone { EUROPE_BERLIN }

final timezoneValues = EnumValues({"Europe/Berlin": Timezone.EUROPE_BERLIN});

class Timings {
  Fajr fajr;
  Sunrise sunrise;
  String dhuhr;
  String asr;
  String sunset;
  String maghrib;
  String isha;
  Imsak imsak;
  String midnight;
  String firstthird;
  Lastthird lastthird;

  Timings({
    required this.fajr,
    required this.sunrise,
    required this.dhuhr,
    required this.asr,
    required this.sunset,
    required this.maghrib,
    required this.isha,
    required this.imsak,
    required this.midnight,
    required this.firstthird,
    required this.lastthird,
  });

  factory Timings.fromJson(Map<String, dynamic> json) => Timings(
        fajr: fajrValues.map[json["Fajr"]]!,
        sunrise: sunriseValues.map[json["Sunrise"]]!,
        dhuhr: json["Dhuhr"],
        asr: json["Asr"],
        sunset: json["Sunset"],
        maghrib: json["Maghrib"],
        isha: json["Isha"],
        imsak: imsakValues.map[json["Imsak"]]!,
        midnight: json["Midnight"],
        firstthird: json["Firstthird"],
        lastthird: lastthirdValues.map[json["Lastthird"]]!,
      );

  Map<String, dynamic> toJson() => {
        "Fajr": fajrValues.reverse[fajr],
        "Sunrise": sunriseValues.reverse[sunrise],
        "Dhuhr": dhuhr,
        "Asr": asr,
        "Sunset": sunset,
        "Maghrib": maghrib,
        "Isha": isha,
        "Imsak": imsakValues.reverse[imsak],
        "Midnight": midnight,
        "Firstthird": firstthird,
        "Lastthird": lastthirdValues.reverse[lastthird],
      };
}

enum Fajr {
  THE_0304_CEST,
  THE_0305_CEST,
  THE_0306_CEST,
  THE_0307_CEST,
  THE_0308_CEST
}

final fajrValues = EnumValues({
  "03:04 (CEST)": Fajr.THE_0304_CEST,
  "03:05 (CEST)": Fajr.THE_0305_CEST,
  "03:06 (CEST)": Fajr.THE_0306_CEST,
  "03:07 (CEST)": Fajr.THE_0307_CEST,
  "03:08 (CEST)": Fajr.THE_0308_CEST
});

enum Imsak {
  THE_0254_CEST,
  THE_0255_CEST,
  THE_0256_CEST,
  THE_0257_CEST,
  THE_0258_CEST
}

final imsakValues = EnumValues({
  "02:54 (CEST)": Imsak.THE_0254_CEST,
  "02:55 (CEST)": Imsak.THE_0255_CEST,
  "02:56 (CEST)": Imsak.THE_0256_CEST,
  "02:57 (CEST)": Imsak.THE_0257_CEST,
  "02:58 (CEST)": Imsak.THE_0258_CEST
});

enum Lastthird {
  THE_0248_CEST,
  THE_0249_CEST,
  THE_0250_CEST,
  THE_0251_CEST,
  THE_0252_CEST
}

final lastthirdValues = EnumValues({
  "02:48 (CEST)": Lastthird.THE_0248_CEST,
  "02:49 (CEST)": Lastthird.THE_0249_CEST,
  "02:50 (CEST)": Lastthird.THE_0250_CEST,
  "02:51 (CEST)": Lastthird.THE_0251_CEST,
  "02:52 (CEST)": Lastthird.THE_0252_CEST
});

enum Sunrise {
  THE_0521_CEST,
  THE_0522_CEST,
  THE_0523_CEST,
  THE_0524_CEST,
  THE_0525_CEST
}

final sunriseValues = EnumValues({
  "05:21 (CEST)": Sunrise.THE_0521_CEST,
  "05:22 (CEST)": Sunrise.THE_0522_CEST,
  "05:23 (CEST)": Sunrise.THE_0523_CEST,
  "05:24 (CEST)": Sunrise.THE_0524_CEST,
  "05:25 (CEST)": Sunrise.THE_0525_CEST
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
