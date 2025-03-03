import 'package:bridgify/accessories/post/build_picture.dart';
import 'package:bridgify/models/post_response_model.dart';
import 'package:bridgify/services/api_service.dart';
import 'package:flutter/material.dart';

class BuildPost extends StatefulWidget {
  const BuildPost({
    super.key,
  });

  @override
  _BuildPostState createState() => _BuildPostState();
}

class _BuildPostState extends State<BuildPost> {
  List<String> dropDownValue = ['My Elderly', 'General'];
  final ScrollController _scrollController = ScrollController();
  String? currentItem;

  @override
  void initState() {
    super.initState();

    setState(() {
      currentItem = dropDownValue[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 12.0, bottom: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "My Posts",
                style: TextStyle(
                  color: Colors.grey.shade800,
                  fontFamily: "Sofia",
                  fontSize: 20,
                ),
              ),
              const SizedBox(width: 35),
              Container(
                width: 165,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
                child: DropdownButtonFormField<String>(
                  icon: Icon(
                    Icons.filter_alt,
                    color: Colors.grey.shade600,
                  ),
                  value: currentItem,
                  onChanged: (value) {
                    setState(() {
                      currentItem = value;
                    });
                    _scrollController.animateTo(0.0,
                        duration: const Duration(milliseconds: 1),
                        curve: Curves.easeInOut);
                  },
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14.0,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  items: dropDownValue.map((value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Row(
                        children: [
                          value == 'My Elderly'
                              ? Icon(
                                  Icons.elderly,
                                  color: Colors.grey.shade600,
                                )
                              : Icon(Icons.group, color: Colors.grey.shade600),
                          const SizedBox(width: 5),
                          Text(
                            value,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontFamily: 'Sofia',
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
        if (currentItem == dropDownValue[0])
          FutureBuilder(
            future: APIService.getPostsByUser(),
            builder: (
              BuildContext context,
              AsyncSnapshot<List<PostResponseModel>?> model,
            ) {
              if (model.hasData) {
                return Expanded(
                  flex: 2,
                  child: ListView.builder(
                    controller: _scrollController,
                    shrinkWrap: false,
                    physics: const ClampingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.all(0),
                    itemCount: model.data!.length,
                    itemBuilder: (context, index) {
                      return BuildPicture(
                          model: model.data![model.data!.length - 1 - index]);
                    },
                  ),
                );
              } else {
                return Expanded(
                  flex: 2,
                  child: ListView(
                    controller: _scrollController,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 80.0),
                        child: Center(
                          child: Text(
                            "No relevant post found at the moment",
                            style: TextStyle(
                                color: Colors.grey.shade800, fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        if (currentItem == dropDownValue[1])
          FutureBuilder(
            future: APIService.getPostsByNoElderlyInvolved(),
            builder: (
              BuildContext context,
              AsyncSnapshot<List<PostResponseModel>?> model,
            ) {
              if (model.hasData) {
                if (model.data!.isEmpty) {
                  return Expanded(
                    flex: 2,
                    child: ListView(
                      controller: _scrollController,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 80.0),
                          child: Center(
                            child: Text(
                              "No relevant post found at the moment",
                              style: TextStyle(
                                  color: Colors.grey.shade800, fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Expanded(
                    flex: 2,
                    child: ListView.builder(
                      controller: _scrollController,
                      shrinkWrap: false,
                      physics: const ClampingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      padding: const EdgeInsets.all(0),
                      itemCount: model.data!.length,
                      itemBuilder: (context, index) {
                        return BuildPicture(
                            model: model.data![model.data!.length - 1 - index]);
                      },
                    ),
                  );
                }
              }
              return Expanded(
                flex: 2,
                child: ListView(
                  controller: _scrollController,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 80.0),
                      child: Center(
                        child: Text(
                          "No relevant post found at the moment",
                          style: TextStyle(
                              color: Colors.grey.shade800, fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
      ],
    );
  }
}
