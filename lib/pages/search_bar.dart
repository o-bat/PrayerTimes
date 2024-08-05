import 'package:flutter/material.dart';
import 'package:prayer_times/pages/searched_times.dart';
import 'package:prayer_times/services/http.dart';

class SearchBarPage extends StatefulWidget {
  const SearchBarPage({super.key});

  @override
  State<SearchBarPage> createState() => _SearchBarPageState();
}

class _SearchBarPageState extends State<SearchBarPage> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search for a Country or a City"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Enter country or city name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
              ),
              controller: controller,
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: getSuggestion(controller.text),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return const Center(child: Text("No suggestions found"));
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("No suggestions found"));
                }

                return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SearchedTimes(
                                  lat: double.parse(
                                      snapshot.data![index].lat.toString()),
                                  lon: double.parse(
                                      snapshot.data![index].lon.toString())),
                            ));
                      },
                      title: Text(snapshot.data?[index].displayName ?? ""),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
