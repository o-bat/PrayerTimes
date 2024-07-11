import 'package:flutter/material.dart';

import 'package:prayer_times/Components/provider.dart';
import 'package:prayer_times/models/model_calendar_daily.dart';
import 'package:prayer_times/pages/splash_screen.dart';
import 'package:alarm/alarm.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  AsyncSnapshot<CalendarDaily> snapshot;
  Settings({
    required this.snapshot,
    super.key,
  });

  @override
  State<Settings> createState() => _SettingsState();
}

List<String> methods = [
  "Shia Ithna-Ashari, Leva Institute, Qum",
  'University of Islamic Sciences, Karachi',
  'Islamic Society of North America (ISNA)',
  'Muslim World League',
  "Umm Al-Qura University, Makkah",
  "Egyptian General Authority of Survey",
  "Custom",
  "Institute of Geophysics, University of Tehran",
  "Gulf Region",
  "Kuwait",
  "Qatar",
  "Majlis Ugama Islam Singapura, Singapore",
  "Union Organization Islamic de France",
  "Diyanet İşleri Başkanliği, Turkey",
  "Spiritual Administration of Muslims of Russia",
  "Moonsighting Committee Worldwide ",
  "Dubai (experimental)",
  "Jabatan Kemajuan Islam Malaysia (JAKIM)",
  "Tunisia",
  "Algeria",
  "Kementerian Agama Republik Indonesia",
  "Morocco",
  "Comunidade Islamica de Lisboa",
  "Ministry of Awqaf, Islamic Affairs",
];

List<String> sounds = ["Notification Sound", "Adhan"];

bool fajrAlarm = true;

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Calculation Method",
            style:
                TextStyle(color: Theme.of(context).primaryColor, fontSize: 15),
          ),
          ListTile(
            onTap: () {},
            subtitle: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                onChanged: (value) {
                  setState(() {
                    context
                        .read<CMethodProvider>()
                        .changeCMethod(newCMethod: value!, list: methods);
                  });
                },
                items: methods
                    .map(
                      (method) => DropdownMenuItem<String>(
                        value: method,
                        child: Text(
                          method,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )
                    .toList(),
                value: methods[context.watch<CMethodProvider>().number],
              ),
            ),
          ),
          const Divider(),
          Text(
            "Alarms",
            style:
                TextStyle(color: Theme.of(context).primaryColor, fontSize: 15),
          ),
          ListTile(
              onTap: () {},
              title: const Text("Fajr"),
              subtitle: const Text("Set an Alarm for Fajr"),
              trailing: Switch(
                value: Provider.of<AlarmSettingsProvider>(context, listen: true)
                    .fajrAlarm,
                onChanged: (value) async {
                  Provider.of<AlarmSettingsProvider>(context, listen: false)
                      .changefajrAlarm(
                    newValue: value,
                    name: "fajrAlarm",
                  );
                  setState(() {});
                  initAlarms(widget.snapshot, context);
                },
              )),
          ListTile(
              onTap: () {},
              title: const Text("Dhuhr"),
              subtitle: const Text("Set an Alarm for Dhuhr"),
              trailing: Switch(
                value: Provider.of<AlarmSettingsProvider>(context, listen: true)
                    .dhuhrAlarm,
                onChanged: (value) async {
                  Provider.of<AlarmSettingsProvider>(context, listen: false)
                      .changeDhuhrAlarm(
                    newValue: value,
                    name: "dhuhrAlarm",
                  );
                  setState(() {});
                  initAlarms(widget.snapshot, context);
                },
              )),
          ListTile(
              onTap: () {},
              title: const Text("Asr"),
              subtitle: const Text("Set an Alarm for Asr"),
              trailing: Switch(
                value: Provider.of<AlarmSettingsProvider>(context, listen: true)
                    .asrAlarm,
                onChanged: (value) async {
                  Provider.of<AlarmSettingsProvider>(context, listen: false)
                      .changeAsrAlarm(
                    newValue: value,
                    name: "asrAlarm",
                  );
                  setState(() {});
                  initAlarms(widget.snapshot, context);
                },
              )),
          ListTile(
              onTap: () {},
              title: const Text("Maghrib"),
              subtitle: const Text("Set an Alarm for Maghrib"),
              trailing: Switch(
                value: Provider.of<AlarmSettingsProvider>(context, listen: true)
                    .maghribAlarm,
                onChanged: (value) async {
                  Provider.of<AlarmSettingsProvider>(context, listen: false)
                      .changeMaghribAlarm(
                    newValue: value,
                    name: "maghribAlarm",
                  );
                  setState(() {});
                  initAlarms(widget.snapshot, context);
                },
              )),
          ListTile(
            onTap: () {},
            title: const Text("Isha"),
            subtitle: const Text("Set an Alarm for Isha"),
            trailing: Switch(
              value: Provider.of<AlarmSettingsProvider>(context, listen: true)
                  .ishaAlarm,
              onChanged: (value) async {
                setState(() {
                  Provider.of<AlarmSettingsProvider>(context, listen: false)
                      .changeIshaAlarm(
                    newValue: value,
                    name: "ishaAlarm",
                  );
                });
                initAlarms(widget.snapshot, context);
              },
            ),
          ),
          ListTile(
            onTap: () {},
            title: const Text("Alarm Sound"),
            subtitle: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                onChanged: (value) async {
                  setState(() {
                    context
                        .read<AlarmSettingsProvider>()
                        .changeSound(newCMethod: value!, list: sounds);

                    initAlarms(widget.snapshot, context);
                  });

                },
                items: sounds
                    .map(
                      (method) => DropdownMenuItem<String>(
                        value: method,
                        child: Text(
                          method,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )
                    .toList(),
                value:
                    sounds[Provider.of<AlarmSettingsProvider>(context).number],
              ),
            ),
          )
        ],
      ),
    );
  }
}
