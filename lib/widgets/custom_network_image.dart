import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mcq/manager/image_manager.dart';

import '../core/app_urls.dart';



class CustomNetworkImage extends StatelessWidget {
  final String url;
  final double? height;
  final double? width;
  final String? fullUrl;
  final BoxFit? fit;
  const CustomNetworkImage({super.key, required this.url, this.height, this.width, this.fullUrl, this.fit});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: fullUrl ?? getImageUrl(endPoint: url),
      imageBuilder: (context, imageProvider) =>
           Image.network(fullUrl ?? getImageUrl(endPoint: url),height: height,width: width,
           fit: fit,),
      placeholder: (context, url) =>  Container(
        height: height,width: width,color: Colors.grey.withOpacity(0.2),
      ),
      errorWidget: (context, url, error) {
        // if (kDebugMode) {
        //   print("ERROR GETTING IMAGES IN CachedNetworkImage = $error and"
        //     " url ==${getImageUrl(endPoint: url)}");
        // }

       return  Center(child: Image.asset(appImages.exam,height: 50,));
      },
    );
  }
}
