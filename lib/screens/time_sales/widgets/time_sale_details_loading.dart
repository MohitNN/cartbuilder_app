import 'package:flutter/material.dart';
import 'package:mint_bird_app/widgets/shimmer_loading_card.dart';

Widget timeSaleDetailsLoading() {
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          shimmerLoadingCard(height: 15),
          SizedBox(
            height: 10,
          ),
          shimmerLoadingCard(height: 40, radius: 8),
          SizedBox(
            height: 15,
          ),
          shimmerLoadingCard(height: 15),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Expanded(child: shimmerLoadingCard(height: 45, radius: 6)),
              SizedBox(
                width: 16,
              ),
              Expanded(child: shimmerLoadingCard(height: 45, radius: 6)),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          shimmerLoadingCard(height: 45, radius: 8),
          SizedBox(
            height: 15,
          ),
          shimmerLoadingCard(height: 45, radius: 8),
          SizedBox(
            height: 15,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: shimmerLoadingCard(height: 45, width: 150),
          ),
          SizedBox(
            height: 15,
          ),
          shimmerLoadingCard(height: 15),
          SizedBox(
            height: 10,
          ),
          shimmerLoadingCard(height: 45, radius: 8),
          SizedBox(
            height: 10,
          ),
          GridView.builder(
              shrinkWrap: true,
              itemCount: 8,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  childAspectRatio: 2.4,
                  crossAxisSpacing: 16),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    shimmerLoadingCard(height: 15),
                    SizedBox(
                      height: 10,
                    ),
                    shimmerLoadingCard(height: 45, radius: 8)
                  ],
                );
              })
        ],
      ),
    ),
  );
}
