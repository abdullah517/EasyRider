import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ridemate/Providers/Homeprovider/homeprovider.dart';
import 'package:ridemate/widgets/spacing.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    final myprovider = Provider.of<Homeprovider>(context, listen: false);
    controller.addListener(() {
      myprovider.changeiconvisibility(controller.text.length);
      myprovider.getsuggesstion(controller.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            addVerticalspace(height: 42),
            Consumer<Homeprovider>(
              builder: (context, myprovider, child) => TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: 'Search your destination',
                  prefixIcon: const Icon(Icons.location_on),
                  suffixIcon: myprovider.showicon
                      ? IconButton(
                          onPressed: () {
                            controller.clear();
                          },
                          icon: const Icon(Icons.close))
                      : null,
                  fillColor: const Color(0xfffff1b1),
                  filled: true,
                  border: const OutlineInputBorder(),
                ),
              ),
            ),
            Expanded(
                child: Consumer<Homeprovider>(
              builder: (context, value, child) => ListView.builder(
                itemCount: value.suggestionlist.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(value.suggestionlist[index]),
                    leading: const Icon(Icons.location_on),
                    onTap: () {
                      controller.text = value.suggestionlist[index];
                    },
                  );
                },
              ),
            )),
          ],
        ),
      ),
    );
  }
}
