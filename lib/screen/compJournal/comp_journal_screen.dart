import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mom_dance/bottomSheet/comp/comp_bottom_sheet.dart';
import 'package:mom_dance/helper/image_loader_widget.dart';
import 'package:mom_dance/helper/simple_header.dart';
import 'package:mom_dance/helper/text_widget.dart';
import 'package:mom_dance/model/compJournal/comp_journal_model.dart';
import 'package:mom_dance/provider/user/user_provider.dart';
import 'package:mom_dance/services/compJornal/comp_journal_services.dart';
import 'package:provider/provider.dart';
import '../../constant.dart';
import '../../provider/dancer/dancer_provider.dart';

class CompJournalScreen extends StatelessWidget {
  CompJournalScreen({super.key});

  final dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments as Map<String, dynamic>? ?? {};
    final provider = Provider.of<UserProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: lightGrey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const SimpleHeader(text: "Competition Journal"),
                SizedBox(
                  width: Get.width,
                  height: Get.width * 0.450,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: ImageLoaderWidget(
                      imageUrl: provider.compJournal.toString(),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Consumer<DancerProvider>(
                  builder: (context, productProvider, child) {
                    return StreamBuilder<List<CompJournalModel>>(
                      stream: productProvider.getCompJournal(
                          dancerID: arguments['id'] ?? ""),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        }
                        if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const Center(
                              child: Text('No Comp Journal found'));
                        }

                        List<CompJournalModel> compJournal = snapshot.data!;
                        return ListView.builder(
                          itemCount: compJournal.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            CompJournalModel model = compJournal[index];
                            log("message${model.date}");
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                color: Colors.white,
                                child: Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        gradient: gradientColor,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          for (var label in [
                                            "Date",
                                            "Competition",
                                            "Dance",
                                            "Adjudication",
                                            "Overall",
                                            "Specialty Award"
                                          ])
                                            Container(
                                              padding:
                                              const EdgeInsets.all(5.0),
                                              child: TextWidget(
                                                text: label,
                                                size: 12.0,
                                                color: Colors.white,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          showCustomDialog(
                                            onDelete: () async {
                                              await CompJournalServices()
                                                  .deleteCompJournal(
                                                id: model.id.toString(),
                                                dancerID: model.dancerId
                                                    .toString(),
                                                context: context,
                                              );
                                              Navigator.pop(context);
                                            },
                                            onDetails: () {},
                                            isThird: false,
                                            onEdit: () {
                                              Navigator.pop(context);
                                              Get.bottomSheet(CompBottomSheet(
                                                id: model.id,
                                                comp: model.comp,
                                                dance: model.dance,
                                                adjuction: model.adjuction,
                                                overAll: model.overAll,
                                                special: model.special,
                                                date: model.date,
                                                compID: model.id,
                                                dancerID: model.dancerId,
                                                type: 'edit',
                                              ));
                                            },
                                          );
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding:
                                              const EdgeInsets.all(5.0),
                                              child: TextWidget(
                                                text: model.date,
                                                size: 12.0,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Container(
                                              padding:
                                              const EdgeInsets.all(5.0),
                                              child: TextWidget(
                                                text: model.comp,
                                                size: 12.0,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Container(
                                              padding:
                                              const EdgeInsets.all(5.0),
                                              child: TextWidget(
                                                text: model.dance,
                                                size: 12.0,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Container(
                                              padding:
                                              const EdgeInsets.all(5.0),
                                              child: TextWidget(
                                                text: model.adjuction,
                                                size: 12.0,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Container(
                                              padding:
                                              const EdgeInsets.all(5.0),
                                              child: TextWidget(
                                                text: model.overAll,
                                                size: 12.0,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Container(
                                              padding:
                                              const EdgeInsets.all(5.0),
                                              child: TextWidget(
                                                text: model.special,
                                                size: 12.0,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.bottomSheet(CompBottomSheet(id: arguments['id'] ?? "null"));
        },
        tooltip: 'Add Competition Journal',
        backgroundColor: primaryColor,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
