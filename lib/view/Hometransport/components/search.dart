import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ridemate/Providers/Homeprovider/homeprovider.dart';
import 'package:ridemate/widgets/spacing.dart';

import '../../../widgets/customtext.dart';

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
                autofocus: true,
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
            Consumer<Homeprovider>(
              builder: (context, value, child) =>
                  value.message == 'nothingfound'
                      ? Column(
                          children: [
                            Image.asset('assets/nodata.png'),
                            const CustomText(
                              title: 'Not Found',
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                            const CustomText(
                              title:
                                  'Sorry, the keyword you entered cannot be\n found, please check again or search with\n another keyword',
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        )
                      : Expanded(
                          child: ListView.builder(
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
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
