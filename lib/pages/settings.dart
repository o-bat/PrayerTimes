import 'package:flutter/material.dart';
import 'package:prayer_times/Components/provider.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

List<String> methods = [
  "Shia Ithna-Ashari, Leva Institute, Qum",
  'University of Islamic Sciences, Karachi"',
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
  "Diyanet İşleri Başkanliği, Turkey (experimental)",
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
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Card(
              child: SizedBox(
            child: SizedBox(
                child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
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
            )),
          )),
        ],
      ),
    );
  }
}
